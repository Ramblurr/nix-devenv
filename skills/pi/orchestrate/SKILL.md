---
name: orchestrate
description: Orchestrates dev pods through sequential ticket queues over Pi Link. Use when implementation must finish validation, two-agent review, commits, and ticket closure before the next assignment.
---

# Orchestrate Agents

## Roles

The **Orchestrator** owns the ticket queue, agent setup, and cross-pod coordination. Each **Dev** owns one ticket through implementation, validation, review, commits, and closure. Each dev has two dedicated **Reviewers**.

A dev and its reviewers form a pod and may communicate directly with each other. Communication between pods goes through the orchestrator.

## Workflow

1. **Prepare.** Read and follow Skill(pi-link-coordination), Skill(sub-agents), and Skill(tmux). Use `link_list` to confirm your exact Link name and find agents in the project scope.

   Derive the project name from the repository directory. From the project checkout, use `tmuxb list` to find the project's single tmux session, conventionally named after the project. Reuse it when it exists; otherwise create it with that project name. Inspect its windows and panes before adding anything. Identify sub-agents, REPLs, watchers, servers, and other development tools already running for the target repository and worktree by checking their names, working directories, and processes. Unless the user says otherwise, create every missing agent window and required REPL or development-tool window before orchestration starts. Reuse matching windows and processes; never duplicate them or create a tmux session per agent, pod, or worktree.

2. **Create the recovery ledger.** Before provisioning or dispatching agents, create `orchestration.org` in the work-item directory. Keep it current after every state transition, including setup, dispatch, callbacks, blockers, review results, commit-lock events, accepted completions, and queue advancement. Record at least:

   - the orchestrator and pod Link names;
   - repository, branch, worktree, work-item, ticket, tmux session/window, and REPL or development-tool details;
   - the queue and each ticket's state, commits, validation, and review artifacts;
   - the current commit-lock holder and expected HEAD;
   - every outstanding async callback and the next safe action; and
   - recovery instructions that prevent polling or duplicate dispatch after a crash or compaction.

   Treat the ledger as local tracker state. Never stage or commit it when the work-item directory is untracked.

3. **Provision pods.** In the project tmux session, create or identify the subagents (dev, reviewers etc).

  The default pod configuration is: one dev, one standards reviewer, and one spec reviewer. The user can override the pod composition, do what they say. The rest of this skill is written assuming the default composition, and you should adapt it to your situation.

  Give them unique, project-scoped Link names that show pod membership. Tell all three agents the orchestrator's name and each other's names. Keep each reviewer pair exclusive to its dev.

  Unless the user overrides a role's provider, model, or thinking level, use the following defaults.

   | Role               | Provider       | Model           | Thinking |
   |--------------------|----------------|-----------------|----------|
   | Dev                | `openai-codex` | `gpt-5.6-terra` | `high`   |
   | Standards reviewer | `openai`       | `gpt-5.6-luna`  | `xhigh`  |
   | Spec reviewer      | `openai`       | `gpt-5.6-sol`   | `medium` |

   Pass all three settings explicitly when starting each agent, for example `pi --provider openai-codex --model gpt-5.6-terra --thinking high`. Reuse an existing agent for a new orchestration only when its role and effective provider, model, and thinking level match the requested or default configuration.

4. **Check Git sharing.** Determine whether pods share a branch, worktree, index, or HEAD. Shared worktrees use the commit lock in step 7; isolated worktrees do not.

5. **Dispatch one ticket per idle dev.** Use `link_send(triggerTurn: true)` and tell the dev to invoke Skill(implement). Include:

   - the ticket ID and path;
   - both reviewer Link names;
   - permission for pod members to communicate directly;
   - the rule that cross-pod coordination goes through the orchestrator;
   - the shared commit-lock protocol when applicable; and
   - [ ] the golden rule: they must read the link coordination skill , and when communicating with member's of their pod they must use `link_send(triggerTurn: true)` and they must not run bash sleep commands while waiting. they can simply end their turn, that's the beauty of triggerTurn.
   - this callback contract: reply to the orchestrator's exact Link name with `link_send(triggerTurn: true)` using `DONE <ticket>` or `BLOCKED <ticket>`. Include the deliverable path, commits, validation, both review results, and ticket status.

6. **Let the pod work.** The dev implements and validates, then dispatches both reviews with `link_send(triggerTurn: true)`. Each reviewer replies to the dev with `link_send(triggerTurn: true)` using `DONE <ticket>` or `BLOCKED <ticket>` and its review result. Pod members may discuss findings directly. The dev owns every fix/re-review loop and finishes only after both reviewers approve.

   Preserve every pod member's context while the ticket is active. Do not routinely poll, interrupt, compact, or use `link_prompt` after an async dispatch and before its `DONE` or `BLOCKED` callback.

   **Status-request liveness check.** Whenever the user asks for a status or update, inspect the project tmux session before answering. Use `tmuxb windows`, `tmuxb panes`, and `tmuxb capture` to check every active pod member and required REPL or development-tool pane. Reconcile pane output with the ledger and Link callbacks; do not merely repeat the last recorded state. Treat missing callbacks, exited windows, idle prompts after errors, policy/tool failures, and agents waiting on already-delivered messages as stalls. Send the affected agent exact recovery instructions with `link_send(triggerTurn: true)`, update the ledger, and report the observed state and intervention. This explicit user-requested liveness check is the exception to the no-polling rule.

7. **Mediate boundaries.** Handle only events that leave the pod:

   - On `COORDINATION BLOCKED <ticket> <details>`, resolve the cross-pod dependency and send exact next instructions.
   - On `BLOCKED <ticket>`, help resolve the blocker without advancing the queue.
   - For a shared worktree, serialize index and HEAD changes:
     1. The dev sends `COMMIT-LOCK REQUEST <ticket> <expected-head>` and pauses before staging or committing.
     2. After checking HEAD and the index, grant one dev `COMMIT-LOCK ACQUIRED <ticket> <head>`. Other pods may make disjoint edits and perform read-only work, but must not change the index, HEAD, or history.
     3. The holder stages only owned paths, makes a regular commit, confirms a clean index, and sends `COMMIT-LOCK RELEASED <ticket> <new-head>`.
     4. Verify HEAD, committed paths, and the clean index before granting the next request. Devs never transfer the lock directly.

   These messages and other progress reports are intermediate events, not completion.

8. **Accept completion.** On `DONE <ticket>`, verify the deliverable, validation, commits, approval from both reviewers, ticket closure, and that no fix or review remains.

9. **Advance the queue.** Find the next ready ticket. At the ticket boundary, compact idle pod members before switching tasks; reuse or replace reviewers only here. Dispatch exactly one next ticket to the dev with `link_send(triggerTurn: true)` and the same contract. If no ticket remains, report completion.

10. **Repeat** until the queue is complete.
