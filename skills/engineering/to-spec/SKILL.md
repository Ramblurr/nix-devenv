---
name: to-spec
description: Turn the current conversation into a spec and publish it to the project issue tracker — no interview, just synthesis of what you've already discussed.
disable-model-invocation: true
---

This skill takes the current conversation context and codebase understanding and produces a spec. Do NOT interview the user — just synthesize what you already know.

The issue tracker and triage state mapping should have been provided to you — run Skill(bootstrap-engineering-workflows) if not.

## Process

1. Explore the repo to understand the current state of the codebase, if you haven't already. Use the project's domain glossary vocabulary throughout the spec, and respect any ADRs in the area you're touching.

2. Sketch out the seams at which you're going to test the feature. Existing seams should be preferred to new ones. Use the highest seam possible. If new seams are needed, propose them at the highest point you can. The fewer seams across the codebase, the better - the ideal number is one.

Check with the user that these seams match their expectations.

3. Write the spec using the structure below, then publish it. For the local tracker, create `.scratch-org/NNN-<slug>/spec.org`, use Org mode syntax, and put `READY-FOR-AGENT` on the first heading. Render the same structure in the platform's native format for a remote tracker.

<spec-template>

```org
* READY-FOR-AGENT <Spec title>

** Problem Statement
The problem the user faces, from the user's perspective.

** Solution
The solution from the user's perspective.

** User Stories
Write an extensive numbered list that covers all aspects of the feature:

1. As an <actor>, I want <feature>, so that <benefit>.

For example: =As a mobile bank customer, I want to see my account balances, so that I can make informed spending decisions.=

** Implementation Decisions
Record the modules and interfaces affected, technical clarifications, architecture and schema decisions, API contracts, and specific interactions.

Do not include paths or snippets that will go stale. A prototype snippet may be included only when it expresses a durable decision more precisely than prose; trim it to the decision-rich shape and identify its source.

** Testing Decisions
Record the agreed external-behavior seams, modules tested, and relevant testing precedent. Prefer the highest existing seam and the fewest seams.

** Out of Scope
State explicit boundaries.

** Further Notes
Record any remaining durable context.
```

</spec-template>
