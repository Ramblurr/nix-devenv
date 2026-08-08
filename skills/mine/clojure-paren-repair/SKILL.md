---
name: clojure-paren-repair
description: Repair unbalanced parentheses, brackets, and braces in Clojure, ClojureScript, and EDN files. Use when you encounter delimiter mismatch syntax errors after editing .clj, .cljs, .cljc, or .edn files, or on clojure syntax errors.
---

# Clojure Parenthesis Repair (how to fix unbalanced brackets/parens)

Use the `brepl balance` file-repair subcommand, not an nREPL eval form, to fix unbalanced brackets in Clojure files using parmezan:

```bash
# Preview fix to stdout
brepl balance src/myapp/core.clj --dry-run

# Fix file in place
brepl balance src/myapp/core.clj
```

`--dry-run` only previews; do not copy its output back into the file. Run without `--dry-run` to apply, then review the diff.

## When to Use

Run this tool when you encounter unbalanced delimiters (parentheses, brackets, braces) in Clojure, ClojureScript, or EDN files.


## If the Tool Fails

If brepl doesn't fix the problem, then analyze the issue surgically and make a normal edit to fix it in several small targeted changes. Target the smallest number of lines changes needed. 

Common mistakes are:

- missing a closing " on a docstring
- brepl balance "fixed" the issue by inserting a closing paren at EOF instead of where it needs to go
