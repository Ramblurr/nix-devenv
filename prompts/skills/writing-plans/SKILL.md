---
name: writing-plans
description: Turns an approved design into a short, ordered implementation plan of observable capability slices. Use when design is complete and implementation needs decomposition, ordering, touchpoints, and concrete proof without scripted code.
---

# Writing Plans

Turn a spec into a short, ordered list of **vertical slices**. A slice is one observable capability cut through every part it needs — **working on its own** and **verifiable on its own**.

The spec already says WHAT and WHY. The plan adds only three things: how the work is **sliced**, in what **order**, and the **end-to-end behavior** that proves each slice works. Assume a skilled executor with the codebase and the convention skills — they know HOW. Do not script it.

Announce at the start: "I'm using the writing-plans skill to create the implementation plan."

## Before planning

Use this skill only after the design is settled.
Read the design, affected code, project instructions, and relevant convention skills.
If a blocking product or architecture question remains, stop and resolve it instead of burying it in the plan.
Reference applicable skills and project documents; never restate them.
Use Skill(prompts-documents) to choose the plan path and filename.

## The one rule: slice vertically, never horizontally

Each task is a **vertical slice**, never a technical layer.
A slice is correct only when all three are true:

- **Works on its own:** it leaves the system working with one more coherent capability.
- **Verifiable on its own:** it has a concrete observation that proves the capability.
- **One capability:** describe an outcome for a user, caller, operator, or system—not an implementation category.

```text
❌ HORIZONTAL — value appears only after the final task
   Task 0: Write all tests to test the universe
   Task 1: Define all schemas and records
   Task 2: Implement all domain functions and handlers
   Task 3: Wire all interfaces
   Task 4: Integrate everything and verify the finished feature

✅ VERTICAL — each task delivers and proves an outcome
   App:     A member can view saved links; then add one; then mark one read
   Library: A caller can decode a valid document; then diagnose an invalid one
```

A slice may touch one file or many layers; layer count does not matter.
Fold shared groundwork into the first slice that consumes it.
If groundwork must stand alone, make it the smallest independently verifiable task and state why it cannot be folded.
Allow plain tasks for documentation, migrations, operational work, and final housekeeping; give each task its own proof.

## Require concrete proof

Every slice and plain task names the observation that demonstrates completion.
Choose the cheapest proof at the highest meaningful boundary: a focused test, REPL observation, request, public API call, CLI invocation, build evaluation, or manual check.
Here, **end-to-end** means through the highest meaningful boundary for that capability; it does not require a browser or multiple architectural layers.
State the input or action and the expected result.

| Weak proof | Strong proof |
|---|---|
| "Test that parsing works." | "Calling the public decoder with a truncated header returns an `invalid-header` error and no partial result." |
| "Run CI." | "Loading the package in a clean process and calling its public entry point returns the documented value." |

Proof is a completion criterion, not execution ceremony.
Do not prescribe repeated red-green steps, full-suite runs, CI runs, or commits inside each slice.
Reserve project-wide verification for the completion gate.

For Clojure execution, require Skill(clojure-repl-driven-development) and Skill(clojure-eval).
The plan states behavior to observe through the running program; those skills own the source-on-disk, reload, evaluation, and preservation workflow.
A focused test may preserve behavior after REPL exploration; the plan must not impose test-first discovery.

## Use this plan shape

```markdown
# [Feature] Implementation Plan
Goal: [one sentence]
Design: [path to the approved design]
Constraints: [only cross-cutting constraints that are easy to miss; omit if empty]

## Slices
### Slice 1: [observable outcome]
- Delivers: [new capability or preserved invariant]
- Touchpoints: [important repo-relative files, namespaces, interfaces, or state boundaries]
- Proof: [action or input and expected observation]
- Notes: [only non-obvious decisions, risks, or dependencies; omit if empty]

## Completion gate
- [project-wide checks required once after the slices]
- [non-slice documentation or operational verification, if needed]
```

Use one checkbox for each slice or plain task when tracking is useful; do not turn every field into a checkbox.
Touchpoints identify architecture, not an exhaustive file inventory.

## Keep it reviewable

Use as few slices as the work needs; most plans should stay within 1–7 slices and fewer than 100 lines.
If the plan grows beyond that, remove duplicated design and routine implementation detail first; then split independent scope into separate plans.

Exclude routine code, command transcripts, expected test-run output, per-file instructions, repeated constraints, and speculative abstractions.
Include exact commands or data details only when safety, destructive operations, migrations, or unusual configuration require them.
Never use placeholders such as "handle edge cases," "similar to above," or "implement later."

## Self-review

Before saving, verify:

1. Every requirement maps to a slice or plain task with concrete, appropriate proof.
2. Each slice names an outcome rather than a technical layer.
3. Later slices depend only on earlier slices.
4. Groundwork is folded into its first consumer unless a stated constraint prevents it.
5. The plan references rather than repeats the design and other skills.
6. The plan stays within the length target or explains why the scope cannot split.

Fix failures inline, save the plan, and report its path for review.
