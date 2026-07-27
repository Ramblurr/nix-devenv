# Fulcro Spec Reference

Use this reference when a project uses Fulcro Spec or when the
`writing-clojure-tests` router selects it for a new suite.

## Compose Readable Test Names

`behavior` and `component` are synonyms and may nest inside a `specification`.
Choose the word that reads naturally. Combine their descriptions into a
sentence that identifies the failing behavior.

```clojure
(specification "The cache"
  (component "lookup"
    (behavior "returns a stored value"
      (assertions
        (sut/lookup cache :answer) => 42))))
```

Descriptions passed to `behavior` and `component` may be expressions. Labels
inside `assertions` must be literal strings:

```clojure
(doseq [entry entries]
  (component (str "entry " (:id entry))
    (assertions
      "has a value"
      (some? (:value entry)) => true)))
```

## Choose Assertions for Useful Failures

| Arrow | Meaning | Expected form |
|---|---|---|
| `=>` | equality | value |
| `=fn=>` | apply a predicate to the actual value | predicate function |
| `=throws=>` | expression throws | exception class or message regex |

Prefer direct values and whole structures because they produce useful diffs:

```clojure
(assertions
  result => {:status :ready
             :items  [{:id 1 :name "one"}]})
```

Use predicates for genuinely variable values:

```clojure
(assertions
  generated-id =fn=> uuid?)
```

Before using a predicate, ask whether the failure must show the actual result.
When validation can explain a problem, compare the explanation with `nil`
instead of asserting a boolean:

```clojure
(assertions
  (schema/explain :user result) => nil)
```

Test exception type when it defines the contract; test a message regex when the
message carries the useful distinction:

```clojure
(assertions
  (sut/read-config nil) =throws=> IllegalArgumentException
  (sut/read-config "missing.edn") =throws=> #"config not found")
```

## Mock Only Boundaries

Before mocking:

1. Identify the real function's effects and the behavior the test needs.
2. Mock the narrow external boundary, not the behavior under test.
3. Make returned data match the complete real shape.
4. Assert the caller's result or side effect. Treat call inspection as
   supplemental evidence.

Require the mocking macro and helpers only when needed:

```clojure
(ns example.user-test
  (:require
   [example.api :as api]
   [example.user :as sut]
   [fulcro-spec.core :refer [=> =1x=> assertions specification when-mocking]]
   [fulcro-spec.mocking :as mock]))
```

A mock clause binds symbols from the call pattern to the real arguments. The
right-hand side may use those symbols:

```clojure
(specification "User lookup"
  (when-mocking
    (api/fetch-user user-id) => {:id user-id :name "Ada" :roles #{:reader}}

    (assertions
      "returns the user's name"
      (sut/user-name 42) => "Ada"
      "passes the requested ID to the API"
      (mock/call-of api/fetch-user 0) => {'user-id 42})))
```

Every declared mock must be called. Fulcro Spec reports missing calls, excess
calls, and arguments that do not match literal values in the call pattern.

## Script Repeated Calls

Use counted arrows such as `=1x=>` to prescribe exact calls in order. An
uncounted `=>` accepts one or more calls and greedily handles the remaining
calls, so put it last.

```clojure
(when-mocking
  (client/request request) =1x=> {:status 503 :body "unavailable"}
  (client/request request) =1x=> {:status 200 :body "ok"}

  (assertions
    "retries a transient failure"
    (sut/fetch-with-retry) => "ok"
    (count (mock/calls-of client/request)) => 2))
```

If the code calls the function more times than the script allows, the test
fails.

## Throw from a Mock

Throw normally on the mock's right-hand side, then assert the caller's error:

```clojure
(when-mocking
  (client/request _) => (throw (Exception. "service unavailable"))

  (assertions
    (sut/fetch) =throws=> #"service unavailable"))
```

Use `_` for an ignored argument. Named symbols appear in `mock/call-of` and
`mock/calls-of`; their map keys are quoted symbols.

## Spy on the Real Function

`mock/real-return` calls the original function while recording arguments and
return values:

```clojure
(when-mocking
  (math/square x) => (mock/real-return)

  (assertions
    (sut/double-square 4) => 32
    (mock/call-of math/square 0) => {'x 4}
    (mock/return-of math/square 0) => 16))
```

Available helpers are `mock/calls-of`, `mock/call-of`, `mock/returns-of`,
`mock/return-of`, and `mock/spied-value`.
