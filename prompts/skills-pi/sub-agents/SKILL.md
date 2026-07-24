---
name: sub-agents
description: Spawn and control external coding agents for delegating tasks. Use when (1) user asks to run another coding agent, (2) delegating subtasks (such as a code review) to a different AI tool, (3) running multiple agents in parallel on separate issues, (4) spawning an agent in an isolated environment or worktree
---

# Coding Agents

This skill about the mechanics of spawning a pi coding agent.

Orchestrate external coding agents programmatically. Use this when you want to delegate tasks to other AI coding tools.

Communicate with them using Skill(pi-link-coordination).

PRE FLIGHT CHECK :If you are not connected to the link hub, and don't have `link_*` tools that is an error condition. Abort now and ask the human to fix that right away.

Use `link_list` to see if you need to spawn additional agents according to your collaboration policy.

For `link_*` tool mechanics (link_send / link_prompt / link_compact / link_list, the
Golden Rule, delivery shapes, anti-patterns) load Skill(pi-link-coordination)
and read it first.

## Use tmux for interactive agent orchestration

Use interactive tmux sessions for agent orchestration.

tmux provides a persistent, observable environment where you can monitor progress, respond to questions, interrupt incorrect work, and debug issues without losing session state.

The Skill(tmux) defines the required orchestration patterns, including:

* Use of `tmuxb`, tmux buddy tool.
* Socket conventions and session management
* Sending input to tmux
* Monitoring agent output in tmux

Tmux rules:
- You MUST read and follow Skill(tmux) whenever orchestrating an interactive agent session.
- One tmux session per project. REPL, dev watchers, agents, all go in one tmux session


## Invocation

```bash
# Interactive, use this by default unless human instructions otherwise
pi --link-name <scope>@<role>

# Non-interactive (runs and exits)
pi -p "Your task"

# Include files in prompt
pi --link-name <scope>@<role> @file.md @image.png "Analyze these"
```

## Naming your subagent

Your subagent's link name must follow this format: `<scope>@<role>`

`<scope>` is basename("$(pwd)")

Common `<role>`s: leader, dev, dev1, dev2, reviewer, researcher

## Key Flags

- `--link-name`: see Skill(pi-link-coordination)
- `--tools <list>`: Comma-separated tools to enable. Use this rarely.
- `--thinking <level>`: Thinking level: off, minimal, low, medium, high, xhigh. Use this rarely, prefer the default.
- `-p, --print`: Non-interactive mode, runs prompt and exits. Generally do not use this mode.

`pi --help` for more info

## Examples

```bash
# Read-only mode (no file modifications)
pi --link-name <scope>@<role> --tools link_list,link_send,read,grep,find,ls -p
# then `link_send(triggerTurn: true)` with prompt "Review the code in src/"
```

## Important:

- Your dispatch must be self-contained and sent via `link_send(triggerTurn:true)`.
- For active work: Do not use `link_prompt` (90s inactivity) would block you and risk timeout.
- For not active work (Quick pre-start question, etc):  `link_prompt` is fine.

## Completion Detection

- Non-interactive mode: program exits
- Interactive mode: returns to Pi TUI prompt

## Exit Command

Ctrl+C
