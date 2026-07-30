---
name: orchestrate
description: Orchestrates agents through sequential ticket queues over Pi Link. Use when implementation must finish validation, review, commits, and ticket closure before the next assignment.
---

# Orchestrate Agents

The **orchestrator** owns coordination and the ticket queue. A **leader** owns one ticket through implementation, validation, review, commits, and closure, regardless of its Link name (`leader`, `dev`, `dev1`, etc.).

Read and follow Skill(pi-link-coordination). Use `link_list` to confirm exact Link names.

## Coordination

Use a hub-and-spoke topology:

- Leaders and reviewers communicate only with the orchestrator, never directly with each other.
- The orchestrator mediates shared-worktree state, commits, blockers, and reviews.
- Reserve a reviewer pool per leader. A leader sends `REVIEW REQUEST <ticket> <base> <head> <scope>`; the orchestrator dispatches reviewers and returns results.
- Put this routing rule in every dispatch. For cross-ticket coordination, a leader sends `COORDINATION BLOCKED <ticket> <details>` and pauses.

## Shared commit lock

Leaders sharing a branch and worktree must serialize index and HEAD changes through the orchestrator:

1. The leader sends `COMMIT-LOCK REQUEST <ticket> <expected-head>` before staging or committing, then pauses.
2. After checking HEAD and the index, the orchestrator sends `COMMIT-LOCK ACQUIRED <ticket> <head>` to one leader. Others may make disjoint edits and perform read-only work, but must not change the index, HEAD, or history.
3. The holder stages only owned paths, makes a regular commit, confirms a clean index, and sends `COMMIT-LOCK RELEASED <ticket> <new-head>`.
4. The orchestrator verifies HEAD, committed paths, and the clean index before granting the next request. Leaders never transfer the lock.

Isolated worktrees need no shared commit lock, but still use hub-and-spoke coordination.

## Workflow

1. Dispatch one ticket and require Skill(implement). Include its ID and path, reviewer reservation, applicable commit-lock rules, and hub-and-spoke routing.
2. Require callbacks to your exact Link name via `link_send(triggerTurn: true)`. Final callbacks are `DONE <ticket>` or `BLOCKED <ticket>` and include the deliverable path, commits, validation, and review result.
3. Wait without polling, interrupting, compacting, or using `link_prompt`. Preserve the leader's context through every review/fix/re-review loop.
4. Mediate `COORDINATION BLOCKED`, `COMMIT-LOCK REQUEST`, and `REVIEW REQUEST`; these and other progress reports are not completion.
5. Resolve `BLOCKED` without advancing. On `DONE`, verify ticket closure and that no review or fix remains.
6. Find the next ready ticket. If one exists, compact the idle leader at this task boundary, then dispatch exactly one ticket with `link_send(triggerTurn: true)` and the same contract. Otherwise, report completion.
7. Repeat until the queue is complete.
