# Clojure Style Reference

## Core Principles

1. Code is written for humans; optimize readability.
2. Prefer functional approaches and immutable data.
3. Consistency: project > file > form > this guide.
4. Deviate only when readability, compatibility, or history demand it.

## Layout & Formatting

### Indentation

Use spaces only, never tabs.

Indent body forms by two spaces. This applies to `def`, `defn`, `let`, `when`,
`cond`, `case`, `with-*`, `loop`, and similar forms.

Vertically align function arguments that span lines. If the first line has no
arguments, indent each argument by one space.

```clojure
(when something
  (something-else))

(filter even?
        (range 1 10))

(filter
 even?
 (range 1 10))
```

### Alignment

Vertically align `let` bindings and map keys:

```clojure
(let [thing1 "x"
      thing2 "y"]
  ...)

{:name "Bruce"
 :age  30}
```

### Line Length & Whitespace

- Prefer a maximum line length of 120 characters.
- Use Unix line endings and a newline at EOF.
- Do not leave trailing whitespace.
- Put one blank line between top-level forms. Related `def` forms may be
  grouped without blank lines.
- Do not put blank lines within function bodies, except to make visually
  related pairs of conditions in `cond` expressions apparent.

### Brackets & Parens

- Put a space before an opening bracket when text precedes it and after a
  closing bracket when text follows it.
- Do not put spaces just inside brackets: `(foo (bar baz) quux)`.
- Gather trailing parentheses on one line. The `comment` form is the exception.
- Do not use commas in vectors or lists. Commas in maps are optional when they
  improve readability.

## Common Clojure Naming Conventions

```text
**foo** - Dynamic var
foo!    - Fn with side effects, or that should otherwise be used cautiously
foo?    - Truthy val or fn that returns a truthy val
foo!?   - Fn that has side effects (or requires caution) and returns a truthy
          val. Note: !?, not ?!
foo$    - Fn that is notably expensive to compute (e.g. hits a database)
foo_    - Derefable val (e.g. atom, volatile, delay, etc.)
foo__   - Derefable in a derefable (e.g. delay in an atom), etc.
_       - Unnamed val
_foo    - Named but unused val
?foo    - Optional val (emphasizes that the val may be nil)
foo*    - A variation of `foo` (e.g. a `foo*` macro versus a `foo` fn)
foo'    - A variation of `foo`
-foo    - Public implementation detail or intermediate (e.g. uncoerced) val
>foo    - Val "to foo" (e.g. >sender, >host), or fn to put/coerce/transform
<foo    - Val "from foo" (e.g. <sender, <host), or fn to take/coerce/transform
->foo   - Fn to put/coerce/transform
```

## Namespace Declarations

### Structure

```clojure
(ns project.module
  (:refer-clojure :exclude [next replace])
  (:require
   [clojure.set :as set]
   [clojure.string :as str])
  (:import
   java.util.Date
   [java.util.concurrent Executors LinkedBlockingQueue]))
```

### Rules

- Avoid single-segment namespaces. Use `project.module` or
  `org.project.module`; `user` and `dev` are exceptions.
- Use no more than five namespace segments.
- Prefer `:require :as` over `:require :refer`, and `:require :refer` over
  `:require :refer :all`. Avoid `:use`.
- Sort requirements alphabetically.
- Keep one file per namespace and one namespace per file.

### Idiomatic Aliases

| Namespace | Alias |
|---|---|
| `clojure.string` | `str` |
| `clojure.set` | `set` |
| `clojure.java.io` | `io` |
| `clojure.edn` | `edn` |
| `clojure.walk` | `walk` |
| `clojure.pprint` | `pp` |
| `clojure.spec.alpha` | `s` |
| `clojure.core.async` | `async` |
| `clojure.tools.logging` | `log` |

Follow project conventions when they differ from this table.

### Function Naming

Follow Stuart Sierra's conventions:

- Name pure functions with nouns that describe their return values: `age`, not
  `get-age`.
- Name side-effecting functions with verbs: `create-user`, `fetch-data`, or
  `send-message`.
- Name coercions from multiple input types for their output: `file`, `reader`.
- Name conversions from a specific input to a specific output
  `input->output`.
- Do not repeat the namespace in a function name: `products/price`, not
  `products/product-price`.
- Give functions that return functions an `-fn` suffix unless they follow a
  standard naming pattern.

### Idiomatic Parameter Names

