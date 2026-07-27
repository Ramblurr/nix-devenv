# Fluent syntax reference

Use this as a compact authoring reference for Fluent Translation List (FTL) resources.

## Resource entries and identifiers

A resource is a sequence of messages, terms, and comments separated by optional blank lines.

```ftl
save-button = Save

-brand-name = Waterfox

login-input =
    .placeholder = name@example.com
    .aria-label = Email address
```

- A message is `identifier = pattern`, optionally followed by attributes.
- A message may omit its main value when it has at least one attribute.
- A term is `-identifier = pattern`, optionally followed by attributes. A term must have a value.
- Identifiers start with an ASCII letter. Remaining characters may be ASCII letters, digits, `_`, or `-`: `[A-Za-z][A-Za-z0-9_-]*`.
- The leading `-` marks a term and is not part of its identifier. `$` similarly marks a variable reference.
- Identifiers and variant keys are case-sensitive. Prefer lowercase kebab-case for authored names.
- Give each message and term a stable, unique, semantic identifier.

## Patterns and multiline text

A pattern is the text value of a message, term, attribute, or variant. Ordinary text is unquoted and may contain Unicode directly.

```ftl
single-line = Save changes

multiline =
    Your changes could not be saved.
    Check your connection and try again.

preserved-break = First paragraph.

    Second paragraph.
```

- Indent every continuation line by at least one U+0020 space. Tabs are text, not indentation.
- Leading and trailing blank lines and spaces are ignored in ordinary patterns.
- Blank lines inside a multiline pattern are preserved when text appears before and after them.
- Fluent removes the indentation common to all indented lines; extra indentation remains in the value.
- If text begins on the identifier line, that first line does not participate in common-indent removal.
- Use LF or CRLF line endings and UTF-8 text.

## Placeables and expressions

Curly braces delimit a placeable: `{ expression }`. Placeables insert or select values inside patterns.

| Purpose | Syntax |
|---|---|
| Variable | `{ $user-name }` |
| Message value | `{ save-button }` |
| Message attribute | `{ login-input.placeholder }` |
| Term | `{ -brand-name }` |
| Parameterized term | `{ -product(case: "locative") }` |
| Function result | `{ NUMBER($count, minimumFractionDigits: 2) }` |
| String literal | `{ "literal" }` |
| Number literal | `{ -12.5 }` |

Variables carry named data into a message:

```ftl
# $title (String) - The title of the bookmark being removed.
remove-bookmark = Remove “{ $title }”?
```

Use semantic variable names such as `$email-count`, not positional names such as `$arg1`. Keep punctuation and surrounding grammar in the pattern so a locale can reorder or reshape the sentence.

Message references cannot receive parameters. Terms may receive named parameters. A term attribute may select a variant, but may not be inserted directly as a placeable.

## Select expressions and variants

A select expression chooses one variant. `*` marks the required default variant.

```ftl
unread-emails =
    { $count ->
        [0] You have no unread emails.
        [one] You have one unread email.
       *[other] You have { $count } unread emails.
    }
```

- Every select must contain exactly one default variant.
- Variant keys are identifiers such as `[one]` or number literals such as `[0]` and `[-1]`.
- String selectors compare directly with identifier keys.
- Number selectors can match an exact numeric key or the number's locale-specific cardinal plural category: `zero`, `one`, `two`, `few`, `many`, or `other`.
- A locale should define only the categories its wording needs. Do not copy another locale's variant structure mechanically.
- A selector may be a variable, function call, string literal, number literal, or term attribute. A plain message or term reference is not a valid selector.
- Variants may contain full multiline patterns, attributes are not allowed inside a variant.

When selection depends on specially formatted numbers, use the same formatting expression for selection and display:

```ftl
score =
    { NUMBER($points, minimumFractionDigits: 1) ->
        [0.0] You scored zero points.
       *[other] You scored { NUMBER($points, minimumFractionDigits: 1) } points.
    }
```

For ordinal categories, select with ordinal number formatting:

```ftl
finish-position =
    { NUMBER($position, type: "ordinal") ->
        [one] You finished { $position }st.
        [two] You finished { $position }nd.
        [few] You finished { $position }rd.
       *[other] You finished { $position }th.
    }
```

## Terms and grammatical facets

Terms define controlled vocabulary that other entries may reference. Use them for names and glossary items whose identity must stay consistent, not for arbitrary sentence fragments.

