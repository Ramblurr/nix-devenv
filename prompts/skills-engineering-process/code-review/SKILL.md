---
name: code-review
description: Review changes since a fixed point along two axes — Standards and Spec — using parallel sub-agents. Writes the complete review to a numbered file under the feature's scratch directory and returns only its path. Use when the user wants to review a branch, PR, work-in-progress changes, or asks to "review since X".
---

Two-axis review of the diff between `HEAD` and a fixed point the user supplies:

- **Standards** — does the code conform to this repo's documented coding standards?
- **Spec** — does the code faithfully implement the originating issue / PRD / spec?

Both axes run as **parallel sub-agents** so they don't pollute each other's context, then this skill aggregates their findings.

The issue tracker should have been provided to you — run Skill(bootstrap-engineering-workflows) if `docs/agents/issue-tracker.md` is missing.

## Process

### 1. Pin the fixed point

Whatever the user said is the fixed point — a commit SHA, branch name, tag, `main`, `HEAD~5`, etc. If they didn't specify one, ask for it.

Capture the diff command once: `git diff <fixed-point>...HEAD` (three-dot, so the comparison is against the merge-base). Also note the list of commits via `git log <fixed-point>..HEAD --oneline`.

Before going further, confirm the fixed point resolves (`git rev-parse <fixed-point>`) and the diff is non-empty. A bad ref or empty diff should fail here — not inside two parallel sub-agents.

### 2. Identify the spec source

Look for the originating spec, in this order:

1. Issue references in the commit messages (`#123`, `Closes #45`, GitLab `!67`, etc.) — fetch via the workflow in `docs/agents/issue-tracker.md`.
2. A path the user passed as an argument.
3. A PRD/spec file under `docs/`, `specs/`, or `.scratch/NNN-<feature>/spec.md` matching the branch name or feature.
4. If nothing is found, ask the user where the spec is. If they say there isn't one, the **Spec** sub-agent will skip and report "no spec available".

### 3. Identify the standards sources

Anything in the repo that documents how code should be written, such as `CODING_STANDARDS.md` or `CONTRIBUTING.md`.

On top of whatever the repo documents, the Standards axis always carries the **smell baseline** below — a fixed set of Fowler code smells (_Refactoring_, ch.3) that applies even when a repo documents nothing. Two rules bind it:

- **The repo overrides.** A documented repo standard always wins; where it endorses something the baseline would flag, suppress the smell.
- **Always a judgement call.** Each smell is a labelled heuristic ("possible Feature Envy"), never a hard violation — and, like any standard here, skip anything tooling already enforces.

Each smell reads *what it is* → *how to fix*; match it against the diff:

- **Mysterious Name** — a function, variable, or type whose name doesn't reveal what it does or holds. → rename it; if no honest name comes, the design's murky.
- **Duplicated Code** — the same logic shape appears in more than one hunk or file in the change. → extract the shared shape, call it from both.
- **Feature Envy** — a method that reaches into another object's data more than its own. → move the method onto the data it envies.
- **Data Clumps** — the same few fields or params keep travelling together (a type wanting to be born). → bundle them into one type, pass that.
- **Primitive Obsession** — a primitive or string standing in for a domain concept that deserves its own type. → give the concept its own small type.
- **Repeated Switches** — the same `switch`/`if`-cascade on the same type recurs across the change. → replace with polymorphism, or one map both sites share.
- **Shotgun Surgery** — one logical change forces scattered edits across many files in the diff. → gather what changes together into one module.
- **Divergent Change** — one file or module is edited for several unrelated reasons. → split so each module changes for one reason.
- **Speculative Generality** — abstraction, parameters, or hooks added for needs the spec doesn't have. → delete it; inline back until a real need shows.
- **Message Chains** — long `a.b().c().d()` navigation the caller shouldn't depend on. → hide the walk behind one method on the first object.
- **Middle Man** — a class or function that mostly just delegates onward. → cut it, call the real target direct.
- **Refused Bequest** — a subclass or implementer that ignores or overrides most of what it inherits. → drop the inheritance, use composition.

### 4. Resolve the report paths

Every review is an on-disk artifact. Never send a review body through agent chat or a link callback.

Choose the appropriate `.scratch/NNN-<feature-or-concept>/` directory:

1. Use the directory containing the originating spec when it is `.scratch/NNN-<feature>/spec.md`.
2. Otherwise, use the single existing `.scratch/NNN-<feature-or-concept>/` directory that clearly matches the branch or change.
3. If none exists, create one using the next `NNN` from the shared repo-wide sequence.
4. If multiple directories plausibly match, ask instead of guessing.

Inspect existing `review*.md` files in that directory. Let `<N>` be one greater than the highest review-round number in any canonical or axis report, or `1` when none exist. Reserve three distinct paths and never overwrite them:

- Standards: `.scratch/NNN-<feature-or-concept>/review<N>-standards.md`
- Spec: `.scratch/NNN-<feature-or-concept>/review<N>-spec.md`
- Aggregate: `.scratch/NNN-<feature-or-concept>/review<N>.md`

### 5. Spawn both sub-agents in parallel

Pass only [standards-review-template.md](standards-review-template.md) to the Standards reviewer and only [spec-review-template.md](spec-review-template.md) to the Spec reviewer. Pass the template's absolute path and the assigned axis-report path with this explicit instruction: "Use this as the template for your review report." Do not expose either reviewer to the aggregate template or the other axis's template. Each reviewer must write its complete report before replying.

The review is read-only with respect to implementation files, generated files, Git staging, and commits. Writing the assigned report is the required exception.

**Standards sub-agent prompt** — include:

- The full diff command and commit list.
- The standards-source files from step 3 and the complete smell baseline.
- The Standards template path and Standards report path.
- The brief: report documented-standard violations and baseline smells per file or hunk; cite the standard or name the smell, distinguish hard violations from judgement calls, honor repo overrides, skip anything tooling enforces, and keep the report under 400 words.
- Use temporary finding IDs `S1`, `S2`, and so on; the aggregate assigns final numbers.

**Spec sub-agent prompt** — include:

- The full diff command and commit list.
- The path or fetched contents of the spec.
- The Spec template path and Spec report path.
- The brief: report missing or partial requirements, scope creep, and apparently implemented requirements whose implementation is wrong; quote the relevant spec line and keep the report under 400 words.
- Use temporary finding IDs `P1`, `P2`, and so on; the aggregate assigns final numbers.

Use Skill(requesting-code-review) to preflight the linked reviewers, dispatch both assignments in parallel, wait for their callbacks, and verify their report artifacts.

If the spec is missing, skip the Spec sub-agent and do not create its axis report. Record "No spec available" in the aggregate.

### 6. Aggregate on disk

Proceed only after Skill(requesting-code-review) returns verified paths for every dispatched axis report.

Read [code-review-template.md](code-review-template.md) completely, then read the axis reports from disk and write the canonical aggregate to `review<N>.md` using its `<code-review-report-template>`. Keep Standards and Spec separate and do not rerank findings across axes.

Assign final finding numbers as one sequence starting at `1`: number all Standards findings first, then continue through Spec findings. Add exactly one unchecked `TODO` item to `## Progress` for every numbered finding, using the same number and title.

Never present the review body through chat. Return only the canonical `review<N>.md` path. If the aggregate cannot be written, report `BLOCKED` rather than substituting an inline review.

## Why two axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing → **Standards pass, Spec fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Spec pass, Standards fail.**

Reporting them separately stops one axis from masking the other.
