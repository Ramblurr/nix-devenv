# Migrate local Markdown scratch to Org mode

Use this procedure only after the user approves migration from `.scratch/` to `.scratch-org/`. The coordinator copies, delegates, and validates; it never converts the documents itself.

## Preconditions

1. Read and follow Skill(sub-agents) and Skill(tmux).
2. Confirm the repository root and show the exact source and destination paths.
3. Require `.scratch/` to exist and `.scratch-org/` to be absent. If the destination exists, stop and ask; never merge, replace, or delete it.
4. Confirm `git ls-files -- .scratch .scratch-org` returns nothing. Stop if either tree contains tracked files.
5. Ensure the root `.gitignore` has exact `.scratch/` and `.scratch-org/` entries, then run `git check-ignore -- .scratch/probe .scratch-org/probe`; do not rely only on global excludes.
6. Count source files, Markdown files, non-Markdown files, and symlinks. Record a content digest keyed by relative path plus symlink targets; a path-only digest is insufficient.
7. Treat `.scratch/` as read-only throughout the operation.

## Snapshot

From the repository root, copy the tree while preserving metadata:

```sh
cp -a -- .scratch .scratch-org
```

Immediately verify `diff -qr -- .scratch .scratch-org` succeeds. The destination is now a point-in-time snapshot; later source changes do not authorize an implicit resync.

## Delegate the conversion

Reuse the project's existing tmux session, or create its single project session according to Skill(tmux). Open one conversion window whose working directory is the absolute `.scratch-org/` path. If the user explicitly requests parallel conversion, give agents disjoint explicit write lists plus the complete source-to-destination mapping so they can rewrite cross-partition references. Start each window with this exact command:

```sh
pi --no-session --provider openai-codex --model gpt-5.6-luna --thinking high --fast
```

Do not add another model or thinking flag. Send the agent a prompt containing the absolute destination path, source counts, complete source-to-destination mapping, and these requirements:

```text
Task: Convert this copied local issue-tracker tree from Markdown to Org mode.

Scope and safety:
- Your current working directory is the repository's .scratch-org directory.
- Modify only files and directories beneath the current working directory; for a partitioned conversion, modify only the explicit write list.
- Never edit, delete, rename, or write to ../.scratch or elsewhere in the repository.
- Do not run Git commands or change repository configuration.
- Preserve all information and the directory structure.
- Never follow or dereference symlinks. Preserve non-Markdown symlinks unchanged; if a Markdown-path symlink exists, report BLOCKED rather than replacing or following it.

Required result:
- Convert every .md file recursively to a corresponding .org file at the same relative path and basename.
- Delete a copied .md file only after its .org replacement is written successfully.
- Preserve non-Markdown files unchanged.
- Leave no Markdown files, helper scripts, temporary files, reports, or logs in .scratch-org.

Org conversion:
- Produce idiomatic Org headings, lists, checkboxes, links, emphasis, tables, quotes, and source blocks. Do not merely rename files.
- Preserve prose and metadata without inventing decisions.
- Using the complete mapping, rewrite formal links and inline paths to copied Markdown files; `.scratch/X.md` becomes `.scratch-org/X.org`, while unrelated `.md` references remain unchanged.
- For a plain or bold Markdown Status field in the header, move the state onto the first top-level Org heading and remove the redundant field. Map the canonical roles and workflow states to their uppercase TODO keywords, including `deferred` to `DEFERRED`; additionally map legacy `open` to `NEEDS-TRIAGE` and `active` to `IN-PROGRESS`. A ticket with a missing or unknown legacy state becomes `NEEDS-TRIAGE`.
- For every path NNN-work-item/issues/NN-ticket.org, add or update the first heading's property drawer with TICKET_ID set to NNN-NN. BLOCKED_BY contains only space-separated canonical IDs: bare NN uses the current work item, `work item NNN ticket NN` uses the named item, and `None` becomes empty. Keep descriptive or ambiguous blocker prose outside the drawer.
- Recognize plain and bold Type, Blocked by, Assignee, and Claimant header fields. Preserve Type as TYPE and an existing claimant as ASSIGNEE.
- Convert valid Scheduled and Deadline fields or drawer properties to native Org `SCHEDULED` and `DEADLINE` planning lines directly below the first heading. A `DEFERRED` ticket requires `SCHEDULED` and an empty `ASSIGNEE`; a `CLAIMED` ticket requires a non-empty `ASSIGNEE`. Report `BLOCKED` on contradictory legacy metadata rather than guessing or discarding it.
- Preserve What to build, acceptance criteria, Resolution, Answer, Comments, specs, maps, reviews, handoffs, and operation ledgers.

Validation:
- Confirm the working directory is still .scratch-org.
- Confirm no .md files remain.
- Confirm every original Markdown relative path has one .org replacement and no extra files were created.
- Confirm every ticket's first heading has a canonical TODO state and property drawer, planning dates use native Org syntax, deferred tickets have schedules and no assignee, claimed tickets have assignees, and no mapped legacy Status field remains in any converted document.
- Confirm no Markdown fence lines remain and every reference to a converted tracker file resolves under `.scratch-org/`.
- Inspect representative ticket, spec, map, review, handoff, and operation-ledger files.
- Parse every .org file with Org when Emacs is available.
- Finish with a concise DONE or BLOCKED report in the tmux terminal.
```

The coordinator monitors the tmux pane and waits for the terminal's final `DONE` or `BLOCKED` result. The conversion task is complete only after the child agent exits or returns to an idle prompt.

## Independent validation

After `DONE`, validate without modifying either tree:

- `.scratch/` still exists and its pre-copy snapshot files were not changed by the migration.
- `.scratch-org/` contains zero `*.md` files.
- Every snapshotted Markdown path maps to one `.org` path.
- Every snapshotted non-Markdown path, including each symlink itself, remains present and unchanged.
- No files exist outside the expected mapping.
- Every Org file parses successfully when Emacs is available.
- Org recognizes every ticket under the canonical TODO sequence; property drawers contain only canonical metadata; planning dates use native syntax; deferred tickets have schedules and no assignee; claimed tickets have assignees; no Markdown fence lines remain; converted tracker references resolve under `.scratch-org/`; checkboxes and representative source blocks are correct.
- `git check-ignore` recognizes both trees, and `git ls-files -- .scratch .scratch-org` plus `git diff --cached -- .scratch .scratch-org` show no tracked or staged tracker files.

If `.scratch/` changed concurrently after the snapshot, report the changed paths and keep `.scratch-org/` as the validated snapshot. Never chase a moving source tree automatically.

Do not stage or commit `.scratch-org/`. Do not delete `.scratch/`; report that the old tree remains for the user to remove after accepting the migration.
