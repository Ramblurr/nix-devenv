---
name: bootstrap-engineering-workflows
description: Configure or migrate this repo for the engineering workflows — set up its issue tracker, triage labels, and domain docs
disable-model-invocation: true
---

# Bootstrap Engineering Workflows

Scaffold the per-repo configuration that the engineering skills assume:

- **Issue tracker** — local Org mode files under `.scratch-org/NNN-<slug>/`
- **Triage states** — canonical workflow roles mapped to Org TODO keywords
- **Domain docs** — where `GLOSSARY.md` and ADRs live, with legacy `CONTEXT.md` compatibility

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the current repo to understand its starting state. Read whatever exists; don't assume:

- `AGENTS.md` and `CLAUDE.md` at the repo root — does either exist? Is there already an `## Agent skills` section in either?
- `GLOSSARY.md` and `GLOSSARY-MAP.md`, legacy `CONTEXT.md` and `CONTEXT-MAP.md`, and the per-context files their maps reference. Inspect their content: not every `CONTEXT.md` is a domain glossary.
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?
- `.scratch-org/` — sign that the local Org mode tracker is already configured
- `.scratch/` — sign that a legacy local Markdown tracker may need migration; count its files without modifying it
- `prompts/` — does it contain numbered workflow documents that follow the legacy `prompts/NNN-concept...` convention?
- Is Skill(triage) installed? (a `triage` skill folder alongside this one, or Skill(triage) in your available skills.) This decides whether Section B runs at all.
- Monorepo signals — a `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, a populated `packages/*` with its own `src/`, or a `deps.edn` that mentions a monorepo. Also check whether `README.md`, `AGENTS.md`, or `CLAUDE.md` makes clear that this is a Clojure project with multiple subprojects. Present multi-context only for a genuine multi-project repo; otherwise use single-context, which fits almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing. Then take the sections in order, pausing for an answer only when a section asks a question.

Lead each question with the recommended answer so the user can accept it in a word. Give a one-line explainer only when the choice genuinely branches; skip sections that exploration settled: Section B when Skill(triage) isn't installed, Section C's new-layout question when there is no monorepo (always inspect existing domain docs and offer any applicable migration), Section D when there are no legacy prompts, and Section E when there is no legacy `.scratch/` tree.

**Section A — Issue tracker.**

The engineering workflows use local Org mode. Tell the user that issues and specs live under `.scratch-org/NNN-<slug>/`, with `NNN` drawn from one shared repo-wide three-digit sequence. Tickets use canonical composite IDs such as `006-02`; there is no issue-tracker choice to make.

Ensure the repository's root `.gitignore` contains `.scratch-org/` entries. Neither tree may contain tracked files, be staged, or be committed; do not rely only on a user's global excludes. Record the tracker configuration in `docs/agents/issue-tracker.md` using the local Org mode seed template.

**Section B — Triage states.** Skip this section entirely if Skill(triage) is not installed.

Use the fixed local mapping: `needs-triage` → `NEEDS-TRIAGE`, `needs-info` → `NEEDS-INFO`, `ready-for-agent` → `READY-FOR-AGENT`, `ready-for-human` → `READY-FOR-HUMAN`, and `wontfix` → `WONTFIX`. Also document `IN-PROGRESS`, `CLAIMED`, `DEFERRED`, and `RESOLVED`. `DEFERRED` requires native Org `SCHEDULED` syntax and an empty assignee. When its start time arrives, claim it directly as `CLAIMED` and set the required assignee. There is no label-vocabulary question for the local tracker.

**Section C — Domain docs.** Preserve an existing configured layout. For new projects, default to **single-context**: one `GLOSSARY.md` + `docs/adr/` at the repo root; create the glossary lazily when a term is resolved.

For a new multi-context layout, offer a root `GLOSSARY-MAP.md` pointing to per-context `GLOSSARY.md` files only when exploration found monorepo signals. Confirm the layout with the user.

If legacy domain files exist, offer the opt-in migration in [migrate-domain-glossary.md](./migrate-domain-glossary.md). Include root and nested files and their active consumers in the draft. If the user declines, keep the configured legacy paths and consumer rules; don't create a competing glossary. Existing approval for a specified set of projects is sufficient; ask again only about ambiguous files or collisions.

**Section D — Legacy `prompts/` documents.** Skip this section entirely if exploration found no numbered workflow documents matching the legacy convention.

If matching documents exist, show the proposed migration and ask for approval. The destination is Org mode:

- Obvious OCP (Skill(operational-change-protocol)) ledgers → `.scratch-org/ocp/YYYYMMDDTHHMMSSZ-<slug>.org`
  - Preserve numbering gaps produced by moving OCP ledgers out of the `NNN` sequence.
- `prompts/NNN-<concept>.md` → `.scratch-org/NNN-<concept>/spec.org`
- `prompts/NNN-<concept>_<suffix>.md` → `.scratch-org/NNN-<concept>/<suffix>.org`

Treat a document as an obvious OCP ledger only when its filename names OCP or operational change, or its contents clearly identify it as an OCP ledger. Reuse an unambiguous timestamp and slug; stop on ambiguity.

Retain each source group's `NNN`, group matching prefixes, and stop on collisions. Preserve the Markdown sources until a delegated conversion validates every Org destination. Place approved copies beneath `.scratch-org/` with their destination basename and a temporary `.md` suffix, then invoke the converter described in [migrate-local-markdown-to-org.md](./migrate-local-markdown-to-org.md) from the `.scratch-org/` root. Its scratch-tree snapshot preconditions do not apply to prompt-only conversion; its exact Pi command, safety boundary, conversion rules, and independent validation do. The coordinator must not rewrite the documents itself.

**Section E — Existing Markdown scratch tracker.** Skip when `.scratch/` does not exist.

When `.scratch/` exists and `.scratch-org/` does not, recommend migration and ask exactly:

 > Migrate the existing Markdown scratch tracker to Org mode? (recommended: **yes**)

On approval, follow [migrate-local-markdown-to-org.md](./migrate-local-markdown-to-org.md). The coordinator copies `.scratch/`, starts the specified Pi agent in tmux with `.scratch-org/` as its working directory, and independently validates the result. The coordinator never performs the Markdown-to-Org rewrite itself.

When both directories exist, report that state and ask whether `.scratch-org/` is an accepted prior migration. Never merge, replace, delete, or resync either tree automatically.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, and `docs/agents/triage-states.md` (the last only when Skill(triage) is installed)
- The source/destination paths and reference updates for an approved glossary migration; retain the old configuration until it validates
- The exact source and destination paths for the prompts migration (only when Section D ran)
- The `.scratch/` snapshot counts, `.scratch-org/` destination, exact subagent command, and validation plan (only when Section E ran)

Let them edit before writing.

### 4. Write

**Pick the file to edit:**

- If `CLAUDE.md` exists, edit it.
- Else if `AGENTS.md` exists, edit it.
- If neither exists, ask the user which one to create — don't pick for them.

Never create `AGENTS.md` when `CLAUDE.md` already exists (or vice versa) — always edit the one that's already there.

If an `## Agent skills` block already exists in the chosen file, update its contents in-place rather than appending a duplicate. Don't overwrite user edits to the surrounding sections.

The block:

```markdown
## Agent skills

### Issue tracker

[one-line summary of where issues are tracked]. See `docs/agents/issue-tracker.md`.

### Triage states

[one-line summary of the Org TODO state mapping]. See `docs/agents/triage-states.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

Include the `### Triage states` sub-block and write `docs/agents/triage-states.md` only when Skill(triage) is installed. If a prior bootstrap created only `docs/agents/triage-labels.md`, propose replacing it during confirmation; if both files exist, ask rather than overwriting either.

Then ensure `.scratch-org/` is ignored in the root `.gitignore`, and write the docs files using the seed templates in this skill folder:

- [issue-tracker-local.md](./issue-tracker-local.md) — local Org mode issue tracker
- [triage-states.md](./triage-states.md) — Org TODO state mapping (only if Skill(triage) is installed)
- [domain.md](./domain.md) — domain doc consumer rules + layout

When Section E was approved, migrate `.scratch/` first by following the migration reference completely. Keep `.scratch/` intact as the rollback source.

When Section D was approved, place copies at the collision-checked `.scratch-org/` targets with temporary `.md` suffixes, then run the same delegated converter from `.scratch-org/`. Validate every `.org` target before removing only the approved original prompt files. Leave unmatched files in place and never overwrite a target.

After either migration, verify `.scratch-org/` is ignored, contains no tracked or staged files, and contains no Markdown staging files.

### 5. Done

Tell the user the setup or migration is complete and which engineering skills now read `.scratch-org/`. Mention they can edit `docs/agents/*.md` directly and re-run this skill later to migrate a legacy `.scratch/` tree.
