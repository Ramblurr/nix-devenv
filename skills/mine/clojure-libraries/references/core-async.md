# clojure.core.async

Use this reference for `org.clojure/core.async` `1.10.874-alpha3+` on JDK 25+.
It covers execution choices; use the REPL for the full API and implementation.

## Choose by workload

| Work | Construct | Execution | Channel operations |
|---|---|---|---|
| Short channel coordination | `go` / `go-loop` | Virtual threads when available | `<!`, `>!`, `alts!` park |
| Blocking I/O (`:io`) | `io-thread` | Prefer a virtual thread | `<!!`, `>!!`; blocking calls allowed |
| Blocking plus compute (`:mixed`) | `thread` | Platform-thread executor | Blocking operations allowed |
| Compute (`:compute`) | Normal Clojure plus a suitable executor | Platform-thread executor by default | Application choice |

Keep compute short in `:io`; exclude blocking I/O from `:compute`. `core.async`
has no compute task construct. Use direct Java virtual-thread APIs only when the
application needs explicit lifecycle or executor configuration.

A `go-loop` is a compiler-generated state machine, not a callback or permanent
worker thread. Channel operations park it for later resumption. Keep each step
short and non-blocking: virtual-thread support does not make a go body suitable
for blocking I/O or extended computation.

`io-thread` and `thread` launch tasks and immediately return result channels.
Each channel receives its task's return value, then closes. Long-lived consumers
must exit when their input channels close so their tasks can finish.

## Choose channel operations by context

| Operation | Context | Behavior |
|---|---|---|
| `<!`, `>!` | `go` / `go-loop` | Park the go state machine; occupy no thread while waiting |
| `<!!`, `>!!` | `io-thread`, `thread`, or an ordinary thread | Block the selected thread |
| `take!`, `put!` | Any | Return immediately; invoke a callback on completion |
| `poll!`, `offer!` | Any | Return immediately with the current result |

`put!` and `take!` callbacks may run on the caller when the operation completes
immediately. Pass `false` as `on-caller?` to dispatch the callback instead. Keep
callbacks non-blocking because they may run on a core.async dispatch thread;
send blocking callback work to `io-thread`.

For producers, choose the construct that obtains the event:

| Producer | Choice |
|---|---|
| Event already in memory | `put!` or the component's publish function |
| Waits on channels or timers | `go-loop` |
| Reads a blocking socket, file, or database API | `io-thread` |
| Mixes blocking calls and compute | `thread` |
| Performs only compute | Normal function or compute executor |

Direct puts follow the producer's context:

```clojure
(async/go (async/>! output event))        ; park
(async/io-thread (async/>!! output event)) ; block
(async/put! output event)                  ; asynchronous
(async/offer! output event)                ; immediate attempt
```

## Consumer patterns

All long-lived patterns stop when the input channel closes:

```clojure
;; Short, non-blocking handling
(async/go-loop []
  (when-some [event (async/<! events)]
    (handle-event event)
    (recur)))

;; Blocking I/O, preferably on a virtual thread
(async/io-thread
  (loop []
    (when-some [event (async/<!! events)]
      (write-to-blocking-database event)
      (recur))))

;; Mixed blocking and compute on a platform-thread executor
(async/thread
  (loop []
    (when-some [event (async/<!! events)]
      (process-event event)
      (recur))))

;; Callback integration
(async/take! events #(handle-event %) false)
```

Never call `<!!`, `>!!`, `Thread/sleep`, or blocking network, file, or database
APIs in a go loop. Use `io-thread` for I/O-heavy workers; use `thread` for mixed
work.

Virtual threads make waiting on blocking I/O cheap; they do not make the code
non-blocking. Platform threads remain the default for mixed and compute work.

## Inspect the runtime

Check resolved versions when behavior matters:

```clojure
(clojure-version)
(System/getProperty "java.version")
```

Use `clojure.repl/doc`, `source`, or `dir` to inspect the relevant API:

```clojure
(require '[clojure.repl :as repl])

(with-out-str (repl/doc clojure.core.async/io-thread))
(with-out-str (repl/source clojure.core.async/chan))
```
