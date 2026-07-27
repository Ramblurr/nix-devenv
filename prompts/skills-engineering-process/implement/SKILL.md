---
name: implement
description: Implements a piece of work from a spec or set of tickets. Use when the user asks to build approved work or execute implementation tickets.
disable-model-invocation: true
---

# Implement

Implement the work described by the user's spec or tickets.

1. Read the source artifacts completely and inspect the relevant code. Record the starting commit with `git rev-parse HEAD`; this is the fixed point for the final review.
2. Use Skill(tdd) or Skill(clojure-repl-driven-development) where possible, testing only at seams agreed with the user.
3. Work in small vertical slices. Run the focused test file and relevant linter, typecheck or static checks regularly.
4. Run the project's full qa suite (formatter, linter, tests) once after implementation is complete.
5. Commit the implementation to the current branch. Do not include unrelated working-tree changes. Use Skill(scoped-commits) for any new commit message.
6. Run Skill(code-review) against the starting commit. It reviews committed changes only and writes the review under the appropriate `.scratch/NNN-<feature-or-concept>/` directory.

If review findings require changes, address the accepted findings, rerun the relevant checks, commit the fixes, and run Skill(code-review) again against the same fixed point.

Take the findings with a grain of salt, reviewers are not infallible. If you suspect a reviewer is wrong:

- Push back with technical reasoning
- Show code/repl evals/tests that prove it works
- Request clarification
- Loop in the human
