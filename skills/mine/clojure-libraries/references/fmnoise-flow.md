# fmnoise/flow

Synchronous error-as-value pipelines; unrelated to `core.async.flow`.

For typed failures, use the [exoscale/ex integration (`else-type`)](exoscale-ex.md#flow-integration-else-type): keyword-hierarchy recovery plus our JVM Error-rethrow setup.

## Setup and quick start

**JVM setup requirement:** install our [Error-rethrow policy](#required-jvm-policy-rethrow-javalangerror)
before using Flow; upstream otherwise catches JVM `Error`s as failure values.

```clojure
;; deps.edn
fmnoise/flow {:mvn/version "4.3.0"}

(require '[fmnoise.flow :as flow])

(defn reciprocal [n]
  (->> (flow/call / 1 n)
       (flow/then double)
       (flow/else #(hash-map :error (ex-message %)))))

(reciprocal 2) ; => 0.5
(reciprocal 0) ; => {:error "Divide by zero"}
```

### API quick reference

`v` = input value; `f` = callback; failure = `Throwable` on the JVM by default.
Callbacks receive one value unless noted. Plain operators propagate thrown exceptions;
catching operators use `fmnoise.flow/caught`, which returns exceptions by default but may rethrow.

| Fully qualified call                          | Input → output                                                                                           |
|-----------------------------------------------|----------------------------------------------------------------------------------------------------------|
| `(fmnoise.flow/then f v)`                     | Success → `(f v)`; failure → unchanged.                                                                  |
| `(fmnoise.flow/else f v)`                     | Failure → `(f v)`; success → unchanged.                                                                  |
| `(fmnoise.flow/else-if Class f v)`            | Matching failure → `(f v)`; otherwise unchanged. JVM only.                                               |
| `(fmnoise.flow/call f & args)`                | Calls `(apply f args)` → result or handled exception.                                                    |
| `(fmnoise.flow/call-with handler f & args)`   | Like `call`, but caught exception → `(handler exception)` instead of `caught`.                           |
| `(fmnoise.flow/then-call f v)`                | Like `then`, catching exceptions from `f`.                                                               |
| `(fmnoise.flow/else-call f v)`                | Like `else`, catching exceptions from `f`.                                                               |
| `(fmnoise.flow/thru f v)`                     | Calls `(f v)` for either input kind → original `v`.                                                      |
| `(fmnoise.flow/thru-call f v)`                | Like `thru`, catching callback exceptions; discards callback/handler result → original `v`.              |
| `(fmnoise.flow/switch {:ok f :err g} v)`      | Success → `(f v)`; failure → `(g v)`. Missing handlers default to `identity`.                            |
| `(fmnoise.flow/chain v f & fs)`               | Applies callbacks sequentially to successes → final result or first failure.                             |
| `(fmnoise.flow/fail? v)`                      | Value → boolean indicating failure, including custom `Flow` failures.                                    |
| `(fmnoise.flow/fail-with opts)`               | Options map or `nil` → failure value; JVM stacktrace off by default.                                     |
| `(fmnoise.flow/fail-with! opts)`              | Options map or `nil` → throws failure; JVM stacktrace on by default.                                     |
| `(fmnoise.flow/ex-info! msg data [cause])`    | `ex-info` arguments → constructs and throws exception (`[cause]` means optional).                        |
| `(fmnoise.flow/flet [name expr ...] body...)` | Macro: sequential bindings → body result or early failure; catches expression/body exceptions. JVM only. |
| `(fmnoise.flow/tlet [name expr ...] body...)` | Macro: like `flet`, then throws a failure result. JVM only.                                              |
| `(fmnoise.flow/?ok v f)`                      | `Flow` protocol method: value-first counterpart of `then`.                                               |
| `(fmnoise.flow/?err v f)`                     | `Flow` protocol method: value-first counterpart of `else`.                                               |
| `(fmnoise.flow/?throw v)`                     | `Flow` protocol method: failure → throw; success → unchanged.                                            |
| `(fmnoise.flow/caught exception)`             | `Catch` protocol method: caught exception → policy result or rethrow.                                    |

`then`, `else`, `else-if`, `thru`, their `-call` variants, and `switch` also return
a unary function when the final `v` is omitted. `fmnoise.flow/handle` is a deprecated alias for `switch`.

## Error model: failures are values

### Exceptions versus thrown exceptions

By default, a JVM `Throwable` value is a failure; other values are successes.
Returning an exception routes it through Flow. Throwing one requires a catch boundary.

```clojure
(def missing (ex-info "User not found" {:id 42}))

(flow/then inc missing)      ; => missing, inc skipped
(flow/else ex-data missing)  ; => {:id 42}, now a success value
(flow/fail? missing)         ; => true
```

### nil, false, and error-shaped maps are normal values

```clojure
(flow/then vector nil)             ; => [nil]
(flow/then not false)              ; => true
(flow/fail? {:error "Not found"})  ; => false
```

Convert missing/invalid results explicitly, e.g. `(or user missing)`.

## Choosing the right operator

### Success and recovery: then, else, else-if

Functions come first, values last: use `->>`.

| Operator | Success input | Failure input |
|---|---|---|
| `(flow/then f value)` | Apply `f` | Preserve failure |
| `(flow/else f value)` | Preserve value | Apply `f` |
| `(flow/else-if Class f value)` | Preserve value | Apply `f` if class matches |

Recovery returning a normal value resumes the success path; returning a failure stays on the error path.

```clojure
(->> (flow/call / 1 0)
     (flow/then inc)                                    ; skipped
     (flow/else-if ArithmeticException (constantly 0))
     (flow/then inc))                                   ; => 1
```

### Exception capture: call, then-call, else-call

```clojure
(flow/call / 1 0) ; => ArithmeticException value

(->> 0
     (flow/then-call #(/ 1 %))
     (flow/else-call ex-message)) ; => "Divide by zero"
```

`call` invokes `(apply f args)` inside `try/catch`. `then-call` and `else-call` wrap
only their selected callback in `call`. The default JVM catch policy catches **all `Throwable`s**.

### Side effects: thru and thru-call

Both invoke `f` on either kind of input, then return the original input.

```clojure
(->> missing
     (flow/thru #(println "Result:" %))
     (flow/else ex-data)) ; prints failure, returns {:id 42}
```

Use `(flow/else (flow/thru log-error) result)` to log only failures without recovering.

### Branching and composition: switch, chain, curried forms

```clojure
(flow/switch {:ok inc :err ex-message} 2)       ; => 3
(flow/switch {:ok inc :err ex-message} missing) ; => "User not found"
;; Omitted :ok or :err defaults to identity.

(flow/chain 1 inc #(* 3 %) dec) ; => 5; skips remaining callbacks on failure

(mapv (flow/then inc) [1 missing 3]) ; => [2 missing 4]
```

`then`, `else`, `thru`, their `-call` variants, `else-if`, and `switch` support
partial application by omitting the value. `switch` and `chain` do not catch callback exceptions.

## Sequential bindings and early exit

### flet: return failures

Bindings run sequentially. A returned failure skips subsequent bindings and the
body. Thrown exceptions in binding expressions or the body pass through `Catch/caught`.

```clojure
;; Application functions supplied by the caller.
(defn assign-manager [report-id manager-id]
  (flow/flet [report  (or (find-report report-id)
                         (ex-info "Report not found" {:id report-id}))
              manager (or (find-manager manager-id)
                          (ex-info "Manager not found" {:id manager-id}))]
    {:report report :manager manager}))
```

### tlet: throw failures

`tlet` is `flet` followed by `?throw`: use at boundaries that require exceptions.

```clojure
(flow/flet [x missing] (:id x)) ; => missing
(flow/tlet [x missing] (:id x)) ; throws missing
```

### Destructuring and body evaluation

```clojure
(flow/flet [{:keys [x y]} {:x 2 :y 3}]
  (* x y)) ; => 6

(flow/flet []
  missing
  :done) ; => :done; returned failures short-circuit bindings, not body forms
```

Binding vectors require an even number of forms. Destructuring does not validate
required keys; check missing values explicitly.

## Constructing and inspecting failures

### ex-info, fail-with, and fail?

Use `ex-info` for ordinary structured errors. JVM `fail-with` constructs a
`Fail` (`RuntimeException` + `IExceptionInfo`) without a stacktrace by default.

```clojure
(def denied
  (flow/fail-with {:msg "Access denied" :data {:code 403}}))

(flow/fail? denied)  ; => true
(ex-message denied) ; => "Access denied"
(ex-data denied)    ; => {:code 403}
```

### Throwing: ex-info!, fail-with!, and ?throw

```clojure
(flow/ex-info! "Invalid input" {:field :email}) ; constructs and throws ex-info
(flow/fail-with! {:msg "Invalid input"})       ; constructs and throws Fail
(flow/?throw denied)                          ; throws existing failure
(flow/?throw 42)                              ; => 42
```

### Failure data, causes, and stacktrace defaults

| JVM option | `fail-with` default | `fail-with!` default |
|---|---|---|
| `:msg` | `nil` | `nil` |
| `:data` | `{}` | `{}` |
| `:cause` | `nil` | `nil` |
| `:suppress?` | `false` | `false` |
| `:trace?` | `false` | `true` |

`(flow/fail-with nil)` is valid. Explicit `:data nil` is not.

## Exception boundaries and resource safety

### Plain operators do not catch exceptions

```clojure
(flow/then #(/ 1 %) 0)      ; throws
(flow/then-call #(/ 1 %) 0) ; returns failure under default Catch policy
```

The same distinction applies to `else`/`else-call` and `thru`/`thru-call`.

### Argument evaluation and lazy realization

Arguments evaluate before `call`; deferred work executes after it. Put the work
and any required realization inside the callback.

```clojure
(flow/call identity (/ 1 0))       ; throws before call
(flow/call #(identity (/ 1 0)))   ; returns failure

(flow/call #(map (fn [n] (/ 1 n)) [1 0]))  ; returns lazy seq, not a failure
(flow/call #(mapv (fn [n] (/ 1 n)) [1 0])) ; returns failure
```

### Cleanup: with-open and try/finally

Neither `flet` nor `thru` guarantees cleanup. Scope resources with `with-open`
or `try/finally`; use `call` outside that scope if cleanup exceptions must become values.

```clojure
(require '[clojure.java.io :as io])

(flow/call
  #(with-open [reader (io/reader "input.txt")]
     (vec (line-seq reader))))
```

### thru-call discards captured failures by default

```clojure
(flow/thru-call (fn [_] (/ 1 0)) :original) ; => :original
```

Its callback result—including a captured exception—is discarded. A `Catch`
implementation that rethrows still escapes. Use `then-call` when the operation's
failure should replace the input.

## Customizing behavior

### Local exception handling with call-with

Prefer a local handler when one call needs a different policy. It replaces
`Catch/caught` for that invocation.

```clojure
(flow/call-with
  (fn [e]
    (if (instance? ArithmeticException e) :bad-math (throw e)))
  / 1 0) ; => :bad-math
```

### Required JVM policy: rethrow java.lang.Error

Our JVM applications must install this extension at startup, before running Flow
operations. Rethrow the same `java.lang.Error` object immediately; do not log, wrap,
recover, or convert it into a failure value in the handler.

```clojure
(extend-protocol fmnoise.flow/Catch
  java.lang.Error
  (caught [error] (throw error)))
```

This preserves Flow's default handling of ordinary exceptions while allowing
`OutOfMemoryError`, `StackOverflowError`, `ThreadDeath`, `AssertionError`, and other
`Error` subclasses to escape. Do not add subclass overrides that swallow them.

- Load the extension once from application startup code; protocol extensions are process-wide.
- `call` and the `-call` operators dispatch caught throwables through `caught`.
  `flet`/`tlet` also use this policy, but perform internal wrapping first; this is
  not a guarantee of safe recovery or allocation-free propagation during OOM.
- `call-with` bypasses `Catch`: its handler must likewise rethrow any `java.lang.Error`
  before further processing.
- This changes catch policy, not `Flow` classification. An explicitly returned
  `Error` remains a failure value; do not return JVM errors as application failures.

[Upstream issue #6](https://github.com/fmnoise/flow/issues/6) discusses this risk;
the maintainer leaves the policy to consumers.

### Custom result types with Flow

`Flow` controls success dispatch, failure dispatch, and throwing. Extend all three
methods; `fail?` also recognizes custom failures through this protocol.

```clojure
(defrecord Rejected [message data]
  flow/Flow
  (?ok [this _] this)
  (?err [this f] (f this))
  (?throw [_] (throw (ex-info message data))))

(flow/fail? (->Rejected "Denied" {:code 403})) ; => true
(flow/else :data (->Rejected "Denied" {:code 403})) ; => {:code 403}
```

### Thread-first usage with ?ok and ?err

```clojure
(-> (flow/call / 1 2)
    (flow/?ok #(* 100 %))
    (flow/?ok #(str % "%"))
    (flow/?err ex-message)) ; => "50%"
```

## ClojureScript support and limitations

- Upstream labels support experimental. Examples above target JVM Clojure.
- Standard failure type: `js/Error`, rather than `Throwable`.
- `flet`, `tlet`, and `else-if` have no supported CLJS implementation in 4.3.0.
- CLJS `fail-with`/`fail-with!` use `ex-info`; JVM stacktrace/suppression options do not apply.
- `call` catches `:default`, but the default `Catch` implementation covers `js/Error`;
  arbitrary JavaScript thrown values need an explicit policy, e.g. `call-with`.

Written against **fmnoise/flow 4.3.0** (checkout `d6d73df`).
