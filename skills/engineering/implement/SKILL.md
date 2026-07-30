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

If working from a local markdown ticket (`.scratch/…/issues/<NN>-<slug>.md`), tick off any checkboxes tracking the work inside and update its `**Status:**` field to `resolved` as part of the same commit, so the resolved state and the code land atomically. If .scratch is gitignored, thats fine leave it that way.

Blocking edges on other tickets read this field to determine when they can start, so leaving it as `ready-for-agent` after the work is done silently holds up the frontier.
