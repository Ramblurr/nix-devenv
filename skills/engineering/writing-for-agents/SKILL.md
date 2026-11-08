---
name: writing-for-agents
description: Write documents agents consume. Use when creating or editing skills, AGENTS.md, CLAUDE.md, or instructions reached from them.
---

# Writing for Agents

Write for the next agent that must act on the document. A good document produces a repeatable process, not identical prose or code.

For skill metadata, invocation, and router skills, read [SKILL-MECHANICS.md](SKILL-MECHANICS.md).

## Context pointers

A context pointer names material outside the current context and states when to read it. A skill description and an `AGENTS.md` instruction are both context pointers. The pointer's wording determines whether the agent reaches the material.

When a necessary reference is missed, sharpen its pointer before inlining the reference.

A pointer should name the material, lead with its trigger term, and list distinct cases that require it. Remove synonyms that describe the same case and facts the target already explains.

## Two costs

Always-loaded instructions and skill descriptions spend **context load** on every turn. Material reached only by a human spends **cognitive load**: the human must remember it exists. Keep human control where judgment matters; make shared reference discoverable where it does not.

## Information hierarchy

A document can contain steps, reference material, or both. Put material where the agent needs it:

1. **Steps** — ordered actions needed on every run.
2. **Inline reference** — rules or facts needed during most runs.
3. **Disclosed reference** — a separate file reached through a clear pointer when a particular case requires it.

Keep steps easy to find. Move conditional reference into a linked file only when its trigger is clear. Keep related definitions and rules together so reading one brings the relevant details with it.

## Steps and completion criteria

Every step needs a completion criterion. Make it checkable and, when coverage matters, exhaustive. A vague criterion lets an agent finish before the necessary work is complete.

Split a sequence only when later steps repeatedly distract from the current step. First make the current criterion clearer; a separate document or handoff is warranted only when that does not work. Hiding later steps requires a real context boundary, such as a fresh agent or a handoff; reading another file in the same conversation does not remove the later steps.

## Leading words

Use compact, familiar terms that give the agent a stable concept to apply, such as *tight* feedback loop, *tracer bullet*, or *fog of war*. Repeat the term where it guides action. Prefer an established term over a new label that requires a long definition.

## Write history, not an undated present

Research findings, handoffs, ledgers, and decision records describe what was observed or decided, not what must still be true when someone reads them later.

- Date each observation or decision; a clearly dated section can cover several related claims.
- For code claims, cite the repository and commit examined. Identify uncommitted changes separately rather than attributing them to that commit.
- Write "On <date>, the check passed at <repo>@<commit>", not "the check passes". Avoid unqualified "is", "now", and "currently" when recording changeable facts.
- When later evidence changes a conclusion, add a dated correction and mark the earlier claim superseded. Preserve the earlier evidence instead of silently rewriting history.
- Treat a status summary as an **as-of snapshot**: timestamp it and retain the events behind it. Recheck volatile facts before acting on them.

This rule applies to historical evidence, not every sentence. Definitions, instructions, and specifications may use present tense.

## Prune

- Keep each meaning in one authoritative location.
- Treat source code, configuration, directory layout, and command help as truth. A document that repeats them is a **cache**. Cache only information the agent cannot discover quickly: conventions, rationale, and gotchas.
- Remove lines that do not change agent behavior. Test a sentence against the default behavior, not against what a human reader already knows.
- State the desired behavior positively. Use a prohibition only for a hard guardrail, paired with the action to take instead.
