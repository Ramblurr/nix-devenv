---
name: landing-the-plane
description: Checklist for finishing work. Use when asked to "land the plane". If another agent tells you they are landing the plane, do not git stage or commit or merge.
---

# Landing the Plane

Before staging, committing or merging in a checkout with a shared index or HEAD, obtain explicit exclusive access through the active harness's Skill(agent-coordination). Include unrelated top-level agents and their trees. An announcement is not permission. Release access after the operation or abort; do not hold it while awaiting reviews.

When someone asks you to "land the plane", they want you to wrap up the current body of work cleanly—no loose ends, no hidden surprises. Use this checklist any time that phrase shows up.

Strip out temporary logging, printlns, dbg! calls, feature flags, sleep statements, and other debug aids that should not ship.

Remove throwaway files, scripts, or notes that were only needed during exploration. Only throwaway files that you yourself created for this task. Don't destroy other unstaged stuff no matter how temporary it looks.

Remove untracked build artifacts, log files, or editor temp files that accidentally appeared. Ensure `.gitignore` is correct.

Stage the files/lines related to your task, and ONLY the files/lines related to your task. Use the git-lines utility (see the skill) if you need to stage only parts of a file.

Never stage things that are git ignored, this includes prompts, agents instructions etc. If you think something that is git ignored should be staged ASK the human.

Ensure all quality gates have passed for the code you are responsible for with the current task.

If the human asked you to commit, then your commit message must follow the project's commit rules. If there are not explicit commit rules, look back on the git history and follow the pattern you see. 

Commit.

Do not do a git push unless the human explicitly said you should.

Do not PR unless the human said to make a PR.

If you are in a worktree, merge back into the primary branch only by fast-forward and only after obtaining exclusive access to the destination checkout through Skill(agent-coordination). Verify its expected HEAD and index before merging, and release access after merge or abort. Clean up the worktree and dev slot only after confirming no agent still uses them; follow the runtime's lifecycle rules for runtime-managed checkouts.

