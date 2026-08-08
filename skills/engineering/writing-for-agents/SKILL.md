---
name: writing-for-agents
description: Write documents agents consume. Use when creating or editing skills, AGENTS.md, CLAUDE.md, or instructions reached from them.
---

# Writing for Agents

Write for the next agent that must act on the document. A good document produces a repeatable process, not identical prose or code.

For skill metadata, invocation, and router skills, read [SKILL-MECHANICS.md](SKILL-MECHANICS.md).

## Context pointers

A context pointer names material outside the current context and states when to read it. A skill description and an `AGENTS.md` instruction are both context pointers. The pointer's wording determines whether the agent reaches the material.

A pointer should name the material, lead with its trigger term, and list distinct cases that require it. Remove synonyms that describe the same case and facts the target already explains.

## Information hierarchy

A document can contain steps, reference material, or both. Put material where the agent needs it:

1. **Steps** — ordered actions needed on every run.
2. **Inline reference** — rules or facts needed during most runs.
3. **Disclosed reference** — a separate file reached through a clear pointer when a particular case requires it.

Keep steps easy to find. Move conditional reference into a linked file only when its trigger is clear. Keep related definitions and rules together so reading one brings the relevant details with it.

## Steps and completion criteria

Every step needs a completion criterion. Make it checkable and, when coverage matters, exhaustive. A vague criterion lets an agent finish before the necessary work is complete.

Split a sequence only when later steps repeatedly distract from the current step. First make the current criterion clearer; a separate document or handoff is warranted only when that does not work.

## Leading words

Use compact, familiar terms that give the agent a stable concept to apply, such as *tight* feedback loop, *tracer bullet*, or *fog of war*. Repeat the term where it guides action. Prefer an established term over a new label that requires a long definition.

## Prune

- Keep each meaning in one authoritative location.
- Treat source code, configuration, directory layout, and command help as truth. A document that repeats them is a **cache**. Cache only information the agent cannot discover quickly: conventions, rationale, and gotchas.
- Remove lines that do not change agent behavior. Test a sentence against the default behavior, not against what a human reader already knows.
- State the desired behavior positively. Use a prohibition only for a hard guardrail, paired with the action to take instead.
