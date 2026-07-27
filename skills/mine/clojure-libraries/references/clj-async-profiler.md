# clj-async-profiler

Embedded async-profiler wrapper for Clojure. Use it to capture CPU profiles
from a running JVM and view them as flamegraphs.

## Dependency and JVM setup

```clojure
com.clojure-goes-fast/clj-async-profiler {:mvn/version "1.7.0"}
```

On JDK 11+, start the REPL or app with self-attach enabled:

```bash
clojure -J-Djdk.attach.allowAttachSelf ...
```

For better profiles, add debug non-safepoints when practical:

```bash
-J-XX:+UnlockDiagnosticVMOptions -J-XX:+DebugNonSafepoints
```

Requires Linux or macOS and a JDK, not a JRE. On Linux, profiling may also
require perf-related `sysctl` changes; do not run those on a live system
without user approval.

## Require

```clojure
(require '[clj-async-profiler.core :as prof])
```

## Workflow 1: profile repeated function calls

Use `prof/profile` around enough work to collect useful samples. Repeat the target function to avoid profiling only startup, class loading, or JIT warmup.

```clojure
;; Optional warmup outside the profiler.
(dotimes [_ 1000]
  (my-fn arg1 arg2))

;; Capture a CPU flamegraph for repeated calls.
(prof/profile {:title "my-fn x10000"}
  (dotimes [_ 10000]
    (my-fn arg1 arg2)))
```

`prof/profile` returns the body result and writes profile files under `/tmp/clj-async-profiler/results/`. To locate the latest flamegraph:

```bash
ls -lt /tmp/clj-async-profiler/results/*flamegraph*.html | head
```

## Workflow 2: manual REPL profiling

Start the profiler, exercise code from the REPL or editor, then stop it manually. This is best when the interesting work is interactive or spans several REPL evaluations.

```clojure
(prof/start {:event :cpu})

;; Do the thing you want to profile:
(comment
  (my-fn arg1 arg2)
  (run-some-test)
  (exercise-system!))

(def flamegraph-file
  (prof/stop {:title "REPL exploration"}))
;; => #object[java.io.File ".../tmp/clj-async-profiler/results/...-cpu-flamegraph.html"]
```

`prof/stop` returns the flamegraph file by default. If you only want raw collapsed stack data, use:

```clojure
(def collapsed-stacks-file
  (prof/stop {:generate-flamegraph? false}))
```

## Output files

Default output root: `/tmp/clj-async-profiler/`.

Useful files in `/tmp/clj-async-profiler/results/`:

- `*-flamegraph.html` — self-contained interactive flamegraph for browser viewing.
- `*-collapsed.txt` — raw async-profiler collapsed stacks data.

Collapsed data is plain text: one stack per line, semicolon-separated frames,
then a space and a count:

```text
frame1;frame2;frame3 42
```

Agents can inspect `*-collapsed.txt` directly, sort by count, aggregate matching
frames, or regenerate HTML with `prof/generate-flamegraph`.

Find recent outputs:

```bash
ls -lt /tmp/clj-async-profiler/results/ | head
ls -lt /tmp/clj-async-profiler/results/*collapsed*.txt | head
```

Change the output root with a JVM property:

```bash
clojure -J-Dclj-async-profiler.output-dir=./data ...
```

## Viewing flamegraphs

Open the returned or latest `*-flamegraph.html` in a browser. From a REPL, you can also serve the results directory:

```clojure
(prof/serve-ui 8080)
```

Then open `http://localhost:8080`.

When acting as an agent, report the exact flamegraph path and, if useful, inspect the matching `*-collapsed.txt` with shell tools before summarizing hotspots.

## Common failures

- `Can not attach to current VM`: restart the REPL/app with `-Djdk.attach.allowAttachSelf`.
- `package jdk.attach not in java.base`: use a JDK instead of a JRE.
- No useful frames or many `libjvm.so` frames: add debug non-safepoints, install JDK debug symbols if needed, and collect a longer profile.

## Advanced

Read [advanced tips](./clj-async-profiler-advanced.md) when basic profiling is not enough. It covers:

- capturing better profiles: sample counts, JIT warmup, intervals, and process-wide caveats;
- non-default options/events: `:threads`, `:framebuf`, `:features`, `:pid`, `:wall`, `:alloc`, `:lock`, `:ctimer`, `:itimer`;
- reading flamegraphs: width vs. self time, plateaus, reverse view, zoom, and search/highlight;
- stack transforms: collapse recursion, remove noisy stacks, merge lazy-seq/transducer paths, and bake transforms into `:config`;
- allocation profiling and how to interpret allocation flamegraphs;
- diffgraphs for before/after comparisons, normalized view, and stack alignment;
- startup profiling with `prof/print-jvm-opt-for-startup-profiling`;
- production and remote profiling: UI exposure, SSH forwarding, Docker/perf limits, and default options;
- processing profile data: collapsed stack text, clj-async-profiler parsers, and async-profiler `jfrconv`;
- custom async-profiler agent binaries for unsupported platforms.
