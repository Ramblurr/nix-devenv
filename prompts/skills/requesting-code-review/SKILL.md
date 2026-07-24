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

2. Dispatch code-reviewer subagent:

Invoke the skills:
Skill(tmux)
Skill(sub-agents)

Fill the template at `./code-reviewer.md` (copy it, dont edit it in the skill dir!)
Aim the checks at THIS task's real risks.

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


Remember: New files don't diff — untracked files are invisible to git diff; always route the reviewer at the file itself, or the review silently covers only the modified files.

3. Act on feedback:
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

If reviewer is wrong:
- Push back with technical reasoning
- Show code/tests that prove it works
- Request clarification
