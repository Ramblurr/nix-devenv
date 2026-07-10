# Fluent authoring examples

These examples emphasize complete messages, explicit context, and locale-owned grammar.

## 1. Purpose-specific messages

The same English word can represent different purposes and require different translations:

```ftl
file-menu-open = Open
file-state-open = Open
store-hours-open = Open
```

Do not merge these into a generic `open` message. Their IDs preserve the context that the visible English text omits.

## 2. Variables with context

```ftl
# Confirmation shown before removing a saved bookmark.
# $title (String) - The bookmark's user-visible title.
bookmark-remove-confirm = Remove “{ $title }” from your bookmarks?
```

The variable contains a raw title, not text such as “the bookmark named …”. Quotation, word order, and grammar remain under the locale's control.

## 3. Cardinal plurals

```ftl
# $count (Number) - The number of files ready to upload.
files-ready =
    { $count ->
        [one] One file is ready to upload.
       *[other] { $count } files are ready to upload.
    }
```

Another locale may replace these keys with `one`, `few`, `many`, and `other`, or use only `other` if one form covers all values.

## 4. Exact numbers plus plural categories

Use an exact key when it is simply better wording for the same message purpose:

```ftl
# $count (Number) - The number of unread messages.
unread-message-count =
    { $count ->
        [0] No unread messages.
        [one] One unread message.
       *[other] { $count } unread messages.
    }
```

Keep the default valid for zero even if `[0]` is absent in another locale. “0 unread messages” may be less elegant, but it still reports the same status.

## 5. Grammatical selection with a broad default

```ftl
# $author (String) - The profile author's display name.
# $author-gender (String) - Grammatical gender for pronoun agreement.
profile-updated =
    { $author } updated { $author-gender ->
        [masculine] his
        [feminine] her
       *[other] their
    } profile.
```

The default remains usable for an unknown value. A language without this distinction can write a single default variant or remove the select entirely.

## 6. Formal and informal style

```ftl
# $user (String) - The signed-in person's display name.
# $formality (String) - The requested register for addressing the user.
welcome-user =
    { $formality ->
        [formal] Welcome, { $user }.
       *[informal] Hi, { $user }!
    }
```

Use this only when both variants serve the same purpose. The default must remain acceptable when the selector is missing or unfamiliar.

## 7. Controlled vocabulary with terms

```ftl
-brand-name = Nightly

about-brand = About { -brand-name }
brand-update-ready = An update for { -brand-name } is ready.
```

The term has one stable identity. Do not use terms for generic words such as “update” merely because they repeat.

## 8. Parameterized terms for grammatical case

A locale can define the forms it needs without changing another locale's resource:

```ftl
-brand-name =
    { $case ->
       *[nominative] Aurora
        [locative] Aurorze
    }

about-brand-pl = Informacje o { -brand-name(case: "locative") }.
brand-ready-pl = { -brand-name } jest gotowa.
```

Omitting `case` selects the default nominative form.

## 9. Term attributes as grammatical metadata

```ftl
-brand-name = Aurora
    .gender = feminine

brand-updated-pl =
    { -brand-name.gender ->
        [feminine] { -brand-name } została zaktualizowana.
       *[other] { -brand-name } został zaktualizowany.
    }
```

The `.gender` attribute selects wording. It is not itself user-visible text.

## 10. Compound messages with attributes

Use attributes for related text belonging to one conceptual UI unit:

```ftl
password-input =
    .label = Password
    .placeholder = Enter your password
    .aria-label = Account password
    .show = Show password
    .hide = Hide password
```

A message may also have a main value:

```ftl
session-expired-dialog = Your session has expired. Sign in again to continue.
    .title = Session expired
    .confirm = Sign in
    .cancel = Close
```

Do not group nearby but independent controls merely because they share a screen.

## 11. Multiline prose

```ftl
recovery-explanation =
    Recovery codes let you sign in when you cannot use your usual
    authentication method. Store each code somewhere safe.

    Each code can be used only once.
```

The internal blank line is preserved. Common indentation is removed.

## 12. Numbers, dates, and consistent selection

