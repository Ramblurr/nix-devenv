---
name: clojure-repl-driven-development
description: Use when working Clojure and implementing any feature or bugfix. Guides planful, hypothesis-driven development against a running Clojure program and preserves REPL discoveries in durable artifacts
---

# Clojure REPL-Driven Development

Treat the REPL as a user interface to the running program, not as a scratch
calculator. This skill defines the development discipline; Skill(clojure-eval)
defines the `brepl` cli, discovery, reload, and evaluation mechanics.
Load and follow both skills without duplicating those mechanics here.

## Hard Gate: Require a Working REPL

<required>
Before editing any Clojure-family source, test, or project EDN file:

1. Use the trivial brepl probe from Skill(clojure-eval) to confirm REPL availability.
2. If the probe reports no REPL or a connection failure, stop immediately.
3. Follow project instructions to start the repl
4. Probe again after the user confirms restoration.

After every code edit, reload each edited namespace and evaluate the relevant
behavior. If the REPL becomes unavailable, make no further edits and report it.
</required>

## Work the Hypothesis Loop

1. Plan — State the exact question, expected result, and what would disprove
   the expectation. A one-sentence plan is enough.
2. Test — Evaluate the smallest expression that answers that question.
3. Observe — Read the value or exception. Use REPL history instead of
   repeating expensive work.
4. Refine — Change one assumption and evaluate the next small expression.
5. Preserve — Move confirmed knowledge into a durable artifact.
6. Repeat — Continue only while each probe narrows the question.

Aimless evaluation is not progress. When probes stop narrowing the problem,
step back to the design, read the surrounding code, or ask the user.

## Preserve Discoveries

| Discovery | Durable artifact |
|---|---|
| Required or corrected behavior | Automated test |
| Validated implementation | Source file |
| Useful executable usage or integration path | Rich Comment Form (RCF) |
| Non-obvious rationale or constraint | Concise comment or design document |

Session `def`s are temporary handles, not preservation. Do not leave important
knowledge only in REPL history.

Add `(comment ...)` forms only after validating their examples directly in the
REPL. Keep them near the relevant API and executable by a human. RCFs document
usage; they do not replace assertions, tests, or initial REPL evaluation.

While investigating, run the individual test var from its test namespace.
Then run the changed namespace's tests and the broader project checks. Name a
`deftest` for its behavior without a redundant `-test` suffix; its qualified
identity already has the `area/thing` shape, such as
`project.core-test/rejects-blank-email`.

## Control Session State

The REPL accumulates loaded code, vars, dependencies, and mutated resources.
Question results that depend on setup you cannot reproduce. Inspect or unmap
stale vars and reload affected namespaces; ask the user for a restart when the
session remains ambiguous.

Use dynamic dependencies for experiments only. Persist accepted dependencies
in `deps.edn`, then synchronize the running REPL. For intermediate debug data,
load Skill(clojure-tap-debug-logging); structured taps beat parsed console output.

Prefer direct core composition. Add a wrapper only when it captures meaningful
domain intent, policy, non-obvious behavior, or substantial duplication.

## Communicate the Invisible Work

The user does not see REPL evaluations or results. After each meaningful cycle,
report the hypothesis, representative form, observed result, and resulting
conclusion. Keep the report concise, but never claim verification without an
observed evaluation.

Before finishing, confirm that changed namespaces reloaded, relevant behavior
was observed, focused tests passed, discoveries were preserved, and no result
depends on unexplained session state.

# REPL-Driven Development Field Reference

Use these forms inside the long-lived REPL according to `clojure-eval`. This
reference covers interactive techniques, not `brepl` transport or discovery.

## Result and Session Vars

| Var | Purpose |
|---|---|
| `*1` | Last result |
| `*2` | Second-to-last result |
| `*3` | Third-to-last result |
| `*e` | Last exception |
| `*ns*` | Current namespace |

Each evaluation advances the result history. Capture a valuable result before
later evaluations replace it:

```clojure
(+ 1 2 3)       ; => 6
*1              ; => 6
(* *1 10)       ; => 60
(def saved *1)  ; temporary session handle
```

A session `def` still disappears at restart and can make later results depend
on hidden state. Preserve durable work in source, tests, or an RCF.

## Help and Discovery

Many of the namespaces you'll see used in the project will not be local files.
You will want to access the documentation and source of these items, and Clojure
has a great way for doing this.

