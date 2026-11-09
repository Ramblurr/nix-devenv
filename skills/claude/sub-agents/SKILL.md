---
name: sub-agents
description: Delegate work to Claude Code sub-agents. Use when the user or another skill asks for sub-agents, delegation, or parallel agent work.
---

# Sub-agents

Use the Claude Code harness's built-in sub-agent tool to spawn and coordinate sub-agents. It is named `Agent` (`Task` in older versions) and takes a `subagent_type`.

For shared-resource ownership or communication with independent peers, use [Agent coordination](../agent-coordination/SKILL.md). When running under T3 Code, follow its injected delegation instructions instead of this standalone procedure.
