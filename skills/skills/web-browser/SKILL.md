---
name: web-browser
description:  |
    Interactive browser automation, control a browser programmatically.
    Use when you need to interact with or screeshot web pages, test frontends,
    or when user interaction with a visible browser is required.

---

Browser automation with etaoin (Clojure). Requires a running REPL (see `clojure-eval` skill). Use the REPL path by default. If the user specifically requests Babashka, see the Babashka section below.

Driver creation follows the pattern `e/<browser>` or `e/<browser>-headless`. Use headless by default, visible when the user wants to watch. Scoped macros follow the same pattern: `e/with-<browser>-headless`.

- Scoped: `(e/with-chrome-headless driver ...)` - auto-cleanup, use for one-off tasks
- Persistent: `(def driver (e/firefox-headless))` - survives across evals, always clean up with `(e/quit driver)`

## Error Handling

Etaoin errors include the entire driver map, producing very long stack traces that waste tokens and blow up the context window. Always load the error helpers first, then wrap all etaoin calls with `try-e`:

```bash
brepl -f ./scripts/etaoin_helpers.clj
```

Then wrap etaoin calls with `try-e`:

```clojure
(try-e
  (e/click driver {:css ".might-not-exist"})
  (e/wait-visible driver {:id :some-element}))
;; ETAOIN ERROR: {:error "no such element", :message "Unable to locate element: .might-not-exist", :selector {:using "css selector", :value ".might-not-exist"}}
```

The full exception is stored in `@etaoin-last-error` if you need to inspect it.

## Getting Started

```clojure
(require '[etaoin.api :as e]
         '[etaoin.keys :as k]
         '[clojure.string :as str])

;; scoped session (auto-cleanup)
(try-e
  (e/with-chrome-headless driver
    (e/go driver "https://example.com")
    (e/wait-visible driver {:tag :h1})
    (e/screenshot driver "target/page.png")))

;; persistent session (survives across evals)
(def driver (e/firefox-headless))
(try-e
  (e/go driver "https://en.wikipedia.org/wiki/Clojure")
  (e/wait-visible driver {:id :firstHeading})
  (e/get-title driver)) ;; => "Clojure - Wikipedia"
;; ... more evals ...
(e/quit driver)

;; visible session (user can watch)
(def driver (e/firefox))
;; same API, browser window appears
(e/quit driver)
```

## Selecting elements

Use css selectors or xpath to select elements.

```clojure
{:css "input#uname[name='username']"}
```

```clojure
{:xpath ".//input[@id='uname']"}
```

For example:

```clojure
(e/fill driver
        {:css "input#uname[name='username']"}
        " CSS selector")
```

## Important tips

### Use waits

Use `e/wait-visible` to wait for elements to be visible. `e/wait-has-text` and `e/wait-has-text-everywhere` can be used to wait until text is visible on the page.

`e/wait` should be used only when the other wait options don't make sense.

### Generic page wait

When you don't know the page structure, wait for `document.readyState` instead of a specific element:

```clojure
(e/wait-predicate #(= "complete" (e/js-execute driver "return document.readyState")))
```

### Prefer Firefox

Firefox (headless or visible) is less likely to be blocked by bot detection than headless Chrome. Use `e/firefox-headless` or `e/with-firefox-headless` by default unless instructed to use Chromium.

### Persistent profile

By default each session starts fresh. When the user instructions you to use a persistent session, then use a fixed profile directory to persist cookies, cache, and local storage across runs.

Chrome - `:profile` works directly:

```clojure
(e/chrome-headless {:profile "/tmp/my-profile"})
```

Firefox - `:profile` requires a pre-existing Firefox profile. Use capabilities instead:

```clojure
(e/firefox-headless {:capabilities {:moz:firefoxOptions {:args ["-profile" "/tmp/my-profile"]}}})
```

Both auto-create the directory on first use.

### Scrolling

An element may not be visible on the page. Use `e/scroll`

### Executing Javascript
Use js-execute to evaluate a Javascript code in the browser:

```clojure
(e/js-execute driver "alert('Hello from Etaoin!')")
(e/dismiss-alert driver)
```

### Interacting with the page:

The following functions are useful for interacting with the page, filling forms, etc:

- `e/fill`
- `e/fill-multi`
- `e/fill-human`
- `e/fill-human-multi`
- `e/click`
- `e/double-click`

## Screenshots

Take full screen screenshots with `e/screenshot`

```
(e/screenshot driver "target/etaoin-play/screens1/page.png")
```

Screenshot an element:

```
(e/screenshot-element driver {:tag :form :class :formy} "target/etaoin-play/screens3/form-element.png")
```

## Babashka

Only use this path if the user specifically asks for Babashka instead of a Clojure REPL.

No `bb.edn` needed. Use `-Sdeps` to inline the dependency. Always use scoped sessions since the driver won't survive past `bb` execution. Set timbre to `:info` to quiet chatty debug logging:

```bash
bb -Sdeps '{:deps {etaoin/etaoin {:mvn/version "1.1.43"}}}' -e "$(cat <<'EOF'
(require '[etaoin.api :as e] '[taoensso.timbre :as timbre])
(timbre/set-level! :info)
(e/with-firefox-headless driver
  (e/go driver "https://example.com")
  (e/wait-predicate #(= "complete" (e/js-execute driver "return document.readyState")))
  (e/screenshot driver "target/page.png"))
EOF
)"
```

## Resources

- ./references/user-guide.adoc - full etaoin user guide
- ./references/sample_repl_session.clj - sample repl session
- ./scripts/etaoin_helpers.clj - error handling helpers (load with `brepl -f`)