```ftl
# $total (Number) - The total price in the configured currency.
order-total = Total: { NUMBER($total, minimumFractionDigits: 2) }

# $created-at (Date) - When the account was created.
account-created = Created { DATETIME($created-at, month: "long", day: "numeric", year: "numeric") }

# $score (Number) - A score shown with one fractional digit.
score-result =
    { NUMBER($score, minimumFractionDigits: 1) ->
        [0.0] You scored zero points.
       *[other] You scored { NUMBER($score, minimumFractionDigits: 1) } points.
    }
```

When formatting affects plural selection, repeat the same `NUMBER` expression in the selected text.

## 13. Message references, used narrowly

```ftl
menu-save = Save
help-save = Choose { menu-save } to save the document.
```

Use a message reference only when both appearances intentionally share one translation. If “Save” has different roles or grammatical surroundings, repeat the full text or use purpose-specific messages.

## 14. Literal syntax characters and invisible space

```ftl
brace-help = Enter a value between { "{" } and { "}" }.
privacy-label = Privacy{ "\u00A0" }Policy
leading-bracket =
    The next line begins with a bracket:
    { "[" }example]
```

Prefer visible Unicode directly. The non-breaking-space escape is useful because an ordinary and non-breaking space look alike in many editors.

## 15. Avoid translated fragments

This is syntactically valid but poorly localizable:

```ftl
# Avoid: $reaction is expected to be a translated fragment.
fragment-reaction = { $user } reacted with { $reaction }.
fragment-thumb = a thumbs up
fragment-smile = a smile
```

Write complete messages instead:

```ftl
# $user (String) - The person who reacted.
reaction-thumb = { $user } reacted with a thumbs up.

# $user (String) - The person who reacted.
reaction-smile = { $user } reacted with a smile.
```

## 16. Keep application actions out of variants

This select is syntactically valid but unsafe because its default chooses an action:

```ftl
# Avoid: fallback wording could describe the wrong destructive action.
unsafe-item-action =
    Are you sure you want to { $action ->
       *[archive] archive
        [delete] permanently delete
    } this item?
```

Define separate messages:

```ftl
item-archive-confirm = Archive this item?
item-delete-confirm = Permanently delete this item?
```

The application requires both actions to exist. A locale must not be free to collapse them as if they were grammatical variants.

## 17. Keep instructions separate from status

Avoid mixing different purposes in an exact-number variant:

```ftl
# Avoid: [0] instructs; the other variants report selection status.
mixed-selection =
    { $count ->
        [0] Select at least one item.
        [one] One item selected.
       *[other] { $count } items selected.
    }
```

Separate them:

```ftl
selection-prompt = Select at least one item.
selection-status =
    { $count ->
        [one] One item selected.
       *[other] { $count } items selected.
    }
```

## 18. A cohesive resource excerpt

```ftl
### Sharing and collaboration

## Invitations

# Title of the dialog for inviting a person to a workspace.
invite-dialog = Invite a teammate
    .email-label = Email address
    .email-placeholder = name@example.com
    .confirm = Send invitation
    .cancel = Cancel

# Status shown after an invitation is sent.
# $recipient (String) - The email address or display name of the invited person.
invite-sent = Invitation sent to { $recipient }.

# $count (Number) - The number of invitations still awaiting a response.
pending-invitations =
    { $count ->
        [0] No pending invitations.
        [one] One pending invitation.
       *[other] { $count } pending invitations.
    }

invitation-revoke-confirm = Revoke this invitation?
invitation-resend-confirm = Send this invitation again?
```

This resource uses a group comment, message context, typed variables, attributes for one dialog, a linguistic number select, and separate IDs for distinct actions.

## Common syntax traps

| Avoid | Write instead | Reason |
|---|---|---|
| `1-message = Text` | `message-1 = Text` | Identifiers must begin with an ASCII letter. |
| `message = A { brace` | `message = A { "{" } brace` | Ordinary braces delimit placeables. |
| A tab-indented continuation | A space-indented continuation | Tabs are pattern text, not syntax indentation. |
| A select without `*` | Mark one variant, usually `*[other]` | Every select requires one default. |
| `{ message(param: "x") }` | Use a variable or a parameterized term | Message references cannot take parameters. |
| `{ -term.attribute }` | Use `-term.attribute` as a selector | Term attributes are grammatical metadata, not placeable text. |
| A positional argument after a named one | Put all positional arguments first | Positional arguments cannot follow named arguments. |
