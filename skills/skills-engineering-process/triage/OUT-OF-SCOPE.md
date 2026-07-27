# Out-of-Scope Knowledge Base

An `out-of-scope.md` file inside a numbered `.scratch/NNN-<concept>/` directory stores a persistent record of a rejected feature request. These files serve two purposes:

1. **Institutional memory** — why a feature was rejected, so the reasoning isn't lost when the issue is closed
2. **Deduplication** — when a new issue comes in that matches a prior rejection, the skill can surface the previous decision instead of re-litigating it

## Directory structure

```
.scratch/
├── 042-dark-mode/
│   ├── spec.md
│   └── out-of-scope.md
├── 057-plugin-system/
│   └── out-of-scope.md
└── 103-graphql-api/
    └── out-of-scope.md
```

One numbered directory per **concept**, not per issue. Multiple issues requesting the same thing are grouped in one `out-of-scope.md` file. The `NNN` prefix comes from the same shared repo-wide sequence as every other top-level `.scratch/` work item.

## File format

The file should be written in a relaxed, readable style — more like a short design document than a database entry. Use paragraphs, code samples, and examples to make the reasoning clear and useful to someone encountering it for the first time.

```markdown
# Dark Mode

This project does not support dark mode or user-facing theming.

## Why this is out of scope

The rendering pipeline assumes a single color palette defined in
`ThemeConfig`. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that doesn't align with the
project's focus on content authoring. Theming is a concern for downstream
consumers who embed or redistribute the output.

```ts
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
```

## Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### Naming the directory

Use the existing `.scratch/NNN-<concept>/` directory when the request already belongs to a work item. Otherwise, allocate the next available `NNN` from the shared repo-wide sequence and use a short, descriptive kebab-case concept name. The decision file is always named `out-of-scope.md`.

### Writing the reason

The reason should be substantive — not "we don't want this" but why. Good reasons reference:

- Project scope or philosophy ("This project focuses on X; theming is a downstream concern")
- Technical constraints ("Supporting this would require Y, which conflicts with our Z architecture")
- Strategic decisions ("We chose to use A instead of B because...")

The reason should be durable. Avoid referencing temporary circumstances ("we're too busy right now") — those aren't real rejections, they're deferrals.

## When to check out-of-scope records

During triage (Step 1: Gather context), read every `.scratch/NNN-<concept>/out-of-scope.md` file. When evaluating a new issue:

- Check if the request matches an existing out-of-scope concept
- Matching is by concept similarity, not keyword — "night theme" matches `.scratch/042-dark-mode/out-of-scope.md`
- If there's a match, surface it to the maintainer: "This is similar to `.scratch/042-dark-mode/out-of-scope.md` — we rejected this before because [reason]. Do you still feel the same way?"

The maintainer may:

- **Confirm** — the new issue gets added to the existing file's "Prior requests" list, then closed
- **Reconsider** — the out-of-scope file gets deleted or updated, and the issue proceeds through normal triage
- **Disagree** — the issues are related but distinct, proceed with normal triage

## When to write `out-of-scope.md`

Only when an **enhancement** (not a bug) is *rejected* as `wontfix`. This applies to enhancement PRs exactly as it does to issues — a rejected PR is recorded here so the same request doesn't return as fresh code.

Do **not** write here when something is closed as `wontfix` because it's **already implemented**. That's a built feature, not a rejected one; recording it would poison the dedup checks with false rejections. Instead, the closing comment points to where the feature already lives.

The flow:

1. Maintainer decides a feature request is out of scope
2. Check if a matching `.scratch/NNN-<concept>/out-of-scope.md` file already exists
3. If yes: append the new issue to the "Prior requests" list
4. If no: use the request's existing numbered work-item directory, or allocate the next `NNN` from the shared sequence; create `out-of-scope.md` with the concept name, decision, reason, and first prior request
5. Post a comment on the issue explaining the decision and mentioning the `out-of-scope.md` file
6. Close the issue with the `wontfix` label

## Updating or removing out-of-scope files

If the maintainer changes their mind about a previously rejected concept:

- Delete the concept's `out-of-scope.md` file; keep its numbered work-item directory and any other files in it
- The skill does not need to reopen old issues — they're historical records
- The new issue that triggered the reconsideration proceeds through normal triage
