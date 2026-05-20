---
name: finishing-a-development-branch
description: Use this when you have completed some feature implementation and have written passing tests, and you are ready to create a PR.
---

<required>
**CRITICAL: Follow these steps in order:**

1. Run the project's local qa/test suite

```bash
# Run project's qa suite
bb qa / bb test / npm test / cargo test / pytest / go test ./...
```

**If tests fail:**

```
Tests failing (<N> failures). Must fix before creating PR:

[Show failures]

Cannot proceed until tests pass.
```

2. Confirm that there is some formatting/lint/typechecking in the project. If NONE of these exist, ask me if there was something that you missed.

3. Run any formatters and fix issues in a subagent.

6. Use the Skill(code-reviewer) to do a self review. You do *NOT* have to follow the subagent's suggestions. This is merely a way to get a fresh pair of eyes on the code.

7. Confirm that you are not on the main branch. If you are, ask me before proceeding. NEVER push to main without permission.

8. Use `git add` to stage the changes to files you edited for this feature. Follow

    Commit message rules:
    - Never mention beads, bd issues in the commit message
    - Never use **bold** formatting
    - Never use emoji in the commit message
    - Never mention Claude/AI/LLMS/Coding Agents in the commit message
    - Do not list or mention files in the commit message (that is redundant, the commit itself has a list of files)
    - Do not include other redundant or obvious information
    - Use `git log -n 10` to look at past 10 commits, follow a similar commit message style (number of lines, casing etc)

8. [OPTIONAL] Push and create a PR. 

Only push and create a PR if the human operator told you to, otherwise stop with the commit.

```bash
# Push branch
git push -u origin <feature-branch>

# Create PR
gh pr create --title "<title>" --body "$(cat <<'EOF'
## Summary

<2-3 bullets of what changed>

## Test Plan
- [ ] <verification steps>
EOF
)"
```

9. Make sure the PR branch CI succeeds. Skip if there are no checks/ci.

```bash
# Check if the PR CI succeeded
gh pr checks

# If it is still running, sleep and check again
sleep 60 && gh pr checks
```

If CI did not pass, examine why.
If the CI did not start, this is likely due to merge conflicts; merge main, fix conflicts, and try again.
<system-reminder>Do not move forward without a ci status unless you have checked for merge conflicts</system-reminder>

- Make changes as needed, push a new commit, and repeat the process.
<system-reminder> It is *critical* that you fix any ci issues, EVEN IF YOU DID NOT CAUSE THEM. </system-reminder>

9. Tell me: "I can automatically get review comments, just let me know when to do so."
</required>


