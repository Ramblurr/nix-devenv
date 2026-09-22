# exoscale/ex

Typed `ExceptionInfo` values and keyword-based exception hierarchies. Use alone
with `try+`, or with [fmnoise/flow](fmnoise-flow.md) for error-as-value pipelines.

## Setup and quick reference

```clojure
;; deps.edn
exoscale/ex {:mvn/version "0.4.2"}

(require '[exoscale.ex :as ex])

(def missing (ex/ex-not-found "User not found" {:user-id 42}))
(ex/type? missing ::ex/not-found) ; => true
(ex-data missing) ; includes :user-id and :exoscale.ex/type
```

| Fully qualified call                                  | Input → output                                                                                                    |
|-------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| `(exoscale.ex/ex-not-found msg data)`                 | Message/data → typed `ExceptionInfo`, not thrown. Also accepts message alone or message/data/cause.               |
| `(exoscale.ex/ex-not-found! msg data)`                | Same arguments → constructs and throws exception.                                                                 |
| `(exoscale.ex/ex-type exception)`                     | Exception → keyword type, or `nil`.                                                                               |
| `(exoscale.ex/type data)`                             | Data map → `:exoscale.ex/type`, falling back to legacy `:type`.                                                   |
| `(exoscale.ex/type? exception type)`                  | Exception + keyword → truthy if exact type or descendant; may return `nil` when untyped.                          |
| `(exoscale.ex/derive child parent)`                   | Qualified keywords → updates library-local hierarchy. Configure at startup.                                       |
| `(exoscale.ex/catch exception type handler continue)` | Match → handler receives data; no match → continue receives original exception. Does not catch thrown exceptions. |
| `(exoscale.ex/try+ body... clauses...)`               | Macro: `try` plus keyword catch clauses that receive data. Normal class catches and `finally` remain available.   |
| `(exoscale.ex/datafy exception)`                      | Exception → data representation.                                                                                  |
| `(exoscale.ex/map->ex-info data)`                     | Serialized exception map → `ExceptionInfo`.                                                                       |

Constructor families: `ex-unavailable`, `ex-interrupted`, `ex-incorrect`,
`ex-forbidden`, `ex-unsupported`, `ex-not-found`, `ex-conflict`, `ex-fault`,
`ex-busy`; each also has a throwing `!` variant.

The general `exoscale.ex/ex-info` constructor is marked deprecated in the inspected
source. Prefer category constructors or `clojure.core/ex-info` with `::ex/type`.

## Categories and custom types

| Category (`:exoscale.ex/…`) | Meaning / response                                               |
|-----------------------------|------------------------------------------------------------------|
| `:unavailable`              | Service unavailable; restore health, retry.                      |
| `:interrupted`              | Operation interrupted; investigate interruption before retrying. |
| `:incorrect`                | Invalid input; fix caller.                                       |
| `:forbidden`                | Insufficient permission; fix credentials/access.                 |
| `:unsupported`              | Unsupported operation; change operation.                         |
| `:not-found`                | Missing resource; fix lookup.                                    |
| `:conflict`                 | Conflicting state; coordinate/reconcile.                         |
| `:fault`                    | Internal failure; fix callee.                                    |
| `:busy`                     | Overload; back off before retrying.                              |

Prefer a built-in category. Add a subtype only when callers need to distinguish it.
Use `ex/derive`, not `clojure.core/derive`: ex owns a separate hierarchy.

```clojure
(ex/derive ::missing-user ::ex/not-found)

(def missing-user
  (ex-info "User not found" {::ex/type ::missing-user :user-id 42}))

(ex/type? missing-user ::ex/not-found) ; => true
```

Keep data small, structured, and safe to log. Preserve the original exception as
`cause` when translating errors. Translate categories into HTTP statuses at the
application boundary rather than embedding transport policy in domain failures.

## Handling thrown exceptions with try+

