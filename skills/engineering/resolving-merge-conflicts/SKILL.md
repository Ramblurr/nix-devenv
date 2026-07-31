---
name: resolving-merge-conflicts
description: Resolves an in-progress Git merge or rebase conflict while preserving both changes' intent. Use when Git reports conflicted files during a merge or rebase.
---

1. **See the current state** of the merge/rebase. Check git history, and the conflicting files.

2. **Find the primary sources** for each conflict. Understand deeply why each change was made and what the original intent was. Read commit messages and the originating PRs or issues. Use `docs/agents/issue-tracker.md` when present; otherwise inspect referenced local Org mode issue files directly. Do not bootstrap or reconfigure the tracker during conflict resolution.

3. **Resolve each hunk.** Preserve both intents where possible. Where incompatible, pick the one matching the merge's stated goal and note the trade-off. Do **not** invent new behaviour. Always resolve; never `--abort`.

4. Discover the project's **automated checks** and run them — typically typecheck, then tests, then format. Fix anything the merge broke.

5. **Finish the merge/rebase.** Stage the resolved files. For a merge, create the merge commit and use Skill(scoped-commits) for its message. For a rebase, continue the rebase until every commit has been applied.
