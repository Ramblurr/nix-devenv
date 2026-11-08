# Migrate domain glossaries

Use this reference only when the user approves migrating existing domain documentation to `GLOSSARY.md` / `GLOSSARY-MAP.md`. Approval may cover one project or a named set of projects. This is a rename and reference update, not a rewrite of the domain model.

1. **Inspect.** Read project instructions, the configured domain-doc paths, both old and new filenames, and Git status. Follow maps into nested contexts. Confirm each legacy file is actually a domain glossary or context map; preserve unrelated context documents and existing user edits.
2. **Plan.** List each source, destination, and active consumer to update. Include map links, `AGENTS.md` / `CLAUDE.md` pointers, `docs/agents/domain.md`, and other live references. Keep historical records and external references unchanged. If both names exist, or a symlink leads outside the approved scope, ask before changing that case; continue independent cases.
3. **Move.** For a clean tracked source, use `git mv`; move untracked files without adding them to Git. Avoid disturbing pre-existing staged work; use a filesystem rename when staging would include unrelated edits. Preserve content and file modes. Never overwrite a destination or merge competing documents silently.
4. **Update consumers.** Change only references to the migrated documents. Preserve surrounding project customisations and the existing layout. Migrate nested glossaries and their map links together. Keep legacy discovery for projects that have not migrated; don't leave two competing canonical glossaries.
5. **Validate.** Check every destination, active pointer, and map link. Review the focused diff and explain any remaining legacy reference. A second inventory should find the project already migrated, without new files or duplicate configuration. Do not report success if a move or consumer update is incomplete.

Exercise the policy against these cases before publishing changes to it:

- Legacy-only: preserve content, move each glossary, and update its consumers.
- New-only: leave the project unchanged.
- Mixed names or destination collisions: retain both and request a decision.
- Multiple contexts: follow the map, preserve layout, and update nested links.
- Declined migration: keep reading and writing the configured legacy files.
- Repeated run: no further edits.

Report migrated, already-current, not-applicable, and blocked projects separately. Keep ambiguous cases open instead of treating a partial migration as complete. Commit, push, and runtime reload are separate actions, not part of this migration.
