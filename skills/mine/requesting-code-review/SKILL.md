---
name: requesting-code-review
description: Dispatch independent code-review subagents using the active harness. Use when Skill(code-review) needs independent reviewers to write on-disk reports.
---

# Requesting Code Review

This skill owns reviewer briefs and artifact verification. The calling review skill owns review policy, content, templates, report-path allocation, and findings.

Read the active harness's Skill(sub-agents) for agent selection, dispatch, context management, waiting and follow-up mechanics.

## 1. Acquire reviewers

Plan a distinct reviewer context for each independent review using Skill(sub-agents). Confirm each assignment provides access to the reviewed repository state and its report path. Every brief uses absolute paths.

**Complete when:** every review has an independent assignment with accessible inputs and a report path readable by the coordinator.

## 2. Assemble each brief

Embed the review content supplied by the calling skill unchanged in a self-contained brief containing:

- The complete review assignment and inputs
- The absolute repository path
- The absolute input and template paths named by the calling skill
- The assigned absolute report path
- An instruction to return one final result through the harness's completion mechanism: `APPROVE <report-path>`, `CHANGES-NEEDED <report-path>`, or `BLOCKED <reason>`

The report file carries every finding. The reviewer writes it before returning a verdict; `BLOCKED` carries only its reason.

**Complete when:** every brief contains all five items, has a distinct report path, and requires no prior conversation.

## 3. Dispatch asynchronously

Use Skill(sub-agents) to dispatch the independent briefs in parallel. Track each assignment, report path and outstanding result. Resolve failed dispatches through the harness's lifecycle rules before retrying.

**Complete when:** every review has a successful dispatch and is tracked as outstanding.

## 4. Await every result

Follow Skill(sub-agents) to await completion. Keep unfinished assignments outstanding. Correct results outside the contract through the harness's follow-up mechanism.

**Complete when:** every assignment has returned one of the three allowed results.

## 5. Apply the artifact gate

For `APPROVE` and `CHANGES-NEEDED`, match the returned path to the assigned path and verify the report exists on disk. For `BLOCKED`, capture the reason for the calling skill.

A wrong path, missing report, or inline-only review requires a correction through Skill(sub-agents) and a return to step 4. Return verified artifact paths and blocked reasons to the calling skill.

**Complete when:** every non-blocked review has its assigned on-disk report and every blocked review has a reason.
