---
name: research
description: Investigate a question against high-trust primary sources and capture the findings as a Markdown file in the repo. Use when the user wants a topic researched, docs or API facts gathered, or reading legwork delegated to a background agent.
---

Determine the output path before starting the research:

- If the user specified a location, use it.
- Otherwise, use `report.md` in an existing `.scratch/NNN-<concept-or-feat>/` directory that matches the research topic.
- If no matching concept directory exists, create `.scratch/NNN-<concept-or-feat>/` using the next available `NNN` from the shared repo-wide sequence, then use `report.md` inside it.
- If multiple directories plausibly match, or the destination `report.md` already exists, ask instead of guessing or overwriting.

Then use Skill(sub-agents) to delegate the research to another agent, so you keep working while it reads.

Its job:

1. Investigate the question against **primary sources** — official docs, source code, specs, first-party APIs — not a secondary write-up of them. Follow every claim back to the source that owns it.
2. Write the findings to a single Markdown file, citing each claim's source.
3. Save it to the resolved output path.
