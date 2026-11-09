---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as an Org mode report. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

Determine the output path before starting the research:

- If the user specified a location, use it.
- Otherwise, use `report.org` in an existing `.scratch-org/NNN-<concept-or-feat>/` directory that matches the research topic.
- If no matching concept directory exists, create `.scratch-org/NNN-<concept-or-feat>/` using the next available `NNN` from the shared repo-wide sequence, then use `report.org` inside it.
- If multiple directories plausibly match, or the destination `report.org` already exists, ask instead of guessing or overwriting.

If the user told you to use delegate to a subagent, then use Skill(sub-agents) to delegate the research to another agent, so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings to a single Org mode file, citing each claim's source with Org links. Follow [Write history, not an undated present](../writing-for-agents/SKILL.md#write-history-not-an-undated-present): date observations and identify the source version examined; for code, include the repository and commit, distinguishing uncommitted changes. For mutable sources without a version, record the access date. Write "As observed on <date>, version X supported Y", not "X supports Y". Mark revised conclusions superseded and append dated corrections rather than silently rewriting earlier findings.
3. Save it to the resolved output path.
