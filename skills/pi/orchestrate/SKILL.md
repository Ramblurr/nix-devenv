---
name: orchestrate
description: Orchestrates dev pods through sequential ticket queues over Pi Link. Use when implementation must finish validation, two-agent review, commits, and ticket closure before the next assignment.
---

# Orchestrate Agents

## Roles

The **Orchestrator** owns the ticket queue, agent setup, and cross-pod coordination. Each **Dev** rwns one ticket through implementation, validation, review, commits, and closure. Each dev has two dedicated **Reviewers**.

A dev and its reviewers form a pod and may communicate directly with each other. Communication between pods goes through the orchestrator.

## Workflow

1. **Prepare.** Read and follow Skill(pi-link-coordination), Skill(sub-agents), and Skill(tmux). Use `link_list` to confirm your exact Link name and find agents in the project scope. Find or create the project's single tmux session; never create a session per agent.

2. **Provision pods.** In the project tmux session, create or identify one dev and exactly two reviewers per pod. Give them unique, project-scoped Link names that show pod membership. Tell all three agents the orchestrator's name and each other's names. Keep each reviewer pair exclusive to its dev.

3. **Check Git sharing.** Determine whether pods share a branch, worktree, index, or HEAD. Shared worktrees use the commit lock in step 6; isolated worktrees do not.

4. **Dispatch one ticket per idle dev.** Use `link_send(triggerTurn: true)` and tell the dev to invoke Skill(implement). Include:

   - the ticket ID and path;
   - both reviewer Link names;
   - permission for pod members to communicate directly;
   - the rule that cross-pod coordination goes through the orchestrator;
   - the shared commit-lock protocol when applicable; and
   - this callback contract: reply to the orchestrator's exact Link name with `link_send(triggerTurn: true)` using `DONE <ticket>` or `BLOCKED <ticket>`. Include the deliverable path, commits, validation, both review results, and ticket status.

5. **Let the pod work.** The dev implements and validates, then dispatches both reviews with `link_send(triggerTurn: true)`. Each reviewer replies to the dev with `link_send(triggerTurn: true)` using `DONE <ticket>` or `BLOCKED <ticket>` and its review result. Pod members may discuss findings directly. The dev owns every fix/re-review loop and finishes only after both reviewers approve.

   Preserve every pod member's context while the ticket is active. Do not poll, interrupt, compact, or use `link_prompt` after an async dispatch and before its `DONE` or `BLOCKED` callback.

6. **Mediate boundaries.** Handle only events that leave the pod:

   - On `COORDINATION BLOCKED <ticket> <details>`, resolve the cross-pod dependency and send exact next instructions.
   - On `BLOCKED <ticket>`, help resolve the blocker without advancing the queue.
   - For a shared worktree, serialize index and HEAD changes:
     1. The dev sends `COMMIT-LOCK REQUEST <ticket> <expected-head>` and pauses before staging or committing.
     2. After checking HEAD and the index, grant one dev `COMMIT-LOCK ACQUIRED <ticket> <head>`. Other pods may make disjoint edits and perform read-only work, but must not change the index, HEAD, or history.
     3. The holder stages only owned paths, makes a regular commit, confirms a clean index, and sends `COMMIT-LOCK RELEASED <ticket> <new-head>`.
     4. Verify HEAD, committed paths, and the clean index before granting the next request. Devs never transfer the lock directly.

   These messages and other progress reports are intermediate events, not completion.

7. **Accept completion.** On `DONE <ticket>`, verify the deliverable, validation, commits, approval from both reviewers, ticket closure, and that no fix or review remains.

8. **Advance the queue.** Find the next ready ticket. At the ticket boundary, compact idle pod members before switching tasks; reuse or replace reviewers only here. Dispatch exactly one next ticket to the dev with `link_send(triggerTurn: true)` and the same contract. If no ticket remains, report completion.

9. **Repeat** until the queue is complete.
