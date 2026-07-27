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

**IMPORTANT:** Do NOT try to manually repair parenthesis errors. If you encounter a file with unbalanced parentheses or delimiters, run `brepl balance` on that file instead of attempting to fix the delimiters yourself.

## If the Tool Fails

If brepl doesn't fix the problem, report to the user that they need to fix the delimiter error manually. Do not continue attempting repairs.
