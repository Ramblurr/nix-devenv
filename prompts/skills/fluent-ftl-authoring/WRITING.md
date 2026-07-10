# Writing effective Fluent

Correct syntax is only the baseline. Effective Fluent gives localizers full context, keeps linguistic choices inside each locale, and avoids contracts that encode source-language grammar.

## Start with the semantic contract

A message identifier names a purpose, not an English sentence.

```ftl
# Distinct purposes may require distinct translations even when English is identical.
file-menu-open = Open
file-status-open = Open
```

Choose identifiers that describe the UI role or meaning. Avoid IDs copied from source text and overly broad IDs such as `open` or `label`.

Keep an identifier when fixing spelling, punctuation, or wording without changing the message's meaning. Choose a new identifier when the action, audience, variables, or semantic promise changes enough that existing translations need review.

Variables are part of the same contract. Name them for meaning, document their types, and pass raw facts rather than prewritten fragments:

```ftl
# $owner (String) - The display name of the document owner.
# $count (Number) - The number of comments not yet read.
unread-comments = { $owner }’s document has { $count } unread comments.
```

A locale may reorder variables, select on them, format them, or omit one when natural grammar does not require it.

## Prefer complete messages: WET over DRY

Do not optimize translations like program code. Splitting a sentence into reusable pieces hides context and often makes agreement, inflection, word order, and punctuation impossible to translate well.

```ftl
# Avoid: $reaction is expected to contain a translated noun phrase.
reacted-with = { $user } reacted with { $reaction }.
reaction-thumb = a thumbs up
reaction-smile = a smile
```

Repeat the whole message instead:

```ftl
# $user (String) - The display name of the person who reacted.
reacted-with-thumb = { $user } reacted with a thumbs up.

# $user (String) - The display name of the person who reacted.
reacted-with-smile = { $user } reacted with a smile.
```

This repetition gives each translation a complete grammatical unit. It also lets two apparently similar messages diverge later without breaking a shared fragment.

Use references only when the referenced text has one stable identity in every context. Use terms for controlled vocabulary such as a product name, and parameterize them when a language needs grammatical forms. Do not create terms merely to remove repeated words.

## Use selects only for language and style

A select expression belongs in FTL when variants express language-specific grammar or presentation: plural category, grammatical gender, case, formality, or another stylistic distinction.

```ftl
# $host (String) - The name of the person sharing the schedule.
# $host-gender (String) - A grammatical gender used only to choose wording.
shared-schedule =
    { $host } shared { $host-gender ->
        [masculine] his
        [feminine] her
       *[other] their
    } schedule with you.
```

The default `their` remains acceptable for unknown values, and another locale may collapse all variants or define different ones.

Do not use a select to encode required application branches:

```ftl
# Avoid: choosing the wrong fallback changes the requested action.
item-action =
    Are you sure you want to { $action ->
       *[add] add
        [remove] remove
    } this item?
```

Use separate contracts:

```ftl
item-add-confirm = Are you sure you want to add this item?
item-remove-confirm = Are you sure you want to remove this item?
```

Apply three tests before adding a select:

1. Could another locale use fewer, more, or different variants while preserving the feature's behavior?
2. Does the default produce acceptable wording for every unknown or unmatched value?
3. Would the wrong fallback change an action, data operation, navigation target, or UI purpose?

Use a select only when the answers are **yes**, **yes**, and **no**.

## Distinguish linguistic zero from a different UI purpose

An exact numeric variant is appropriate when it is alternative wording for the same status:

```ftl
new-notifications =
    { $count ->
        [0] No new notifications.
        [one] One new notification.
       *[other] { $count } new notifications.
    }
```

It is not appropriate when zero changes the purpose from status to instruction:

```ftl
# Avoid: [0] is an instruction while the other variants report status.
items-selected =
    { $count ->
        [0] Select items.
        [one] One item selected.
       *[other] { $count } items selected.
    }
```

Separate the purposes:

```ftl
items-select-prompt = Select items.
items-selected =
    { $count ->
        [one] One item selected.
       *[other] { $count } items selected.
    }
```

## Write comments that supply missing context

A useful comment answers questions the pattern cannot:

- Where and when does this appear?
- Is the text a command, status, title, label, tooltip, or sentence?
- Who speaks, and who is addressed?
- What does each variable mean, and what type or range does it have?
- Are length, markup, capitalization, or punctuation constrained?
- What do ambiguous nouns and pronouns refer to?

```ftl
# Button that permanently deletes the currently open notebook.
# Keep the label short. “Notebook” is a user-created collection, not a laptop.
notebook-delete = Delete notebook

# $expires-at (Date) - When the shared link stops working.
share-link-expiry = This link expires { DATETIME($expires-at, month: "long", day: "numeric") }.
```

Avoid comments that merely repeat the English text. Place a message comment directly above its entry with no blank line.

## Keep related UI text together with attributes

Use attributes when several strings describe one conceptual UI unit and benefit from shared context:

```ftl
email-field =
    .label = Email address
    .placeholder = name@example.com
    .aria-label = Account email address
    .error = Enter a valid email address.
```

Use separate messages when the strings represent independent actions or purposes, even if they appear near each other.

Term attributes have a narrower role: record grammatical properties used by other messages as selectors. Do not use them as visible text fragments.

## Give each locale control

When authoring or reviewing a locale:

- Preserve the semantic IDs, required attributes, and variable contracts.
- Translate meaning and intent, not the source sentence's word order.
- Add, remove, or collapse linguistic variants according to that locale's grammar.
- Use the locale's plural categories; do not copy categories from the source locale.
- Reorder placeables and change surrounding punctuation as natural writing requires.
- Add locale-specific terms or grammatical facets where they improve the translation.
- Keep the default broad enough to work when no specific variant matches.

Do not assume English distinctions are universal. Conversely, do not prevent another locale from adding distinctions English does not need.

## If you know gettext

Use this small mental-model shift:

| gettext habit | Fluent authoring |
|---|---|
| Source text commonly acts as `msgid`. | A stable semantic identifier names the message; text remains editable. |
| Positional placeholders such as `%s` depend on order. | Named placeables such as `{ $user }` state meaning and may be reordered. |
| Plural handling is a special singular/plural form chosen outside the translation. | A generic select expression lets each locale define the variants it needs. |
| Shared source text may need `msgctxt` for disambiguation. | Use distinct purpose-specific IDs and attach context comments directly to entries. |

Do not transliterate a gettext catalog mechanically. Reconsider message boundaries, replace positional fragments with named facts, and let each locale own its grammatical branching.

## Authoring review

Before finalizing an entry, ask:

1. Does the ID describe one durable purpose?
2. Is the entry a complete translatable thought rather than a fragment?
3. Are variable names semantic, raw, typed, and documented?
4. Could a localizer understand the context without inspecting other files?
5. Does every select represent wording rather than behavior?
6. Is the default safe and natural for unmatched values?
7. Could another locale collapse or expand the variants?
8. Are references and terms preserving true vocabulary, not merely avoiding repetition?
9. Are related attributes grouped and unrelated purposes separate?
10. Does the final text read naturally for this locale?
