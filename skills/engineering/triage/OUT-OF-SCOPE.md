# Out-of-Scope Knowledge Base

An `out-of-scope.org` file inside a numbered `.scratch-org/NNN-<concept>/` directory stores an Org mode record of a rejected feature request. These files serve two purposes:

1. **Institutional memory** — why a feature was rejected, so the reasoning isn't lost when the issue is closed
2. **Deduplication** — when a new issue comes in that matches a prior rejection, the skill can surface the previous decision instead of re-litigating it

## Directory structure

```text
.scratch-org/
├── 042-dark-mode/
│   ├── spec.org
│   └── out-of-scope.org
├── 057-plugin-system/
│   └── out-of-scope.org
└── 103-graphql-api/
    └── out-of-scope.org
```

One numbered directory exists per **concept**, not per issue. Group repeated requests for one concept in a single `out-of-scope.org`. Its `NNN` comes from the shared `.scratch-org/` work-item sequence.

## File format

The file should be written in a relaxed, readable style — more like a short design document than a database entry. Use paragraphs, code samples, and examples to make the reasoning clear and useful to someone encountering it for the first time.

```org
* Dark Mode

This project does not support dark mode or user-facing theming.

** Why this is out of scope

The rendering pipeline assumes a single color palette defined in =ThemeConfig=. Supporting multiple themes would require:

- A theme context provider wrapping the entire component tree
- Per-component theme-aware style resolution
- A persistence layer for user theme preferences

This is a significant architectural change that does not align with the project's focus on content authoring. Theming is a concern for downstream consumers who embed or redistribute the output.

#+begin_src typescript
// The current ThemeConfig interface is not designed for runtime switching:
interface ThemeConfig {
  colors: ColorPalette; // single palette, resolved at build time
  fonts: FontStack;
}
#+end_src

** Prior requests

- #42 — "Add dark mode support"
- #87 — "Night theme for accessibility"
- #134 — "Dark theme option"
```

### Naming the directory

Use the existing `.scratch-org/NNN-<concept>/` directory when the request belongs to a work item. Otherwise allocate the next `NNN` and a short kebab-case concept name. The decision file is always `out-of-scope.org`.

### Writing the reason

The reason should be substantive — not "we don't want this" but why. Good reasons reference:

- Project scope or philosophy ("This project focuses on X; theming is a downstream concern")
- Technical constraints ("Supporting this would require Y, which conflicts with our Z architecture")
- Strategic decisions ("We chose to use A instead of B because...")

The reason should be durable. Avoid referencing temporary circumstances ("we're too busy right now") — those aren't real rejections, they're deferrals.

## When to check out-of-scope records

During triage, read every `.scratch-org/NNN-<concept>/out-of-scope.org`. When evaluating a new issue:

- Check whether it matches an existing out-of-scope concept.
- Match by concept, not keyword: "night theme" matches `.scratch-org/042-dark-mode/out-of-scope.org`.
- Surface a match with its prior reason and ask whether the decision still holds.

The maintainer may:

- **Confirm** — the new issue gets added to the existing file's "Prior requests" list, then closed
- **Reconsider** — the out-of-scope file gets deleted or updated, and the issue proceeds through normal triage
- **Disagree** — the issues are related but distinct, proceed with normal triage

## When to write `out-of-scope.org`

Only when an **enhancement** (not a bug) is *rejected* as `wontfix`. This applies to enhancement PRs exactly as it does to issues — a rejected PR is recorded here so the same request doesn't return as fresh code.

Do **not** write here when something is closed as `wontfix` because it's **already implemented**. That's a built feature, not a rejected one; recording it would poison the dedup checks with false rejections. Instead, the closing comment points to where the feature already lives.

The flow:

1. Maintainer decides a feature request is out of scope
2. Check whether a matching `.scratch-org/NNN-<concept>/out-of-scope.org` exists.
3. If yes, append the request under `** Prior requests`.
4. If no, reuse the request's work-item directory or allocate the next `NNN`; create `out-of-scope.org` with the concept, reason, and first request.
5. Explain the decision on the issue and link the Org file.
6. Close the issue with the `wontfix` label

## Updating or removing out-of-scope files

If the maintainer changes their mind about a previously rejected concept:

- Delete the concept's `out-of-scope.org`; keep its numbered work-item directory and other files.
- The skill does not need to reopen old issues — they're historical records
- The new issue that triggered the reconsideration proceeds through normal triage
