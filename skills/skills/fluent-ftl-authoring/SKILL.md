---
name: fluent-ftl-authoring
description: Guides writing and reviewing Fluent Translation List (FTL) syntax for natural, context-rich translations. Use when creating or editing .ftl resources; choosing messages, terms, attributes, variables, placeables, comments, select expressions, or plural variants; or translating gettext habits into Fluent authoring.
---

# Fluent FTL authoring

Write Fluent resources that give each locale enough context and freedom to sound natural.

## Scope

This skill covers FTL resource content and authoring choices. Its scope ends at the resource boundary: do not discuss how resources are loaded, processed, or connected to application code.

## Workflow

1. Read nearby `.ftl` entries and preserve the project's identifier, comment, and layout conventions.
2. Determine the message's purpose, UI role, audience, variable meanings and types, and space or markup constraints.
3. Choose a stable semantic identifier. Keep it for minor copy edits; replace it when the message's meaning or contract changes.
4. Write a complete, natural message. Prefer repetition over fragments assembled through variables or references.
5. Add a `#` comment when context is not obvious. Document each variable's type and meaning.
6. Keep related strings for one conceptual UI unit together as attributes. Use terms only for controlled vocabulary and language-specific grammatical forms.
7. Use select expressions only for linguistic or stylistic variation. Use separate messages for branches that change application behavior or UI purpose.
8. Check that every select has exactly one default and that its default remains sensible for every unmatched selector value.
9. Review the result against the checklist below and the detailed references.

## Quick example

```ftl
### Account settings

## Invitations

# Shown when another person invites the current user to a team.
# $sender (String) - The name of the person who sent the invitation.
# $count (Number) - The number of pending invitations.
invitation-summary =
    { $count ->
        [one] { $sender } sent you an invitation.
       *[other] { $sender } sent you { $count } invitations.
    }
    .aria-label = Pending invitations from { $sender }
```

## Non-negotiable authoring rules

- Treat identifiers and variables as semantic contracts, not source-language text.
- Give localizers complete messages and sufficient context; do not concatenate translated fragments.
- Prefer WET over DRY. Repetition is cheaper than hidden grammar and missing context.
- Let each locale choose its own variants. Do not force the source locale's plural or gender structure onto other locales.
- A default variant is fallback wording, not a hidden application branch.
- Prefer actual Unicode characters. Use quoted literals only when syntax or invisible characters require them.
- Indent multiline patterns with spaces, never tabs.

## References

Read the relevant guide before editing:

- [SYNTAX.md](SYNTAX.md) — compact syntax and validity reference.
- [WRITING.md](WRITING.md) — effective authoring practices and gettext mental-model shift.
- [EXAMPLES.md](EXAMPLES.md) — good and bad patterns for common cases.

## Final review

- Is every identifier stable, semantic, and specific to one purpose?
- Can a localizer understand the UI context and every variable without reading source code?
- Does each entry contain enough surrounding grammar to translate naturally?
- Are terms and references serving vocabulary rather than code-style deduplication?
- Are selects linguistic, with one universally acceptable default?
- Are distinct actions and UI purposes separate messages?
- Are attributes, comments, indentation, braces, and special characters valid FTL?