```clojure
(ex/try+
  (throw missing-user)
  (catch :exoscale.ex/not-found {:keys [user-id]}
    {:status 404 :user-id user-id})
  (catch Exception e
    (throw e)))
;; => {:status 404 :user-id 42}
```

- Keyword catches handle `ExceptionInfo` and bind its **data**, not its exception.
- Keyword clauses are checked before class clauses, in keyword-clause order.
- Inside `try+`, `&ex` is the original exception. A handler's data metadata also
  contains `:exoscale.ex/exception`.
- Returned exception values do not trigger catches. At a Flow-to-throwing boundary,
  use `flow/?throw` inside `try+`.
- JVM `Error`s escape unless you explicitly catch their class or `Throwable`.

## Flow integration: else-type

Copy this small integration namespace into the application. Loading it installs
our required [JVM Error-rethrow policy](fmnoise-flow.md#required-jvm-policy-rethrow-javalangerror);
require it during startup, before using Flow.

```clojure
(ns app.error-flow
  (:require
   [exoscale.ex :as ex]
   [fmnoise.flow :as flow]))

(extend-protocol fmnoise.flow/Catch
  java.lang.Error
  (caught [error] (throw error)))

(defn else-type
  ([type handler]
   (partial else-type type handler))
  ([type handler value]
   (flow/else
     (fn [error]
       (if (ex/type? error type)
         (handler error)
         error))
     value)))
```

**Contract:** `(app.error-flow/else-type type handler value)` matches failures by
keyword hierarchy, passing the **original exception object** to the handler.
Successes and unmatched failures pass through unchanged; handler exceptions
propagate. Omitting `value` returns a unary function for composition.

```clojure
(require '[app.error-flow :as error-flow]
         '[exoscale.ex :as ex]
         '[fmnoise.flow :as flow])

(->> (ex/ex-not-found "User not found" {:user-id 42})
     (flow/then :name) ; skipped
     (error-flow/else-type ::ex/not-found
       #(hash-map :status 404 :user-id (:user-id (ex-data %)))))
;; => {:status 404 :user-id 42}

(->> (ex/ex-not-found "Missing")
     (error-flow/else-type ::ex/not-found (constantly 0))
     (flow/then inc)) ; => 1; recovery resumes the success path
```

Use `(comp handler ex-data)` for data-only handlers. To catch a selected handler's
ordinary exceptions, pass `#(flow/call handler %)`; no extra helper is needed.

### Functional catch without the helper

`ex/catch` already works on exception values. Unlike `else-type`, its handler
receives **data**; `identity` preserves an unmatched exception.

```clojure
(->> (ex/ex-not-found "Missing" {:user-id 42})
     (flow/else
       #(ex/catch % ::ex/not-found :user-id identity)))
;; => 42
```

### Integration boundaries

- `flow/else-if` matches JVM classes, not keyword types; use `else-type` instead.
- `flow/fail-with` carrying `::ex/type` works with `ex/type?`, `ex/catch`, and
  `else-type`. Its JVM `Fail` is **not** `ExceptionInfo`, so `try+` keyword catches
  do not handle it. Prefer ex constructors when both styles must interoperate.
- The Error extension rethrows the **same object**, without logging or wrapping
  in `caught`. It does not change Flow's classification of returned Error values.
- `flow/call-with` bypasses that extension. Its handler must rethrow `Error`
  before doing anything else; see the linked Flow policy for binding-macro caveats.
- Manifold/Auspex integrations are separate artifacts. Flow does not await
  deferreds/futures or catch failures delivered after its synchronous call returns.

## Sources

Inspected local checkout `0429b2c` (declares `0.4.3-SNAPSHOT`); integration checked
against the released `0.4.2` artifact, not that snapshot.

- [README](https://github.com/exoscale/ex/blob/0429b2c/README.md)
- [Core implementation](https://github.com/exoscale/ex/blob/0429b2c/modules/ex/src/clj/exoscale/ex.cljc)
- [API docs](https://cljdoc.org/d/exoscale/ex/0.4.2/api/exoscale.ex)
