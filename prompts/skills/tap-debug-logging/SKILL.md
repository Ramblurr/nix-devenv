---
name: tap-debug-logging
description: Use tap-based debug logging in Clojure projects. Use when debugging with brepl or a project REPL, capturing intermediate values with tap>, inspecting ol.dev.portal tap atoms, querying logs, or preferring structured REPL-visible debug data over console output.
---

# Tap Debug Logging

Prefer `tap>` with structured data over parsing console output.

My projects start REPLs with `:repl/dev`, which puts the `ol.dev.*` namespaces on the classpath and runs `ol.dev.repl`. The `:repl/dev` alias includes `my/dev-repl` and `:main-opts ["-m" "ol.dev.repl"]`. (Check `$XDG_CONFIG_HOME/clojure/deps.edn` if there are errors)

Project `dev`/`user` namespaces usually open Portal automatically. If not, run:

```clojure
(require '[ol.dev.portal :as portal])
(portal/open-portals)
```

## Query helpers

Use `ol.dev.portal` directly:

```clojure
(require '[ol.dev.portal :as portal])

(portal/logs)            ;; all regular taps
(portal/logs 5)          ;; count-limited taps
(portal/logs :fetch)     ;; taps whose first element is :fetch
(portal/logs :fetch 3)   ;; count-limited labeled taps

(portal/log-values)      ;; mapv :value over regular taps
(portal/log-values :fetch 3) ;; useful when selected taps are maps with :value

(portal/last-log)        ;; latest regular tap entry
(portal/last-log :v)     ;; latest regular tap's :value
(portal/clear-logs!)

@(portal/my-taps)        ;; raw regular tap atom value
@(portal/noisy-taps)     ;; raw logging / middleware / nREPL tap atom value
```

## Usage

Use a vector whose first element is a keyword for labeled logging:

```clojure
(tap> [:fetch response])
(tap> [:error {:fn 'process :ex (ex-message e)}])
```

Use plain values for unlabeled logging:

```clojure
(tap> intermediate-result)
```

Inspect from `brepl`:

```clojure
(require '[ol.dev.portal :as portal])
(portal/logs 5)
(portal/last-log :v)
```

Tap intermediate pipeline values with a small helper form:

```clojure
(-> data
    transform
    ((fn [x] (tap> [:after-transform x]) x))
    persist!)
```

Do not copy local `portal_helpers.clj` implementations into projects. Add missing behavior to `ol.dev.portal` instead.
