---
name: requesting-code-review
description: Use when completing tasks, implementing major features, or before merging to verify work meets requirements 
---

# Requesting Code Review

Dispatch an agent to catch issues before they cascade.

## When to Request Review

Mandatory:
- After completing major feature/task
- Before merge to main

Optional but valuable:
- When stuck (fresh perspective)
- Before refactoring (baseline check)
- After fixing complex bug

## How to Request

1. Have you committed? 

Yes? -> Get git SHAs:
```bash
BASE_SHA=$(git rev-parse HEAD~1)  # or origin/main
HEAD_SHA=$(git rev-parse HEAD)
```

No? -> 
Or if you haven't committed yet, reference the staged or dirty working tree files.

2. Pre flight

Invoke the skills:
Skill(tmux)
Skill(sub-agents)

Start your subagent, or re-use an existing one if they are not busy.

Compact (`link_compact`) any reviewer whose window may not fit the
coming task — judge the fit BEFORE dispatching, not once the window is already
full. The hazard is Pi's auto-compaction firing MID-TASK, which can shed the
dispatch brief's details at the worst moment; orchestrated compaction while the
worker is idle (`link_compact` blocks, then returns) exists to pre-empt exactly
that.  Compact right before a large or sensitive task so it runs in a clean
window.  Compaction is a TASK-BOUNDARY operation: never compact a worker between
its IMPLEMENT and that task's commit — a CONVERGE relay or gate-red retry needs
the very in-flight state compaction sheds; if the window truly can't fit the
fix, escalate to the user instead. Because dispatches are self-contained (§3.2),
the next brief re-supplies everything task-specific; the only irrecoverable loss
is what the worker learned that is NOT in the plan — aim the compaction
instructions at exactly that.


3. Dispatch code-reviewer subagent:

Read `./code-reviewer.md` completely before dispatching.

For a general code review, use its checklist and report format.
For a specialized review, such as `over-engineering-review`, the specialized
skill controls the review content and report format, but the delivery contract
from `code-reviewer.md` remains mandatory.

Choose an explicit report path under `prompts/` and include it in the dispatch.
The reviewer must write the complete review there before sending its callback.

A read-only review prohibits changes to implementation files, generated files,
the Git index, and commits.
Writing the designated review report is the required exception.

For linked reviewers, the callback is only:

`APPROVE <report-path>`

`CHANGES-NEEDED <report-path>`

or:

`BLOCKED <reason>`

Never ask the reviewer to return the complete review in the callback.
If the reviewer cannot write the report, it must return `BLOCKED` rather than
substitute an inline review.

Copy `./code-reviewer.md`; do not edit the template in the skill directory.
Aim the checks at this task's real risks.

Placeholders:
- `{WHAT_WAS_IMPLEMENTED}` - What you just built
- `{PLAN_OR_REQUIREMENTS}` - What it should do
- `{PLAN_REFERENCE}` - path to plan file
- `{BASE_SHA}` - Starting commit
- `{HEAD_SHA}` - Ending commit
- `{DESCRIPTION}` - Brief summary
- `{REPO_PATH}` - git root dir
- `{DIFF}` - git -C <git root> diff -- <relative file path>
- `{NEW_FILES}` - list of new files one per line
- `{REPORT_PATH}` - required on-disk destination for the complete review report


Remember: New files don't diff — untracked files are invisible to git diff; always route the reviewer at the file itself, or the review silently covers only the modified files.

Your dispatch must be self-contained and sent via `link_send(triggerTurn:true)`.

Do not use `link_prompt` (90s inactivity) would block you and risk timeout.

After triggering a worker, **WAIT** for its callback before any follow-up to it (Golden Rule). (WAIT = end your turn, do not use sleep to pass time)


4. Act on feedback:

- Before acting, verify that the callback includes a report path and that the
  self-contained report exists on disk.
  A callback never substitutes for the report.
  If the report is absent, send the reviewer back to complete the deliverable.

- Fix Critical issues immediately
- Fix Important issues before proceeding
- Note Minor issues for later
- Push back if reviewer is wrong (with reasoning)

## Red Flags

Never:
- Skip review because "it's simple"
- Ignore Critical issues
- Proceed with unfixed Important issues
- Argue with valid technical feedback
- Say “do not modify files” without explicitly permitting the required report
- Accept review findings embedded only in a link callback
- Act on feedback before verifying that the report artifact exists

If reviewer is wrong:
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification
