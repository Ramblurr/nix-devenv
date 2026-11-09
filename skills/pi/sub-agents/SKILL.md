---
name: sub-agents
description: Spawn and control external coding agents for delegating tasks. Use when (1) user asks to run another coding agent, (2) delegating subtasks (such as a code review) to a different AI tool, (3) running multiple agents in parallel on separate issues, (4) spawning an agent in an isolated environment or worktree
---

# Coding Agents

This skill about the mechanics of spawning a pi coding agent.

Orchestrate external coding agents programmatically. Use this when you want to delegate tasks to other AI coding tools.

PRE FLIGHT CHECK :If you are not connected to the link hub, and don't have `link_*` tools that is an error condition. Abort now and ask the human to fix that right away.

Use `link_list` to see if you need to spawn additional agents according to your collaboration policy.

For Link tool mechanics, read Skill(pi-link-tools) and the live tool descriptions.

## Project scope boundary

Follow [Agent coordination — Find peers](../agent-coordination/SKILL.md#find-peers) for project scope and identity checks. Select only workers assigned to you or explicitly made available for delegation. If too few eligible workers exist, boot new agents as described below.

## Use one tmux session per project

USE ONE tmux session per project! Even if it already exists and you didn't create it.

Use interactive tmux sessions for agent orchestration.
They provide a persistent, observable environment where you can monitor progress, answer questions, interrupt incorrect work, and debug without losing session state.

Before booting an agent, read and follow Skill(tmux), then run `tmuxb list` from the project cwd. Reuse the project's existing tmux session when one exists. A `.tmuxb_session` file identifies that session when present.

The project session may already contain REPLs, watchers, dev servers, or other long-lived processes. Preserve them. Launch each new agent in its own window or pane inside that same project session; never create a tmux session per agent, role, or reviewer.

If the project has no tmux session, create exactly one project-scoped session with `tmuxb new <scope>`. Put all agents and long-lived project processes in that session. Follow Skill(tmux) for session discovery, pane control, capture-before-send, and verification.

## Booting Sub Agents

When `link_list` shows too few eligible agents in your project scope, boot them in new windows or panes of the shared project tmux session.

```bash
# Interactive, use this by default unless human instructions otherwise
pi --link-name <role>@<scope>

# Non-interactive (runs and exits)
pi -p "Your task"

# Include files in prompt
pi --link-name <role>@<scope> @file.md @image.png "Analyze these"
```

### Naming your subagent

Use the `<role>@<scope>` convention from [Agent coordination](../agent-coordination/SKILL.md#find-peers).

Common `<role>`s: leader, dev, dev1, dev2, reviewer, researcher

### Key Flags

- `--link-name`: use the naming convention above.
- `--tools <list>`: Comma-separated tools to enable. Use this rarely.
- `--thinking <level>`: Thinking level: off, minimal, low, medium, high, xhigh. Use this rarely, prefer the default.
- `-p, --print`: Non-interactive mode, runs prompt and exits. Generally do not use this mode.

`pi --help` for more info

### Examples

```bash
pi --link-name <role>@<scope>
# then use link_send with the review assignment

# Launch an agent into the project's tmux session
tmux new-window -t <project-session> -n reviewer2 -c "$PWD" \
     'pi --link-name reviewer1@<scope>'
```

Or, send keys with tmux to type the command `/link-name <role>@<scope>[ENTER]` to change the name of a running agent.

Always keep the role of your subagents up to date.

## Dispatching Tasks to Subagents

Follow Skill(pi-link-tools) for messaging and waiting.

### Choose the mode

- **Quick consultation:** Send one bounded question with `link_send` and request a reply. Follow Skill(pi-link-tools) to await it. No issue is required.
- **Delegated task:** Research, implementation, substantial tool use, multiple stages, or uncertain execution time. Follow the workflow below.

### Dispatch a delegated task

1. Prepare an independently executable assignment. Reference the existing issue when the workflow has one; otherwise use the caller's self-contained brief. Do not create an issue merely to delegate migration, research, design or review work.
2. Use `link_list` to select an eligible idle worker under the **Project scope boundary**. Assign at most one active task to each worker.
3. Manage context at the task boundary:
   - Dispatch directly to a fresh worker.
   - Before switching a worker to a different task, compact it while idle.
   - Preserve its context throughout the current task.

   A task remains active until its final callback is accepted and no follow-up is expected. Fixes, blocked-question responses, validation retries, convergence, and commit work remain part of the same task. Never compact during this period.
4. Send the assignment with `link_send`. Include:
   - Task name and ID, plus the issue path or complete brief, inputs, scope and completion criteria
   - This callback contract:
     - Reply to the orchestrator's exact Link name with `link_send`.
     - Include the task ID and `DONE` or `BLOCKED`.
     - Include the deliverable file path, or state `no deliverable file`.
     - For `BLOCKED`, include the blocker or question.
5. Track the task and worker as outstanding. Dispatch independent tasks to distinct workers before yielding.

### Review assignments

For Skill(requesting-code-review), select distinct eligible same-scope reviewers and send the caller's self-contained briefs. Keep reviewer context through fixes and re-reviews of the same ticket or task. Compact a reused reviewer only when switching to a different task, while idle, and wait for completion before dispatch; fresh reviewers need no compaction.

Dispatch with `link_send` to each reviewer's exact Link name. Include the requester's exact Link name and require a final `link_send` reply of `APPROVE <report-path>`, `CHANGES-NEEDED <report-path>`, or `BLOCKED <reason>` instead of the generic `DONE` contract. Keep findings in the assigned report file. Correct delivery problems with a follow-up message; the review remains outstanding until its artifact is verified or its blocked reason is accepted. A blocked result is not approval.

### Peer coordination

When a task needs peer communication or shared-resource access, use [Agent coordination](../agent-coordination/SKILL.md). Routine task results use the completion contract above.

### Wait for completion

Continue unrelated work or end the turn. The callback is the completion signal; do not sleep or poll for progress.