| Name | Meaning |
|---|---|
| `f`, `g`, `h` | Function |
| `n` | Integer size |
| `i` | Index |
| `x`, `y` | Numbers |
| `xs` | Sequence |
| `m` | Map |
| `k`, `v` | Key and value |
| `s` | String |
| `coll` | Collection |
| `pred` | Predicate |
| `xf` | Transducer |
| `expr`, `body`, `binding` | Macro forms |
| `this` | Protocol receiver |

## Functions

### Definition Style

```clojure
(defn foo [x]
  (bar x))

(defn foo
  [x]
  (bar x))

;; Multi-arity: order from fewest to most arguments and align bodies.
(defn foo
  ([x]
   (foo x 1))
  ([x y]
   (+ x y)))

;; Multimethod: keep the dispatch value on the same line.
(defmethod foo :bar [x]
  (baz x))
```

### Guidelines

- Fewer than 10 lines of code is ideal; fewer than 5 is better. Smaller
  functions reduce tokens and make edits faster.
- Accept no more than three or four positional parameters.
- Prefer preconditions and postconditions to checks inside the function:
  `{:pre [(pos? x)]}`.
- Make each function do one thing.
- Prefer pure functions to functions with side effects.
- Return useful values that callers can use.
- Use `^:no-doc` to exclude an implementation var from generated docs.

### Avoid: Trivial Wrapper Indirection

Trivial wrapper indirection is a helper whose body merely renames or repackages
an obvious expression without encapsulating meaningful complexity, policy, or
substantial duplication. The helper creates a needless hop between the call
site and its definition.

Fix it by replacing each call with the helper's body and deleting the helper.
When a borderline helper has only one call site, treat it as trivial and inline
it. Multiple call sites do not by themselves justify the indirection. Keep a
helper only when it captures a meaningful abstraction, non-obvious behavior,
domain policy, or substantial duplication that should evolve as one unit.

The patterns below are examples, not an exhaustive definition. Trivial wrapper
indirection can take any syntactic form. Judge whether the helper adds a
meaningful abstraction rather than whether it matches one of these exact
shapes.

Wrappers around literals or straightforward constructors are common examples:

```clojure
;; Avoid.
(defn- error [id]
  {:error id})

(error :invalid-email)

;; Prefer.
{:error :invalid-email}
```

Redundant nil guards are another example. Check the callee before wrapping
it; do not guard against `nil` when the called function already handles it.
For example, if `form/trim-value` already performs the required nil handling
and conversion:

```clojure
;; Avoid.
(defn- trimmed [value]
  (some-> value str form/trim-value))

(trimmed value)

;; Prefer.
(form/trim-value value)
```

Small functions are not inherently a problem. Meaningless indirection is.

## Comments

Minimize comments. Prefer self-explanatory code. Do not add comments unless the
code is complex and requires additional context.

```clojure
;;;; Section headings (4 semicolons)

;;; Top-level comments (3 semicolons)

(defn foo []
  ;; Code fragment comments (2 semicolons)
  (bar)
  x)  ; Margin comments (1 semicolon, rare)

;; Prefer #_ to comment out forms.
(+ foo #_(bar) baz)

;; Annotations: TODO, FIXME, OPTIMIZE, HACK, REVIEW
;; Put the annotation above the code, not inline.
;; FIXME: Description here. (initials date)
```

Do not create comments that act as section separators, such as `;; =====` or
`;; -----`.

## Docstrings

Always load and follow the
[`clojure-docstring`](../clojure-docstring/SKILL.md) skill when writing or
reviewing Clojure docstrings. Its rules take precedence over general prose
conventions.

## Testing

### Structure

- Directory: `test/project/`
- Namespace: `project.module-test`
- Test names: `something-test`, defined with `deftest`

### Guidelines

```clojure
(ns project.core-test
  (:require [clojure.test :refer [deftest testing is are use-fixtures]]
            [project.core :as core]))

(deftest addition-test
  (testing "positive numbers"
    (is (= 4 (core/add 2 2)))))
```

- Use `is`, `are`, `testing`, and `use-fixtures`.
- Write simple assertions as `(is (= expected actual))`.
- Use descriptive names that identify edge cases.
- Keep tests isolated, deterministic, and focused.
- Follow Arrange-Act-Assert.
- Mock external dependencies at their boundaries; do not mock the behavior
  under test.
- Test normal execution paths and error conditions.
- Always reload namespaces before running tests:
  `(require '[namespace] :reload)`.
