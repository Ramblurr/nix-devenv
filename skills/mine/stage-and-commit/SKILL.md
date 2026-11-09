---
name: stage-and-commit
description: Stage only the agent's own changes and commit them safely. Use only when explicitly invoked to create a commit.
disable-model-invocation: true
---

Stage only your own changes related to your current task, then commit them.

- Inspect `git status` and possibly diffs
- If other unrelated changes share a file, use Skill(git-lines) to stage only your lines.
- Before drafting the commit message, run
  `git log -20 --no-merges --format='%s'`. Match the repository's established
  scope syntax and naming; repository history takes precedence over generic examples.
- Use Skill(scoped-commits) for the commit message.
- If agents share the Git index or HEAD, coordinate exclusive staging/commit access through the active harness's Skill(agent-coordination), including unrelated top-level agents and their sub-agent trees. Honor any existing coordinator's lock protocol; wait for the current holder to release access before staging. Release access after commit or abort. If coordination is unavailable, stop rather than race another agent.
