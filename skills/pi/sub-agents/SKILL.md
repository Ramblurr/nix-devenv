---
name: sub-agents
description: Spawn and control external coding agents for delegating tasks. Use when (1) user asks to run another coding agent, (2) delegating subtasks (such as a code review) to a different AI tool, (3) running multiple agents in parallel on separate issues, (4) spawning an agent in an isolated environment or worktree
---

# Coding Agents

This skill about the mechanics of spawning a pi coding agent.

Orchestrate external coding agents programmatically. Use this when you want to delegate tasks to other AI coding tools.

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


## Booting Sub Agents

If you use the `link_list` tool and notice there are no suitable agents with your project scope, then you should boot them up inside your tmux session in an appropriately named tmux pane.

```bash
# Interactive, use this by default unless human instructions otherwise
pi --link-name <scope>@<role>

# Non-interactive (runs and exits)
pi -p "Your task"

# Include files in prompt
pi --link-name <scope>@<role> @file.md @image.png "Analyze these"
```

### Naming your subagent

Your subagent's link name must follow this format: `<scope>@<role>`

`<scope>` is basename("$(pwd)")

Common `<role>`s: leader, dev, dev1, dev2, reviewer, researcher

### Key Flags

- `--link-name`: see Skill(pi-link-coordination)
- `--tools <list>`: Comma-separated tools to enable. Use this rarely.
- `--thinking <level>`: Thinking level: off, minimal, low, medium, high, xhigh. Use this rarely, prefer the default.
- `-p, --print`: Non-interactive mode, runs prompt and exits. Generally do not use this mode.

`pi --help` for more info

### Examples

```bash
# Read-only mode (no file modifications)
pi --link-name <scope>@<role>
# then `link_send(triggerTurn: true)` with prompt "Review the code in src/"
```

## Dispatching Tasks to Subagents

Read Skill(pi-link-coordination) before using the Link tools.

### Choose the mode

- **Quick consultation:** One bounded question, answerable mostly from existing context with little tool use and predictably short execution. Use `link_prompt`. No issue is required.
- **Delegated task:** Research, implementation, substantial tool use, multiple stages, or uncertain execution time. Follow the workflow below.

### Dispatch a delegated task

1. Ensure an independently executable task exists in the issue tracker. Create it first if necessary. The issue is the single source of truth; do not repeat its requirements in the dispatch.
2. Use `link_list` to select a suitable idle worker. Assign at most one active task to each worker.
3. Manage context at the task boundary:
   - Dispatch directly to a fresh worker.
   - Before switching a worker to a different task, compact it while idle.
   - Preserve its context throughout the current task.

   A task remains active until its final callback is accepted and no follow-up is expected. Fixes, blocked-question responses, validation retries, convergence, and commit work remain part of the same task. Never compact during this period.
4. Send the assignment with `link_send(triggerTurn: true)`. Include only:
   - Task name and issue ID
   - This callback contract:
     - Reply to the orchestrator's exact Link name with `link_send(triggerTurn: true)`.
     - Include the task ID and `DONE` or `BLOCKED`.
     - Include the deliverable file path, or state `no deliverable file`.
     - For `BLOCKED`, include the blocker or question.
5. Track the task and worker as outstanding. Dispatch independent tasks to distinct workers before yielding.

### Wait for completion

Continue unrelated work or end the turn. The callback is the completion signal; do not sleep or poll for progress.