### Understanding namespaces
A namespace is an element of clojure that is used to organize code. The require command loads namespaces, and can then also modify the current namespace's content to include aliases (to other namespaces) and refer (copy) the vars from other namespaces into the current one (the current ns is always known by reading clojure.core/ns, which returns the actual Java Namespace object that represents namespaces. Use the getName method to get the string name of it).

The following namespace declaration (which actually is just a macro):

```
(namespace foo.bar
  (:require
    [fully.qualified.namespace :as fqn :refer [f g]]))
```

Loads the `fully.qualified.namespace`, Adds an alias to the `foo.bar` namespace called `fqn` to stand for the loaded
one, and then *interns* the vars `f` and `g` from `fqn` into the `foo.bar` namespace. The result is that when evaluating
code the runtime looks at `*ns*` (the current active namespace), and tries to figure out what symbols mean. Simple
symbols are looked up in the interned symbols. symbols that are prefixed with aliases are looked up that way (e.g. fqn/f
is the same as f). Other fully-qualified symbol are taken literally.

### Extracting Documentation and Source
There is a namespace called clojure.repl that can be used to extract the documentation of vars (functions and such), and
also for open-source things it can show you the source code.

Since you have access to an nREPL, you can leverage this to get a focused view of things you're interested in without
putting entire files into your context window. You should always prefer getting the source of a function (defn or def)
if you can find it before looking for a file, unless you just need to know what is in the entire namespace.

First name sure the tool and namespace are loaded in nREPL:

* `(require 'clojure.repl)`
* `(require 'the-namespace-of-the-function-you-want)`

Then:

* To see the docstring, use `(clojure.repl/doc fully-qualified-name)`
* To see the source, use `(clojure.repl/source fully-qualified-name)`
* To see the public vars in a namespace, use `(clojure.repl/dir fully-qualified-ns-name)`
* To print documentation for any var whose docstring or name matches a re-string-or-pattern, use `(clojure.repl/find-doc re-string-or-pattern)`

IMPORTANT: Both `doc` and `source` are macros that take a symbol that MUST NOT
be quoted in any way. You should always use the fully-qualified name (e.g.
dataico.lib.strings/normalize instead of just normalize or an aliased
strs/normalize).

```clojure
(require '[clojure.repl :as repl]
         '[clojure.string])

(repl/doc clojure.core/map)
(repl/source clojure.core/map)
(repl/dir clojure.string)
(repl/apropos "join")
(repl/find-doc "concatenate")
```

Use `doc` for contracts, `source` for implementation details, `dir` for a known
namespace, and the search functions when you do not know a var's name.

## Error Investigation

`clojure-eval` defines the stack-trace workflow. Inspect structured exception
information before parsing printed output:

```clojure
*e
(ex-message *e)
(ex-data *e)
```

Preserve the failing input and exception data when they reveal a regression;
turn them into a focused test.

## Namespace and State Management

```clojure
*ns*
(require '[myproject.core :as core])
(in-ns 'myproject.core)
(sort (keys (ns-publics 'myproject.core)))
(ns-unmap *ns* 'problematic-var)
```

Use `clojure-eval`'s normal `:reload` workflow after edits. Use `:reload-all`
only when dependency namespaces are stale:

```clojure
(require 'myproject.core :reload-all)
```

If the session still behaves ambiguously, stop and ask the user to restart it.

## Dynamic Dependencies

When `clojure.repl.deps` is available, add a library for a session experiment:

```clojure
(require '[clojure.repl.deps :as repl.deps])

(repl.deps/add-libs
 '{some/library {:mvn/version "x.y.z"}})
```

Once accepted, add the coordinate to `deps.edn` and synchronize the running
REPL instead of relying on the ephemeral addition:

```clojure
(repl.deps/sync-deps)
```

## Focused Tests

Reload the test namespace first. Prefer one test var while investigating:

```clojure
(require '[clojure.test :as test])
(require 'my.project.some-test :reload)

(test/test-vars [#'my.project.some-test/specific-behavior])
```

Then use the namespace-level test workflow from `clojure-eval`. In a ClojureScript
REPL, run the relevant loaded test namespace with:

```clojure
(cljs.test/run-tests 'my.project.some-test)
```

## Rich Comment Forms

RCFs remain inert when the namespace loads and give humans validated forms to
evaluate at will:

```clojure
(comment
  (process-user-data
   {:user/name "John"
    :user/email "john@example.com"})

  (->> users
       (map process-user-data)
       (filter :valid?))

  :rcf)
```

Keep RCFs current, focused, and free of assertions that belong in tests.

## Avoid Trivial Wrappers

Prefer a clear core expression when a new name adds no domain meaning:

```clojure
(remove (set exclusions) items)
```
