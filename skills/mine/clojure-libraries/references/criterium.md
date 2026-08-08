# Criterium (0.5.x alpha)

Use the **alpha API documented by this project's `README.ALPHA.md`**, not the
legacy `README.md` API. This is early alpha; breaking changes are expected.

## Setup

Add a benchmark alias. On JDK 17+, keep the blackhole options for optimal
dead-code elimination:

```clojure
{:aliases
 {:bench {:extra-deps {org.hugoduncan/criterium {:mvn/version "0.5.245-ALPHA"}}
          :jvm-opts ["-XX:+UnlockExperimentalVMOptions"
                     "-XX:CompileCommand=blackhole,criterium.blackhole.Blackhole::consume"]}}}
```

## Benchmark an expression

```clojure
(require '[criterium.bench :as bench])

(bench/bench (my-fn arg))
```

Benchmark the representative expression, not setup, I/O, class loading, or
one-time initialization. Use realistic inputs and warm the application before
measuring when relevant.

## Portal histogram

```clojure
(require 'criterium.viewer.portal)
(require '[criterium.bench :as bench])

(bench/bench (my-fn arg)
  :viewer :portal
  :bench-plan criterium.bench-plans/histogram)
```

## Generated arguments

Add `org.hugoduncan/criterium.arg-gen` at the same alpha version. Use
`arg-gen/measured` inside `bench/bench-measured`; generator bindings are
`let`-style and produce fresh values per sample.

```clojure
(require '[clojure.test.check.generators :as gen])
(require '[criterium.arg-gen :as arg-gen])
(require '[criterium.bench :as bench])

(bench/bench-measured
  (arg-gen/measured {:size 50 :seed 12345}
    [xs (gen/vector gen/small-integer)]
    (reduce + xs)))
```

## Allocation tracking

The native JVMTI agent must load at JVM startup; it cannot attach later. Print
its JVM option, restart the target JVM with the emitted `-J-agentpath:...`,
then verify it:

```clojure
(require '[criterium.agent :as agent])
(agent/jvm-opts)
;; restart JVM with -J-agentpath:<returned path>
(agent/loaded?)
```

The agent adds detailed allocation tracking to benchmarks. Do not restart a
shared or live JVM without explicit user approval.
