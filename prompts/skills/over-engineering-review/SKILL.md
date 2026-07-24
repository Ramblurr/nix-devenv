---
name: over-engineering-review
description: >
  Code review focused exclusively on over-engineering. Finds what to delete:
  reinvented standard library, unneeded dependencies, speculative abstractions,
  dead flexibility. One line per finding: location, what to cut, what replaces
  it. Use when the user says "review for over-engineering", "what can we
  delete", "is this over-engineered", "simplify review". Complements correctness-focused review, this one only hunts complexity.
---

Review diffs for unnecessary complexity. One line per finding: location, what
to cut, what replaces it. The diff's best outcome is getting shorter.

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

`L<line>: <tag> <what>. <replacement>.`, or `<file>:L<line>: ...` for
multi-file diffs.

Tags:

- `delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `stdlib:` hand-rolled thing the standard library ships. Name the function.
- `extlib:` hand-rolled thing an already existing dependency ships. Name the function.
- `native:` dependency or code doing what the platform already does. Name the feature.
- `yagni:` abstraction with one implementation, config nobody sets, layer with one caller.
- `shrink:` same logic, fewer lines. Show the shorter form, can break onto multiple lines.

## Examples

❌ "This EmailValidator class might be more complex than necessary, have you
considered whether all these validation rules are needed at this stage?"

✅ `L12-38: stdlib: 27-line validator class. "@" in email, 1 line, real validation is the confirmation mail.`

✅ `L4: native: moment.js imported for one format call. Intl.DateTimeFormat, 0 deps.`

✅ `repo.py:L88: yagni: AbstractRepository with one implementation. Inline it until a second one exists.`

✅ `L52-71: delete: retry wrapper around an idempotent local call. Nothing replaces it.`

✅ `L30-44: shrink: manual loop builds dict. dict(zip(keys, values)), 1 line.`

## Scoring

End with the only metric that matters: `net: -<N> lines possible.`

If there is nothing to cut, say `Lean already. Ship.` and stop.

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
