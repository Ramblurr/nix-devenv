---
name: sub-agents
description: Delegate work under T3 Code. Use when the user or another skill asks for sub-agents, delegation, parallel agent work, or an isolated agent checkout.
---

# Sub-agents

Follow the **Subagents** rules in the runtime-injected **T3 Code orchestration** instructions (`<t3_code_orchestration>`). They govern tool selection, capabilities, task lifecycle and checkout isolation; use the live tool descriptions for parameters.

Treat another skill's Pi Link, tmux or provider-native dispatch steps as a task brief, not a transport requirement. Route that brief through T3's tool-selection rules while preserving its scope, deliverables and acceptance criteria.

For peer communication or shared-resource access, use [Agent coordination](../agent-coordination/SKILL.md), including coordination with unrelated top-level threads. Routine child results stay on the runtime's delegation/completion mechanism.

If the T3 instructions are missing, ask for them rather than falling back to another harness's sub-agent skill.
