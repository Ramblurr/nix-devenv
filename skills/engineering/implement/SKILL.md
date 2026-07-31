---
name: implement
description: Implements a piece of work from a spec or set of tickets.
---

Implement the work described by the user in the spec or tickets.

Use Skill(tdd) or Skill(clojure-repl-driven-development) where possible, testing only at seams agreed with the user.

Work in small vertical slices. Run the focused test file and relevant linter, typecheck or static checks regularly.

Run the project's full qa suite (formatter, linter, tests) once after implementation is complete.

Commit your work to the current branch with Skill(scoped-commits)

Once done, use Skill(code-review) to review the work. Loop fix findings -> commit (ammend!) -> review until satisfied.

Take the findings with a grain of salt, reviewers are not infallible. If you suspect a reviewer is wrong:

- Push back with technical reasoning
- Show code/repl evals/tests that prove it works
- Request clarification
- Loop in the human

If working from a local Org ticket (`.scratch-org/…/issues/<NN>-<slug>.org`), check its completed acceptance criteria, append resolution evidence under `** Answer` or `** Resolution`, and change the first heading's TODO state to `RESOLVED` before reporting completion.

The tracker directory is deliberately outside Git: save the ticket but never stage or commit it. Blocking edges read the Org TODO state, so leaving the ticket `READY-FOR-AGENT`, `IN-PROGRESS`, or `CLAIMED` silently holds up the frontier.
