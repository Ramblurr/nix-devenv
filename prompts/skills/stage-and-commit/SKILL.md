---
name: stage-and-commit
description: Stage only the agent's own changes and commit them safely. Use only when explicitly invoked to create a commit.
disable-model-invocation: true
---

Stage only your own changes related to your current task, then commit them.

- Inspect `git status` and possibly diffs
- If other unrelated changes share a file, use Skill(git-lines) to stage only your lines.
- Use Skill(scoped-commits) for the commit message.
- If the `link_send` tool is available, coordinate staging/commit access:
  - Before staging: broadcast that you are taking the staging/commit lease.
  - After commit or abort: broadcast all-clear/release with `triggerTurn: true`.
  - If your history indicates that there's an agent that has a lease, then wait for the all clear.
