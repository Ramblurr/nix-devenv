---
name: code-review
description: Review committed or working-tree changes along Standards and Spec axes using parallel sub-agents. Writes an Org report under the feature's local work-item directory and returns its path, or a blocked reason. Use for branch, PR, or work-in-progress reviews.
---

Two-axis review of a pinned committed or working-tree state:

- **Standards** — does the code conform to this repo's documented coding standards?
- **Spec** — does the code faithfully implement the originating issue / spec?

Both axes run as **parallel sub-agents** so they don't pollute each other's context, then this skill aggregates their findings. Give each reviewer a self-contained brief in an independent context, not a fork of the current conversation. Follow Skill(requesting-code-review) for dispatch and artifact verification.

The issue tracker should have been provided to you. Use that tracker doc; if none was provided, ask the user to run Skill(bootstrap-engineering-workflows).

## Process

### 1. Pin the review state

Choose the mode from the user's request; ask when ambiguous. Resolve references to commit IDs and record HEAD before capturing inputs.

- **Committed branch/PR:** require the user's fixed point (ask if absent). Resolve `<base>` with `git merge-base <fixed-point> <head>`, then capture `git diff --binary <base> <head>` and `git log <fixed-point>..<head> --oneline`.
- **Working tree/WIP:** default the base to captured HEAD unless the user requests another comparison base. Capture `git diff --binary <base>` for the final tracked working-tree state, including staged and unstaged changes. Also capture `git diff --cached --binary <base>` and `git diff --binary` to preserve the index/working-tree distinction, including staged changes undone in the working tree. Label findings specific to the index separately from findings in the final working-tree state. Enumerate non-ignored untracked files with `git ls-files --others --exclude-standard` and include the task-relevant files; record exclusions explicitly. Ask if their relevance is unclear.
- **Staged only:** capture `git diff --cached --binary <base>`, using captured HEAD as the default base. Review index contents, not later working-tree edits; exclude unstaged and untracked files unless requested.

Preserve the captured diffs and a manifest of mode, base, HEAD, scope, exclusions and content hashes in a local review-input directory outside tracked source. Include frozen copies of relevant untracked files and the target file contents needed to inspect the captured state (index contents for staged-only review). Record deleted paths. Verify inputs did not change during capture; recapture if they did. Do not stage or commit to create the snapshot.

Give both reviewers the same absolute input-directory path. They must review the captured state, not substitute their checkout's HEAD or reread mutable files as if unchanged. If further context is needed, retrieve it at the pinned revision or freeze it after verifying its identity. An isolated child checkout does not contain the parent's uncommitted state automatically.

Stop before dispatch if a reference is invalid, required inputs are inaccessible, or the entire selected scope is empty, including relevant untracked files. For WIP, an empty committed diff alone is not an empty review.

### 2. Identify the spec source

Look for the originating spec, in this order:

1. Issue references in the commit messages (`#123`, `Closes #45`, GitLab `!67`, etc.) — fetch via the workflow in the provided tracker doc.
2. A path the user passed as an argument.
3. A spec file under `docs/`, `specs/`, or `.scratch-org/NNN-<feature>/spec.org` matching the branch name or feature.
4. If nothing is found, ask the user where the spec is. If they say there isn't one, the **Spec** sub-agent will skip and report "no spec available".

### 3. Identify the standards sources

Search the repo for every applicable file documenting how code should be written, including scoped instructions. Include `CODING_STANDARDS.md` and `CONTRIBUTING.md` whenever they exist; pass their paths to the Standards reviewer rather than relying on implicit context.

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

Every review is an Org mode artifact on disk. Never return a review body through agent chat or a completion message.

Choose the appropriate `.scratch-org/NNN-<feature-or-concept>/` directory:

1. Use the directory containing the originating spec when it is `.scratch-org/NNN-<feature>/spec.org`.
2. Otherwise, use the single existing `.scratch-org/NNN-<feature-or-concept>/` directory that clearly matches the branch or change.
3. If none exists, create one using the next `NNN` from the shared repo-wide sequence.
4. If multiple directories plausibly match, ask instead of guessing.

