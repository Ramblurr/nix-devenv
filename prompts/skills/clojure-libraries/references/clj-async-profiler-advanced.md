# clj-async-profiler advanced tips

Use this when basic `prof/profile` or `prof/start`/`prof/stop` is not enough.

## Capture better profiles

- Sampling is statistical. For CPU profiles, aim for at least 1000 samples; 5000-10000 is better.
- Prefer a longer run over a tiny `:interval`. Lower intervals increase overhead and may not work below OS limits.
- Warm up first: run the same `dotimes` once or twice outside the profiler so JIT compilation does not dominate.
- The profiler is process-wide. Wrapped code can include samples from other active threads.

```clojure
(dotimes [_ 1000] (my-fn x)) ; warmup
(prof/profile {:title "my-fn warmed"}
  (dotimes [_ 10000] (my-fn x)))
```

## Useful options

```clojure
(prof/profile
  {:event :cpu        ; default; running CPU work
   :threads true      ; split stacks by thread
   :interval 1000000  ; ns; default 1 ms
   :framebuf 2000000  ; increase if [frame_buffer_overflow]
   :features :all}    ; enables useful JVM/JIT details
  ...)
```

Common events:

- `:cpu` — CPU-running threads. Best first profile.
- `:wall` — includes blocked/waiting time; useful for I/O, sleeps, thread pools.
- `:alloc` — allocation volume by call path.
- `:lock` — contended monitor locks.
- `:ctimer` / `:itimer` — Linux CPU fallbacks when perf events are unavailable; less native/kernel detail.

Use `(prof/list-event-types)` to see what the host supports. Use `:pid` to target another JVM process.

## Reading flamegraphs quickly

- Width = total samples under a frame. Wider means more total cost.
- A wide plateau with little above it = high self time; inspect first.
- Height = stack depth, not cost.
- X position is arbitrary; it is not a timeline.
- Hover shows sample counts/percentages. Click zooms into a frame; click `all` to reset.
- Search/highlight sums all matching frames across call paths.
- Reverse view helps find self-time-heavy methods.

## Stack transforms

Use UI right-click transforms first. They can collapse recursion, remove stacks containing a frame, or highlight/replace frames.

For repeatable transforms, bake them into generated HTML with `:config`:

```clojure
(prof/profile-for
  10
  {:config
   {:transforms
    [{:type :replace
      :what #"(;my.ns/recursive-fn)+"
      :replacement "$1"}
     {:type :remove
      :what "thread_start"}
     {:type :replace
      :what #"(seq-reduce;).+;(my.ns/work/fn--)"
      :replacement "$1$2"}]}})
```

Transform regexes operate on semicolon-delimited stack strings. Use them to:

- collapse recursive call chains;
- remove GC, runtime, or unrelated background-thread stacks;
- merge split lazy-seq/transducer call paths so the real work aligns;
- align before/after profiles before generating a diffgraph.

## Allocation profiling

```clojure
(prof/profile {:event :alloc}
  (dotimes [_ 1000]
    (work-that-allocates)))
```

Allocation flamegraphs show relative allocation volume, not absolute allocation rate. Object classes appear at the top of stacks. Hoist setup outside the profiled loop when you only care about the operation under test.

## Diffgraphs

Use diffgraphs to compare before/after profiles:

```clojure
(prof/generate-diffgraph 1 2 {}) ; profile IDs or collapsed txt paths
```

Interpretation:

- Width = scale of change, not total cost.
- Red = more samples in the second profile.
- Blue = fewer samples in the second profile.
- Intensity = larger self-time delta.
- Use normalized view when runs differ in duration or hardware and relative shape matters more than absolute sample counts.
- Apply transforms when harmless code movement changes parent stacks and hides unchanged children.

## Startup profiling

Use this when the interesting work happens before a REPL or UI can start.

1. In a separate REPL with the dependency loaded:

   ```clojure
   (require '[clj-async-profiler.core :as prof])
   (prof/print-jvm-opt-for-startup-profiling {:event :cpu})
   ```

2. Add the printed `-agentpath:...=start,...,collapsed` JVM option to the target process. With Clojure CLI, prefix it with `-J`.
3. Let the target process finish; it writes a collapsed profile file.
4. Back in the helper REPL:

   ```clojure
   (prof/generate-flamegraph "/tmp/clj-async-profiler/results/...-collapsed.txt" {})
   ```

## Production and remote profiling

- The web UI has no auth. Bind to `localhost`, use SSH forwarding, or protect it behind trusted network/auth. Avoid public `0.0.0.0` exposure.
- On Linux, CPU profiling may require perf-related `sysctl` changes. Treat these as operational changes and get user approval.
- Docker may need `perf_event_open`, seccomp changes, or capabilities. If unavailable, try `:ctimer` or `:itimer` with reduced native detail.
- In UI-driven profiling, use `(prof/set-default-profiling-options {...})` during app init for defaults such as transforms or `:threads`.
- The UI lists sample counts; for CPU, collect at least 1000 samples.

## Processing profile data

`*-collapsed.txt` files use async-profiler collapsed stacks: `frame1;frame2;frame3 count`. Sort or aggregate them with shell tools, or parse them in Clojure.

clj-async-profiler internals worth inspecting:

- `clj-async-profiler.post-processing/read-raw-profile-file` — parse collapsed data into `stack -> samples`.
- `read-raw-profile-file-to-dense-profile` — demunge frames and produce the compact structure used by HTML rendering.
- `generate-flamegraph` / `generate-diffgraph` — regenerate HTML from collapsed text files.

Upstream async-profiler documents formats in `docs/OutputFormats.md` and conversions in `docs/ConverterUsage.md`; `jfrconv` converts JFR, collapsed, and HTML profiles to other forms.

## Custom async-profiler agent

If the bundled native library does not match the platform, build async-profiler, place `libasyncProfiler.so` where the JVM can load and execute it, then:

```clojure
(reset! prof/async-profiler-agent-path "/path/to/libasyncProfiler.so")
```
