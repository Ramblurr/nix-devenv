---
name: scoped-commits
description: Write git commit messages in the Scoped Commits format for this project. Use whenever creating a commit, drafting a commit message, or writing a PR title. This REPLACES Conventional Commits.
---

# Scoped Commits

Scoped Commits is a loose standard for making commit logs quickly understandable to contributors.

Normal commit messages use this format:

```text
<scope>: <description>

[optional body]

[optional trailer(s)]
```

Rules:

- `<scope>` is the subsystem, area, module, package, or page the commit touches.
- Put the scope first because it is the most important part for scanning history.
- `<description>` is a short description of the change.
- The body is optional and gives detailed context when needed.
- Trailers are optional metadata lines.
- Prefer one line messages, add a body only when the change needs a *why*.
- Do not use Conventional Commits types like `feat:`, `fix:`, `chore:`, `style:`, or `refactor:`.
- Use the same scoped format for PR titles.

Special commits:

- Reverts, merges, and other special commits may use their normal Git formats.
- A project may define extra rules for valid scopes, descriptions, bodies, trailers, or special commits.

Multiple scopes:

- Prefer a broader scope that covers all touched areas.
- Or list both scopes separated by a comma.
- For tree-wide commits, use a scope such as `treewide`, `all`, or `global`.
- If no scope fits, treat it as a special commit and write a clear description.

Ticket numbers:

- Put ticket numbers at the end of the description
- Common options are after the scope, in the body, or as a trailer.

Examples:

```text
auth: fix login bug #123
ci: update macOS image
net/http/cookiejar: add godoc links
xwayland: 24.1.11 -> 24.1.12
members/detail/profile: redesign profile section
i2c: virtio: mark device ready before registering the adapter
```
