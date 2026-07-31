---
name: handoff
description: Compact the current conversation into a handoff document for another agent to pick up.
argument-hint: "What will the next session be used for?"
disable-model-invocation: true
---

Write an Org mode handoff document summarizing the current conversation so a fresh agent can continue the work.

Save it as `.scratch-org/handoffs/NNN-<slug>.org`. Scan only `.scratch-org/handoffs/` for the highest existing three-digit prefix and increment it, starting at `001`; this handoff sequence is independent of the shared `.scratch-org/NNN-<work-item>/` sequence. Create the directory when needed and never overwrite an existing handoff.

Include a "suggested skills" section in the document, which suggests skills that the agent should invoke.

Do not duplicate content already captured in other artifacts (specs, plans, ADRs, issues, commits, diffs). Reference them by path or URL instead.

Redact any sensitive information, such as API keys, passwords, or personally identifiable information.

If the user passed arguments, treat them as a description of what the next session will focus on and tailor the doc accordingly.
