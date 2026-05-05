---
name: landing-the-plane
description: Checklist for finishing work, pushing a branch, and opening a ready-for-review PR with tests and tracker updates. Use when asked to "land the plane". If another agent tells you they are landing the plane, do not git stage or commit or merge.
---

# Landing the Plane

If tools/mechanisms for collaborating with agents are available, then broadcast that you are landing the plane, tell the agents they should not touch the git staging area, branch until you give the all clear. They can continue writing code of course.

When someone asks you to "land the plane", they want you to wrap up the current body of work cleanly—no loose ends, no hidden surprises. Use this checklist any time that phrase shows up.

Strip out temporary logging, printlns, dbg! calls, feature flags, sleep statements, and other debug aids that should not ship.

Remove throwaway files, scripts, or notes that were only needed during exploration. Only throwaway files that you yourself created for this task. Don't destroy other unstaged stuff no matter how temporary it looks.

Remove untracked build artifacts, log files, or editor temp files that accidentally appeared. Ensure `.gitignore` is correct.

Stage the files/lines related to your task, and ONLY the files/lines related to your task. Use the git-lines utility (see the skill) if you need to stage only parts of a file.

Never stage things that are git ignored, this includes prompts, agents instructions etc. If you think something that is git ignored should be staged ASK the human.

Ensure all quality gates have passed for the code you are responsible for with the current task.

If the human asked you to commit, then draft a commit following the project's commit rules. If there are not explicit commit rules, look back on the git history and follow the pattern you see. 

Common commit message patterns (not all may apply!)

- no emoji
- one line lower case
- common prefixes

Commit.

Do not do a git push unless the human explicitly said you should.

If you are in a worktree, then you are clear to merge (ff!) back into the primary branch (be that main or dev depending on the project) and close out the worktree.

Do not PR unless the human said to make a PR.