Inspect existing `review*.org` files in that directory. Let `<N>` be one greater than the highest review-round number in any canonical or axis report, or `1` when none exist. Reserve three distinct paths and never overwrite them:

- Standards: `.scratch-org/NNN-<feature-or-concept>/review<N>-standards.org`
- Spec: `.scratch-org/NNN-<feature-or-concept>/review<N>-spec.org`
- Aggregate: `.scratch-org/NNN-<feature-or-concept>/review<N>.org`

If the `.scratch-org` directory does not exist. DO NOT CREATE ONE. Stop (before even starting your review, so right after reading this skill) and ask if you should write the review to disk or just output it in the chat.

### 5. Spawn both sub-agents in parallel

Pass only [standards-review-template.md](standards-review-template.md) to the Standards reviewer and only [spec-review-template.md](spec-review-template.md) to the Spec reviewer. Pass the template's absolute path and the assigned axis-report path with this explicit instruction: "Use this as the template for your review report." Do not expose either reviewer to the aggregate template or the other axis's template. Each reviewer must write its complete report before replying.

The review is read-only with respect to implementation files, generated files, Git staging, and commits. Writing the assigned report is the required exception.

**Standards sub-agent prompt** — include:

- The review mode, pinned base/HEAD, captured input directory and manifest, diff commands and commit list (when applicable).
- The standards-source files from step 3 and the complete smell baseline.
- The Standards template path and Standards report path.
- The brief: report documented-standard violations and baseline smells per file or hunk; cite the standard or name the smell, distinguish hard violations from judgement calls, honor repo overrides, skip anything tooling enforces, and keep the report under 400 words.
- Use temporary finding IDs `S1`, `S2`, and so on; the aggregate assigns final numbers.

**Spec sub-agent prompt** — include:

- The review mode, pinned base/HEAD, captured input directory and manifest, diff commands and commit list (when applicable).
- The path or fetched contents of the spec.
- The Spec template path and Spec report path.
- The brief: report missing or partial requirements, scope creep, and apparently implemented requirements whose implementation is wrong; quote the relevant spec line and keep the report under 400 words.
- Use temporary finding IDs `P1`, `P2`, and so on; the aggregate assigns final numbers.

Use Skill(requesting-code-review) to prepare independent reviewers, dispatch both assignments in parallel, await their results, and verify their report artifacts.

If the spec is missing, skip the Spec sub-agent and do not create its axis report. Record "No spec available" in the aggregate.

### 6. Aggregate on disk

If any dispatched axis returns `BLOCKED`, retain completed reports and return `BLOCKED <axis>: <reason>` with their paths. Do not create a complete aggregate or claim approval. Resolve the blocker and request the missing review through Skill(sub-agents); reuse completed reports only if the pinned inputs and review requirements are unchanged.

Otherwise proceed only after Skill(requesting-code-review) returns verified paths for every dispatched axis report. Record the reviewed mode and input manifest in the aggregate; approval applies only to that captured state, not subsequent edits.

Read [code-review-template.md](code-review-template.md) completely, then read the axis reports from disk and write the canonical Org aggregate to `review<N>.org` using its `<code-review-report-template>`. Keep Standards and Spec separate and do not rerank findings across axes.

Assign final finding numbers as one sequence starting at `1`: number all Standards findings first, then continue through Spec findings. Add exactly one unchecked `TODO` item to `* Progress` for every numbered finding, using the same number and title.

Never present the review body through chat. Return only the canonical `review<N>.org` path. If the aggregate cannot be written, report `BLOCKED` rather than substituting an inline review.

## Why two axes

A change can pass one axis and fail the other:

- Code that follows every standard but implements the wrong thing → **Standards pass, Spec fail.**
- Code that does exactly what the issue asked but breaks the project's conventions → **Spec pass, Standards fail.**

Reporting them separately stops one axis from masking the other.
