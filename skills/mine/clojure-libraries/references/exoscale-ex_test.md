# exoscale/ex integration verification

Tests for the helper in [exoscale-ex.md](exoscale-ex.md#flow-integration-else-type).
Copy that integration namespace into `app.error-flow` before running these checks.

## REPL verification

Tested with Flow **4.3.0** and ex **0.4.2** in an isolated `clj -M:repl/dev` REPL.
The checks below preserve the helper contract and Error identity checks. Run in a
scratch REPL: hierarchy and protocol extensions are process-wide. The Errors are
constructed test objects, not actual resource exhaustion.

```clojure
(require '[app.error-flow :refer [else-type]]
         '[exoscale.ex :as ex]
         '[fmnoise.flow :as flow])

(ex/derive ::missing-user ::ex/not-found)

(let [missing (ex/ex-not-found "Missing" {:id 42})
      child (ex-info "Missing user" {::ex/type ::missing-user})
      plain (Exception. "Untyped")
      replacement (ex/ex-conflict "Conflict")
      seen (atom nil)]
  (assert (= :handled (else-type ::ex/not-found (constantly :handled) missing)))
  (assert (= :handled ((else-type ::ex/not-found (constantly :handled)) child)))
  (assert (identical? missing (else-type ::ex/conflict identity missing)))
  (assert (identical? plain (else-type ::ex/not-found identity plain)))
  (doseq [v [nil false 42 {::ex/type ::ex/not-found}]]
    (assert (identical? v (else-type ::ex/not-found
                           (fn [_] (throw (AssertionError. "Unexpected handler")))
                           v))))
  (assert (= :handled (else-type ::ex/not-found
                       (fn [e] (reset! seen e) :handled) missing)))
  (assert (identical? missing @seen))
  (assert (identical? replacement
                     (else-type ::ex/not-found (constantly replacement) missing)))
  (assert (nil? (else-type ::ex/not-found (constantly nil) missing)))
  (assert (false? (else-type ::ex/not-found (constantly false) missing)))
  (assert (= 1 (->> missing
                   (else-type ::ex/not-found (constantly 0))
                   (flow/then inc))))
  (assert (try (else-type ::ex/not-found (fn [_] (throw plain)) missing)
               false
               (catch Exception e (identical? plain e))))
  (assert (identical? missing (flow/call #(throw missing)))))

(doseq [error [(Error. "Synthetic")
               (OutOfMemoryError. "Synthetic")
               (StackOverflowError. "Synthetic")
               (ThreadDeath.)
               (AssertionError. "Synthetic")]
        operation [(fn [e] (flow/call #(throw e)))
                   (fn [e] (flow/then-call (fn [_] (throw e)) :ok))
                   (fn [e] (flow/else-call (fn [_] (throw e))
                                          (ex/ex-not-found "Missing")))
                   (fn [e] (flow/thru-call (fn [_] (throw e)) :ok))
                   (fn [e] (flow/flet [x (throw e)] x))
                   (fn [e] (flow/flet [] (throw e)))
                   (fn [e] (flow/tlet [x (throw e)] x))]]
  (assert (try (operation error)
               false
               (catch Error caught (identical? error caught)))))
```
