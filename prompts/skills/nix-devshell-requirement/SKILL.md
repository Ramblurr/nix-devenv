---
name: nix-devshell-requirement
description: Enforces Nix devshell use. Use when the user asks to ensure the agent is in the Nix devshell or AGENTS.md declares a Nix devshell requirement.
---

# Nix Devshell Requirement

## Preflight

Before executing any other command, run exactly:

```bash
test -n "$IN_NIX_SHELL" && echo "IN_NIX_SHELL is set" || echo "IN_NIX_SHELL is NOT set"
```

Proceed only after observing one of those two exact output lines.

## Route commands

If the output is `IN_NIX_SHELL is set`, run project commands normally.

If the output is `IN_NIX_SHELL is NOT set`, route project commands through the project's devshell:

```bash
nix develop --command <command> [args...]
```

Route multiple commands with:

```bash
nix develop --command bash -lc "<command1> && <command2>"
```

Use the selected route for every subsequent project command.

## Guardrails

- Enter `nix develop` only when the preflight reports that `IN_NIX_SHELL` is not set.
- Treat tools outside the devshell as unavailable rather than probing or relying on them.
- If `bb`, `clj`, `clojure`, or another expected project tool is missing, repeat the exact preflight and apply its command route.
- If `nix` is unavailable or the devshell cannot start, stop and report the failure instead of running the project command directly.
