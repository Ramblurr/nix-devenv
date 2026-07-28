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

## Project scope boundary

The Link hub is shared by agents from many unrelated projects. Treat `link_list` as a global directory, not as a pool of workers available to your project.

Before selecting a worker, determine your `<scope>` as defined under **Naming your subagent**. A terminal is eligible only when its Link name begins with the exact `<scope>@` prefix. Filter by scope before considering role, status, cwd, or repository access; a matching role such as `reviewer` never makes a foreign-scope terminal eligible.

Never send tasks or prompts to, or compact, an out-of-scope terminal. Ignore those terminals. If too few eligible terminals exist, boot new agents in your project scope as described below.

This `<scope>@<role>` policy overrides generic naming examples in Skill(pi-link-coordination).

## Use one tmux session per project

Use interactive tmux sessions for agent orchestration. They provide a persistent, observable environment where you can monitor progress, answer questions, interrupt incorrect work, and debug without losing session state.

Before booting an agent, read and follow Skill(tmux), then run `tmuxb list` from the project cwd. Reuse the project's existing tmux session when one exists. A `.tmuxb_session` file identifies that session when present.

The project session may already contain REPLs, watchers, dev servers, or other long-lived processes. Preserve them. Launch each new agent in its own window or pane inside that same project session; never create a tmux session per agent, role, or reviewer.

If the project has no tmux session, create exactly one project-scoped session with `tmuxb new <scope>`. Put all agents and long-lived project processes in that session. Follow Skill(tmux) for session discovery, pane control, capture-before-send, and verification.

## Booting Sub Agents

When `link_list` shows too few eligible agents in your project scope, boot them in new windows or panes of the shared project tmux session.

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
2. Use `link_list` to select an eligible idle worker under the **Project scope boundary**. Assign at most one active task to each worker.
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
