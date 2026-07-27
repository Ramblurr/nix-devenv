---
name: clojure-style-guide
description: Defines Clojure conventions for layout, naming, namespaces, functions, comments, docstrings, and tests. Always use when writing or reviewing Clojure, ClojureScript, or Babashka code, including .clj, .cljs, .cljc, and .bb files.
---

# Clojure Style Guide

Write Clojure for readers first. Apply this guide to new code and preserve local
style when changing existing code.

## Core Principles

1. Code is written for humans; optimize readability.
2. Prefer functional approaches and immutable data.
3. Consistency: project > file > form > this guide.
4. Deviate only when readability, compatibility, or history demand it.

## Workflow

1. Read the project's instructions, formatter configuration, and nearby code.
2. Follow the precedence rule above instead of restyling unrelated code.
3. Read and apply [STYLE.md](STYLE.md) before writing or reviewing code.
4. When writing or reviewing docstrings, also load and follow the
   [`clojure-docstring`](../clojure-docstring/SKILL.md) skill.
5. Keep functions small and focused. Prefer pure functions and immutable data.
6. Run the project's formatter, linter, and focused tests after editing.
7. Check the final diff for tabs, trailing whitespace, accidental reformatting,
   and missing final newlines.

## Non-negotiable Defaults

Unless a higher-precedence convention overrides them:

- Use spaces, never tabs.
- Prefer 80-character lines; never exceed 120 characters.
- Use Unix line endings and end every file with a newline.
- Put one blank line between top-level forms, except grouped related `def`s.
- Do not add explanatory comments when clear names and structure suffice.
- Keep tests isolated, deterministic, focused, and explicit about expected
  behavior.

## Detailed Reference

[STYLE.md](STYLE.md) defines the required layout, naming, namespace, function,
comment, docstring, and testing conventions with examples.
