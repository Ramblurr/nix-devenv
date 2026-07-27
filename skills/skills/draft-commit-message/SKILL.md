---
name: draft-commit-message
description: Draft a commit message for the current completed task. Use only when explicitly invoked to produce a commit message without committing.
disable-model-invocation: true
---

Draft a commit message for the task you just worked on.

- Follow Skill(scoped-commits).
- Do not stage, commit, or mutate the repo.
- Return only the proposed commit message unless context is needed.
- The user may optionally prompt you to generate more than one possible commit message or give you other instructions. That will be below.
