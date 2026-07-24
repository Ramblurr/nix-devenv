---
name: over-engineering-review
description: >
  Code review focused exclusively on over-engineering. Finds what to delete:
  reinvented standard library, unneeded dependencies, speculative abstractions,
  dead flexibility. Findings use numbered stable IDs and end with a progress
  checklist. Use when the user says "review for over-engineering", "what can we
  delete", "is this over-engineered", or "simplify review". Complements
  correctness-focused review; this one only hunts complexity.
---

Review diffs for unnecessary complexity. Give every finding a stable `F<N>` ID,
the location, what to cut, and what replaces it. The best outcome is a shorter diff.

Invoke Skill(over-engineering) now.

## Mandatory Delivery Contract

The review is read-only with respect to implementation files, generated files,
Git staging, and commits.
Writing the review report under `prompts/` is required and is the only permitted
file change.

Use the caller-supplied report path.
If none was supplied, choose the next appropriate
`prompts/XXX-_overengreview<X>.md` path.

Write the complete review to disk before reporting completion.
A Link callback is only a verdict and artifact pointer; it never contains or
replaces the review.

If the report cannot be written, return `BLOCKED` rather than an inline review.

## Format

Write each finding on one physical line:

`<ordinal>. F<ordinal> — <locations>: <tag> <what>. <replacement>.`

Use `file:L<line>` or `file:L<start>-<end>` locations.
Separate multiple locations with commas within one file and semicolons between files.
Assign IDs in finding order (`F1`, `F2`, ...), and keep those IDs stable if the report is revised.

Tags:

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `extlib:` hand-rolled thing an already existing dependency ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` abstraction with one implementation, config nobody sets, layer with one caller.
- `shrink:` same logic, fewer lines. Show the shorter form succinctly.

## Examples

1. F1 — src/clj/fairy/box2/model.clj:L35-38,L180-191,L326-338,L489-514; src/clj/fairy/box2/media.clj:L41-93: delete: asynchronous media/player provenance carries physical `presence-epoch` and descriptive `uid` alongside logical `request-id`. Keep `presence-epoch` on RFID/card authority; use only fields that reject a distinct stale case across media and player boundaries.

2. F2 — src/time.clj:L4: native: moment.js imported for one format call. Use `Intl.DateTimeFormat` and remove the dependency.

## Report Ending

After the findings, write the metric `net: -<N> lines possible.`

The report must end with this section and nothing may follow it:

```markdown
## Progress

- [ ] TODO F1
- [ ] TODO F2
```

Include one unchecked `TODO` item for every finding, in finding order.
If there are no findings, write `Lean already. Ship.`, `net: -0 lines possible.`,
and end with a `## Progress` section containing `No findings.`

## Boundaries

Scope: over-engineering and complexity only. Correctness bugs, security holes,
and performance are explicitly out of scope. Route them to a normal review pass,
not this one. A single smoke test or `assert`-based self-check is the  minimum,
not bloat, never flag it for deletion.  Does not apply the fixes, only
lists them. If the user asks for non-verbose mode, you can explain more.

## Deliverables

1. Write the complete, self-contained review to the designated
   `prompts/XXX-_overengreview<X>.md` path.
2. Do not modify implementation files, generated files, the Git index, or
   commits.
3. If contacted through Link, send only one of:
   - `APPROVE <report-path>`
   - `CHANGES-NEEDED <report-path>`
   - `BLOCKED <reason>`
4. Never place the review body in the Link callback or use the callback as a
   substitute for the report.
