---
name: coding-agents
description: Spawn and control external coding agents (Pi, Claude Code, Codex) for delegating tasks. Use when (1) user asks to run another coding agent, (2) delegating subtasks (such as a code review) to a different AI tool, (3) running multiple agents in parallel on separate issues, (4) spawning an agent in an isolated environment or worktree
---

# Coding Agents

Orchestrate external coding agents programmatically. Use this when you want to delegate tasks to other AI coding tools.

If you yourself are a Pi agent:
- Always prefer to spawn additional pi subagents (unless told otherwise). Communicate with them using Skill(pi-link-coordination). If you are not connected to the link hub, that is an error condition, abort and ask the human to fix that right away.
- Use `link_list` to see if you need to spawn additional agents according to your collaboration policy. 

If you are a Codex agent:
- Always prefer your collaboration.spawn_agent tool (unless told otherwise) to spawn subagents.
- Only use the tmux workflow when controlling non-pi agents.

## Use tmux for interactive agent orchestration

Use interactive tmux sessions for agent orchestration.

tmux provides a persistent, observable environment where you can monitor progress, respond to questions, interrupt incorrect work, and debug issues without losing session state.

The Skill(tmux) defines the required orchestration patterns, including:

* Use of `tmuxb`, tmux buddy tool.
* The "Orchestrating Claude Code sub-agents" recipe
* Socket conventions and session management
* Sending input to agents
* Monitoring agent output
* Detecting completion
* Cleaning up sessions

You MUST read and follow Skill(tmux) whenever orchestrating an interactive agent session.

For parallel work on multiple issues, use the git Skill(using-git-worktrees)  to create isolated branches and avoid conflicts.

## Available agents

Read the relevant reference file for the agent you need right now:

- [references/pi.md](references/pi.md) - Pi, Lightweight multi-provider agent
- [references/claude-code.md](references/claude-code.md) - Anthropic's Claude Code CLI
- [references/codex.md](references/codex.md) - OpenAI's Codex CLI

Each reference includes: invocation, key flags, and completion detection.

## Rules

1. Respect tool choice - if user asks for Codex, use Codex. Do not offer to do the task yourself.
2. Be patient - do not kill sessions because they seem slow. Agents take time.
3. Monitor without interfering - check progress but let the agent work.
4. Use appropriate flags - permission-bypassing flags for unattended/background work only.
5. Isolate work - use worktrees or temp directories to avoid conflicts with your current work.
6. Clean up - kill sessions and remove worktrees when done, unless the user asked you not to.
