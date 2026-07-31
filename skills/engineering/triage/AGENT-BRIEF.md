# Writing Agent Briefs

An agent brief is a structured comment appended to an issue, local ticket, or PR when it moves to `ready-for-agent`. It is the authoritative specification that an AFK agent will work from. The original body and discussion are context — the agent brief is the contract. Render it in the tracker's native format; the templates below use Org mode for the default local tracker.

The brief states **what the agent should do**, which stretches to both surfaces: for an issue, that's building the change from nothing; for a PR, it's what's left to do *to the existing diff* — finish it, close gaps, address review points. Same principles either way; the PR example below shows the difference.

## Principles

### Durability over precision

The issue may sit in `ready-for-agent` for days or weeks. The codebase will change in the meantime. Write the brief so it stays useful even as files are renamed, moved, or refactored.

- **Do** describe interfaces, types, and behavioral contracts
- **Do** name specific types, function signatures, or config shapes that the agent should look for or modify
- **Don't** reference file paths — they go stale
- **Don't** reference line numbers
- **Don't** assume the current implementation structure will remain the same

### Behavioral, not procedural

Describe **what** the system should do, not **how** to implement it. The agent will explore the codebase fresh and make its own implementation decisions.

- **Good:** "The `SkillConfig` type should accept an optional `schedule` field of type `CronExpression`"
- **Bad:** "Open src/types/skill.ts and add a schedule field on line 42"
- **Good:** "When a user runs Skill(triage) with no arguments, they should see a summary of issues needing attention"
- **Bad:** "Add a switch statement in the main handler function"

### Complete acceptance criteria

The agent needs to know when it's done. Every agent brief must have concrete, testable acceptance criteria. Each criterion should be independently verifiable.

- **Good:** "Running `gh issue list --label needs-triage` returns issues that have been through initial classification"
- **Bad:** "Triage should work correctly"

### Explicit scope boundaries

State what is out of scope. This prevents the agent from gold-plating or making assumptions about adjacent features.

## Template

```org
*** Agent Brief
- Category :: bug / enhancement
- Summary :: one-line description of what needs to happen

**** Current behavior
Describe what happens now. For bugs, this is the broken behavior. For enhancements, this is the status quo.

**** Desired behavior
Describe what should happen after the work. Include edge cases and error conditions.

**** Key interfaces
- =TypeName= — what needs to change and why
- =functionName()= return type — current versus desired result
- Config shape — any new configuration options

**** Acceptance criteria
- [ ] Specific, testable criterion 1
- [ ] Specific, testable criterion 2
- [ ] Specific, testable criterion 3

**** Out of scope
- Thing that must not change
- Adjacent but separate feature
```

## Examples

### Good agent brief (bug)

```org
*** Agent Brief
- Category :: bug
- Summary :: Skill description truncation drops mid-word, producing broken output

**** Current behavior
When a skill description exceeds 1024 characters, it is truncated at exactly 1024 characters regardless of word boundaries. This produces descriptions that end mid-word.

**** Desired behavior
Truncation should break at the last word boundary before 1024 characters and append =...=.

**** Key interfaces
- =SkillMetadata='s =description= field — no type change, but its population logic must respect word boundaries.
- Any function that reads =SKILL.md= frontmatter and extracts the description.

**** Acceptance criteria
- [ ] Descriptions under 1024 characters are unchanged.
- [ ] Longer descriptions break at the last word boundary.
- [ ] Truncated descriptions end with =...=.
- [ ] Total length, including =...=, does not exceed 1024 characters.

**** Out of scope
- Changing the 1024-character limit
- Multi-line description support
```

### Good agent brief (enhancement)

```org
*** Agent Brief
- Category :: enhancement
- Summary :: Add per-concept =out-of-scope.org= support for rejected feature requests

**** Current behavior
Rejected feature requests have no persistent local record of their decision or reasoning, so later requests require the maintainer to remember or find the prior discussion.

**** Desired behavior
Document rejected requests in =.scratch-org/NNN-<concept>/out-of-scope.org= with the decision, reasoning, and Org links. Triage checks these files for conceptual matches.

**** Key interfaces
- Org mode format with a top-level concept heading, a =** Why this is out of scope= section, and a =** Prior requests= list.
- Triage reads every matching =out-of-scope.org= early and matches by concept.

**** Acceptance criteria
- [ ] Rejecting an enhancement creates or updates the concept's =out-of-scope.org=.
- [ ] The file includes reasoning and an Org link to the closed request.
- [ ] A matching file receives a Prior requests entry rather than a duplicate.
- [ ] Triage surfaces matching prior rejections.

**** Out of scope
- Automated matching
- Reopening previously rejected features
- Bug reports
```

### Good agent brief (PR)

For a PR, "Current behavior" describes the state of the diff, and the brief asks the agent to finish or fix it rather than build from scratch.

```org
*** Agent Brief
- Category :: enhancement
- Summary :: Finish the contributor's =--json= output flag for =triage list=

**** Current behavior
The PR serializes successful issue lists to JSON, but errors remain human text and the flag has no test coverage.

**** Desired behavior
With =--json=, all output, including errors, is well-formed JSON on stdout and exit codes remain unchanged. Output without the flag is untouched.

**** Key interfaces
- The error path emits ={ "error": string }= under =--json=.
- Reuse the serializer already added by the PR.

**** Acceptance criteria
- [ ] =triage list --json= emits valid JSON for success and error cases.
- [ ] Exit codes match the non-JSON command.
- [ ] Tests cover success and one error case.
- [ ] Default output is unchanged.

**** Out of scope
- Adding =--json= to another command
- Changing the existing success payload shape
```

### Bad agent brief

```org
*** Agent Brief
- Summary :: Fix the triage bug

**** What to do
The triage thing is broken. Look at the main file and fix it. The function around line 150 has the issue.

**** Files to change
- src/triage/handler.ts (line 150)
- src/types.ts (line 42)
```

This is bad because:
- No category
- Vague description ("the triage thing is broken")
- References file paths and line numbers that will go stale
- No acceptance criteria
- No scope boundaries
- No description of current vs desired behavior
