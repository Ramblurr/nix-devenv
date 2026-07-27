---
name: clojure-eval
description: Evaluates Clojure forms through a running nREPL with `brepl`. Use before writing or changing Clojure code, loading namespaces, checking compilation, running focused tests, debugging behavior, or interacting with a project REPL.
---

# Clojure REPL Evaluation

Use `brepl` instead of `clojure -e` so evaluations run in the project's long-lived REPL.

## Critical Rules

1. Let `brepl` select the nREPL server. For normal local evaluation, do not read `.nrepl-port`, scan for ports, or pass `-p`.
2. Use a quoted heredoc for nontrivial code: `<<'EOF'` prevents shell expansion.
3. Use a positional argument only for a trivial probe.
4. Reload changed namespaces before evaluating their vars.

## Automatic nREPL Discovery

Run `brepl` without a port:

```bash
brepl '(+ 1 2)'
```

Without an explicit override, `brepl` resolves the server automatically from:

1. `.nrepl-port`
2. `BREPL_PORT`
3. a running Clojure or Babashka nREPL process associated with the current project

For `brepl -f`, discovery starts at the loaded file's directory and searches upward. This supports monorepos and nested working directories.

**Do not manually discover or pass a port unless automatic discovery fails and the user has identified a specific nonstandard or remote server.**

## Evaluate Code

Use direct stdin for multiline code:

```bash
brepl <<'EOF'
(require '[clojure.string :as str])
(str/join ", " ["a" "b" "c"])
EOF
```

Inside the quoted heredoc, write Clojure normally without shell escaping. Combine related forms in one evaluation.

## Reload and Test

Reload a changed namespace and test it in the same evaluation:

```bash
brepl <<'EOF'
(require '[myapp.core :as core] :reload)
(core/some-function "test" 123)
EOF
```

Requiring a namespace with `:reload` also verifies that it compiles and loads. A successful `require` normally returns `nil`.

Run focused tests through the REPL:

```bash
brepl <<'EOF'
(require '[clojure.test :as test])
(require 'myapp.core-test :reload)
(test/run-tests 'myapp.core-test)
EOF
```

Load a complete file when needed:

```bash
brepl -f src/myapp/core.clj
```

## Start a REPL Only When Needed

First run the trivial probe. If it succeeds, reuse that REPL. If `brepl` reports that no server exists:

1. In projects with a `dev` task, start `bb dev` as a background process.
2. Otherwise use the project's documented REPL command; in these projects the usual fallback is `clojure -M:dev:repl/dev`.
3. Wait until `brepl '(+ 1 2)'` succeeds. Do not wait by manually reading or passing the generated port.

## Inspect Errors

Inspect the last REPL exception without starting another process:

```bash
brepl <<'EOF'
(require '[clojure.repl :refer [pst]])
(pst *e)
EOF
```

For unbalanced delimiters, load the `clojure-paren-repair` skill and use `brepl balance`; do not repair delimiters manually.
