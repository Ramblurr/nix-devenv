---
name: writing-clojure-tests
description: Clojure-family testing. Use when writing, modifying, reviewing, or running tests in `.clj`, `.cljc`, `.cljs`, `.cljd`, or `.bb` files.
---

# Writing Clojure Tests

This skill owns Clojure's testing sequence, framework selection, and skill
routing. Linked skills own framework syntax, development mechanics, style, and
execution.

## REPL-First Development

**The REPL discovers; tests preserve.**

Clojure's live REPL lets us interrogate the running program, test small
hypotheses, and reshape an implementation while our understanding is still
changing. Writing tests before that exploration turns provisional assumptions
into contracts and makes the test loop perform work the REPL handles better.

Use Skill(clojure-repl-driven-development) to explore and implement each coherent
slice. Once the behavior works and is understood, write automated tests that
state and preserve it. Tests close the slice rather than drive its discovery. A
slice without those tests is incomplete.

### Regression Exception

A reported or suspected bug starts with a focused failing regression test. The
red test proves the bug is reproducible, records the expected contract, and
prevents the investigation from accepting a change that merely hides the
symptom.

After reproducing the bug, use the REPL to form hypotheses, inspect the running
program, and develop the fix. The slice closes when the regression test and the
relevant suite are green.

## 1. Classify the Test DSL

Before editing tests, inspect:

- project instructions and testing documentation
- test and development dependencies
- substantive tests near the target and elsewhere in the repository
- template or generator provenance when existing tests look generated

Distinguish the test DSL from its runner. Kaocha runs `clojure.test` tests,
including tests emitted by Fulcro Spec, so Kaocha configuration identifies the
runner rather than the intended DSL.

Evaluate these rows in order and stop at the first match:

| Evidence | Route |
|---|---|
| Project instructions name a DSL | The instructed DSL |
| Substantive tests in the target module use a DSL | The target module's DSL |
| Substantive tests across the repository use one DSL | The repository's DSL |
| Multiple DSLs are substantive | The target module's convention, then the repository's dominant convention; ask if still ambiguous |
| No substantive tests, or only generated scaffolding exists | Fulcro Spec |

A substantive test encodes project behavior. A lone generated smoke test, sample
`deftest`, or placeholder assertion is scaffolding. Classify scaffolding as no
established DSL; delete it when adding the first real suite and use Fulcro Spec.

**Framework gate:** every target test namespace has exactly one evidence-backed
route before test code changes.

## 2. Load the Framework Branch

### Fulcro Spec

Read Skill(clojure-libraries/references/fulcro-spec) in full before writing or
modifying a Fulcro Spec test. For a new suite, add it
through the project's test or development dependency convention, ensure the
runner includes its test path, and replace generated scaffolding with the first
behavior tests.

### `clojure.test`

Continue the project's substantive `clojure.test` conventions. This branch needs
no framework-specific disclosed reference.

### Another Established DSL

Preserve the established DSL. Check Skill(clojure-libraries) for guidance; when
the index has none, inspect the project's local documentation and dependency
source before editing.

**Branch gate:** the selected framework guidance is loaded and any new-suite
dependency or test-path changes are identified.

## 3. Route Companion Skills

Follow each applicable route:

- **Test code changes:** Skill(clojure-style-guide) owns Clojure forms and
  namespace style; Skill(testing-anti-patterns) owns assertion shape, mocks, and
  test-only production hooks.
- **Evaluation and execution:** Skill(clojure-eval) owns REPL discovery, reloads,
  and focused test execution.
- **Kaocha:** read Skill(clojure-libraries/references/kaocha).
- **Property-based tests:** start with
  Skill(clojure-libraries/references/test-check/overview).
- **Polylith workspaces:** Skill(clojure-polylith) owns test placement and
  repository commands.