```ftl
-brand-name = Firefox
about = About { -brand-name }
```

Parameterized terms expose language-specific forms:

```ftl
-brand-name =
    { $case ->
       *[nominative] Aurora
        [locative] Aurorze
    }

about = Informacje o { -brand-name(case: "locative") }.
```

If a parameter is omitted, the term's default variant applies. Use named parameters with string or number literal values.

Term attributes hold grammatical properties for use as selectors:

```ftl
-brand-name = Aurora
    .gender = feminine

updated =
    { -brand-name.gender ->
        [feminine] { -brand-name } została zaktualizowana.
       *[other] { -brand-name } został zaktualizowany.
    }
```

Term attributes are selector metadata. Do not interpolate `{ -brand-name.gender }` as visible text.

## Message attributes

Attributes group strings that belong to one conceptual UI unit:

```ftl
search-input =
    .placeholder = Search the catalog
    .aria-label = Catalog search
    .title = Enter an author, title, or ISBN
```

A message may have both a value and attributes:

```ftl
remove-dialog = Remove this item?
    .confirm = Remove
    .cancel = Keep item
```

Attribute names follow the same identifier grammar. Indent attributes for readability, even though the grammar only requires them to begin on a new line.

## Comments

```ftl
### File-level context

## Group-level context

# Message-specific context. With no blank line, this comment belongs to the entry.
message-id = Message
```

- `#` is a message or term comment when placed immediately above the entry with no blank line. It may also stand alone.
- `##` is a standalone group comment and applies until the next group comment or end of file.
- `###` is a standalone resource comment for the whole file.
- Adjacent comment lines with the same number of hashes form one comment.

Comments should explain purpose, UI context, variable types and meanings, constraints, and intentional wording. Do not merely paraphrase the source text.

## Functions and formatting

Function names use uppercase ASCII letters, digits, `_`, or `-`, beginning with an uppercase letter. Calls appear only inside placeables.

```ftl
ratio = Scale: { NUMBER($ratio, maximumFractionDigits: 2) }
date = Updated { DATETIME($updated-at, month: "long", day: "numeric", year: "numeric") }
```

- Plain numeric and date variables use their default locale-sensitive formatting.
- `NUMBER` controls number formatting. Common named options include integer, fraction, and significant-digit limits, grouping, ordinal type, and currency display.
- `DATETIME` controls date and time formatting. Common named options include weekday, era, year, month, day, hour, minute, second, time-zone name, and 12-hour display.
- Positional arguments must precede named arguments.
- Named argument names must be unique, and their values must be quoted string or number literals.
- Follow existing resource conventions for formatting options; add explicit options only when the message needs them.

## Special characters and quoted literals

Ordinary text needs no quotes. Quoted literals are single-line expressions used inside placeables when syntax characters or invisible whitespace must be represented.

```ftl
opening-brace = A literal opening brace: { "{" }
closing-brace = A literal closing brace: { "}" }
leading-space = { "    " }Indented on purpose
nonbreaking-space = Privacy{ "\u00A0" }Policy
```

Supported escapes inside quoted literals are:

| Escape | Meaning |
|---|---|
| `\"` | Double quote |
| `\\` | Backslash |
| `\uHHHH` | Four-hex-digit Unicode code point |
| `\UHHHHHH` | Six-hex-digit Unicode code point |

- `{` and `}` are syntax in ordinary patterns; insert literal braces through quoted literals.
- Backslash is ordinary text outside quoted literals and does not escape braces.
- A continuation line cannot begin with `.`, `*`, or `[`. Insert such a leading character with a quoted literal, for example `{ "[" }`.
- Prefer the actual Unicode character over an escape unless the character is invisible or the escape clarifies intent.
- Avoid control and permanently undefined Unicode code points.

## Compact structural summary

```text
message      := identifier "=" (pattern attributes* | attributes+)
term         := "-" identifier "=" pattern attributes*
attribute    := newline spaces? "." identifier "=" pattern
placeable    := "{" (inline-expression | select-expression) "}"
select       := selector "->" variants
variant      := newline spaces? "*"? "[" (identifier | number) "]" pattern
identifier   := ASCII-letter (ASCII-letter | digit | "_" | "-")*
```

This summary is an authoring aid, not a replacement for the full grammar. In particular, syntax can be structurally well-formed yet invalid, such as parameterizing a message reference or interpolating a term attribute.
