---
name: requesting-code-review
description: Dispatch code-review subagents through Pi Link. Use when Skill(code-review) needs independent reviewers to write on-disk reports.
---

# Requesting Code Review

This skill owns reviewer transport. The calling review skill owns policy, review content, templates, report-path allocation, and findings.

Before step 1, read Skill(pi-link-coordination) completely. It is the single source of truth for Link tool choice, terminal state, context management, async callbacks, and the Golden Rule.

## 1. Acquire reviewers

Run `link_list` and assign a different idle terminal to each independent review. Confirm each target can access the repository and its report path. Every brief uses absolute paths.

When there are too few suitable terminals, use Skill(sub-agents) to start them, wait for them to connect, then run `link_list` again.

Run `link_compact` on every selected reviewer after it becomes idle and before each new review, regardless of reported context usage. Wait for each compaction to complete before dispatch. If compaction declines or times out, use `link_list` to confirm the target's state and repeat preflight until compaction succeeds.

**Complete when:** every review has one distinct, idle target with repository access and a completed pre-dispatch compaction.

## 2. Assemble each brief

Embed the review content supplied by the calling skill unchanged in a self-contained brief containing:

- The complete review assignment and inputs
- The absolute repository path
- The absolute input and template paths named by the calling skill
- The assigned absolute report path
- An instruction to send exactly one callback to the requester's exact Link name with `link_send(triggerTurn:true)`: `APPROVE <report-path>`, `CHANGES-NEEDED <report-path>`, or `BLOCKED <reason>`

The report file carries every finding. The reviewer writes it before sending a verdict callback; `BLOCKED` carries only its reason.

**Complete when:** every brief contains all five items, has a distinct report path, and requires no prior conversation.

## 3. Dispatch asynchronously

Send one brief per target with `link_send(triggerTurn:true)`. Send all independent reviews before yielding. Track each target, report path, and outstanding callback.

A failed send returns that review to step 1. After a successful send, apply the Golden Rule from Skill(pi-link-coordination).

**Complete when:** every review has a successful send and is tracked as outstanding.

## 4. Await every callback

End the turn after dispatch. Resume as callbacks arrive, which may be separate or batched; keep unfinished targets outstanding and end the turn again. A callback outside the contract triggers a corrective `link_send(triggerTurn:true)` and remains outstanding.

**Complete when:** every target has returned one of the three allowed callbacks.

## 5. Apply the artifact gate

For `APPROVE` and `CHANGES-NEEDED`, match the callback path to the assigned path and verify the report exists on disk. For `BLOCKED`, capture the reason for the calling skill.

A wrong path, missing report, or inline-only review triggers a corrective `link_send(triggerTurn:true)` to that reviewer and a return to step 4. Return verified artifact paths and blocked reasons to the calling skill.

**Complete when:** every non-blocked review has its assigned on-disk report and every blocked review has a reason.
