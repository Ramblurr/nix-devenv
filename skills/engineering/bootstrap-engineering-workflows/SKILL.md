---
name: bootstrap-engineering-workflows
description: Configure this repo for the engineering workflows — set up its local issue tracker, triage label vocabulary, and domain doc layout, and migrate legacy prompts documents. Run once before first use of the other engineering-process skills.
disable-model-invocation: true
---

# Bootstrap Engineering Workflows

Scaffold the per-repo configuration that the engineering skills assume:

- **Issue tracker** — local markdown under `.scratch/NNN-<slug>/`
- **Triage labels** — the strings used for the five canonical triage roles
- **Domain docs** — where `CONTEXT.md` and ADRs live, and the consumer rules for reading them

This is a prompt-driven skill, not a deterministic script. Explore, present what you found, confirm with the user, then write.

## Process

### 1. Explore

Look at the current repo to understand its starting state. Read whatever exists; don't assume:

- `AGENTS.md` and `CLAUDE.md` at the repo root — does either exist? Is there already an `## Agent skills` section in either?
- `CONTEXT.md` and `CONTEXT-MAP.md` at the repo root
- `docs/adr/` and any `src/*/docs/adr/` directories
- `docs/agents/` — does this skill's prior output already exist?
- `.scratch/` — sign that a local-markdown issue tracker convention is already in use
- `prompts/` — does it contain numbered workflow documents that follow the legacy `prompts/NNN-concept...` convention?
- Is Skill(triage) installed? (a `triage` skill folder alongside this one, or Skill(triage) in your available skills.) This decides whether Section B runs at all.
- Monorepo signals — a `pnpm-workspace.yaml`, a `workspaces` field in `package.json`, a populated `packages/*` with its own `src/`, or a `deps.edn` that mentions a monorepo. Also check whether `README.md`, `AGENTS.md`, or `CLAUDE.md` makes clear that this is a Clojure project with multiple subprojects. Present multi-context only for a genuine multi-project repo; otherwise use single-context, which fits almost every repo.

### 2. Present findings and ask

Summarise what's present and what's missing. Then take the sections in order, pausing for an answer only when a section asks a question.

Lead each question with the recommended answer so the user can accept it in a word. Give a one-line explainer only when the choice genuinely branches; skip the section entirely when exploration already settled it (Section B when Skill(triage) isn't installed, Section C when there's no monorepo, Section D when there are no legacy prompts documents).

**Section A — Issue tracker.**

The engineering workflows use local markdown. Tell the user that issues and specs will live under `.scratch/NNN-<slug>/`, with `NNN` drawn from one shared repo-wide three-digit sequence; there is no issue-tracker choice to make.

Record the configuration in `docs/agents/issue-tracker.md` using the local-markdown seed template.

**Section B — Triage label vocabulary.** Skip this section entirely if Skill(triage) isn't installed (exploration told you) — an uninstalled skill needs no labels.

If it is installed, ask exactly one question:

> Do you want to keep the default triage labels? (recommended: **yes**)

The defaults are the five canonical roles, each label string equal to its name: `needs-triage`, `needs-info`, `ready-for-agent`, `ready-for-human`, `wontfix`. On **yes**, write them as-is. Only if the user says no — usually because their tracker already uses other names (e.g. `bug:triage` for `needs-triage`) — collect the overrides so Skill(triage) applies existing labels instead of creating duplicates.

**Section C — Domain docs.** Default to **single-context** — one `CONTEXT.md` + `docs/adr/` at the repo root. This fits almost every repo; write it without asking.

Offer **multi-context** — a root `CONTEXT-MAP.md` pointing to per-context `CONTEXT.md` files — only when exploration found monorepo signals. Then confirm which layout they want.

**Section D — Legacy `prompts/` documents.** Skip this section entirely if exploration found no numbered workflow documents matching the legacy convention.

If matching documents exist, show the proposed migration and ask for approval. Migrate files without rewriting their contents:

- Obvious OCP (Skill(operational-change-protocol)) ledger documents → `.scratch/ocp/YYYYMMDDTHHMMSSZ-<slug>.md`
  - any numbering gaps produced by moving the OCP ledgers out of the NNN sequence should be preserved. Do not renumber documents.
- `prompts/NNN-<concept>.md` → `.scratch/NNN-<concept>/spec.md`
- `prompts/NNN-<concept>_<suffix>.md` → `.scratch/NNN-<concept>/<suffix>.md`

Treat a document as an obvious OCP ledger only when its filename names OCP or operational change, or its contents clearly identify it as an OCP ledger. Reuse an unambiguous timestamp and slug from the filename or ledger; if either is missing or ambiguous, stop and ask instead of placing it in the normal concept sequence or inventing a value.

For all other documents, retain each source group's `NNN`; do not allocate a new number during migration. Group files with the same `NNN-concept` prefix in the same directory. If a target already exists, two source groups would collide, or a document doesn't match the convention, stop and ask instead of overwriting or guessing.

### 3. Confirm and edit

Show the user a draft of:

- The `## Agent skills` block to add to whichever of `CLAUDE.md` / `AGENTS.md` is being edited (see step 4 for selection rules)
- The contents of `docs/agents/issue-tracker.md`, `docs/agents/domain.md`, and `docs/agents/triage-labels.md` (the last only when Skill(triage) is installed)
- The exact source and destination paths for the prompts migration (only when Section D ran)

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

### Triage labels

[one-line summary of the label vocabulary]. See `docs/agents/triage-labels.md`.

### Domain docs

[one-line summary of layout — "single-context" or "multi-context"]. See `docs/agents/domain.md`.
```

Include the `### Triage labels` sub-block, and write `docs/agents/triage-labels.md`, only when Skill(triage) is installed and Section B ran. When it isn't, both are omitted.

Then write the docs files using the seed templates in this skill folder as a starting point:

- [issue-tracker-local.md](./issue-tracker-local.md) — local-markdown issue tracker
- [triage-labels.md](./triage-labels.md) — label mapping (only if Skill(triage) is installed)
- [domain.md](./domain.md) — domain doc consumer rules + layout

When Section D ran and the user approved the migration, create `.scratch/ocp/` and the target `.scratch/NNN-<concept>/` directories as needed, then move the files exactly as shown in the approved plan. Preserve their contents verbatim. Leave unmatched files in place, never overwrite a target, and remove `prompts/` only if it is empty afterward.

### 5. Done

Tell the user the setup is complete and which engineering skills will now read from these files. Mention they can edit `docs/agents/*.md` directly later — re-running this skill is only necessary if they want to restart from scratch.
