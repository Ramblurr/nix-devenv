---
name: nixbot
description: Use when working with Nixbot CI, forge commit statuses, Nix flake checks, nixbot.toml, Nixbot effects, or nixbot-cli - explains how Nixbot runs flake CI and how to inspect builds and logs.
---

# Nixbot CI

Nixbot is CI for Nix flakes. It integrates with forges, evaluates flake outputs,
builds through Nix, publishes commit statuses, and exposes a web/API frontend.
Enable repositories with `nixbot-cli enable`; no `.github/workflows/*` file is
needed for normal Nixbot CI.

## Mental model

- Trigger: pull requests, pushes to the default branch, and manual restarts.
- Input: repository `flake.nix`.
- Outputs: `checks` by default, or another configured flake attribute.
- To build packages, NixOS configs, home-manager configs, or similar outputs,
  expose them under `checks`. This nix-devenv flake does that automatically for
  common outputs.
- Status: forge commit statuses on the commit or pull request.
- Logs: Nixbot build logs, best fetched with `nixbot-cli logs <build-number>`.
- Config: optional `nixbot.toml` with `lock_file`, `attribute`, `flake_dir`,
  and effect settings.

Effects are separate from normal builds. Use them only when a pure derivation is
not the right shape, such as controlled deployment steps.

## Basic workflow

1. Push a commit or open/update a pull request.
2. Watch the build with Nixbot.
3. If it fails, inspect the failure summary and logs.
4. Fix, commit, push, repeat.

Prefer `nixbot-cli` for steps 2-3.

## nixbot-cli

Check availability with `command -v nixbot-cli`. If missing, stop and ask the
human operator what to do.

The local config is already set up; do not ask for API tokens unless the command
reports an authentication error. `-R` accepts `[FORGE/]OWNER/REPO`; without it,
the repo is auto-detected from the current git checkout.

Common commands:

```bash
# repositories visible to the configured instance
nixbot-cli repos
# recent builds for current repo or another repo
nixbot-cli builds
nixbot-cli builds -R owner/repo --limit 5
# filter builds
nixbot-cli builds -R owner/repo --status failed
nixbot-cli builds -R owner/repo --branch main
nixbot-cli builds -R owner/repo --pr 123
nixbot-cli builds -R owner/repo --commit <sha-prefix>
# latest build, a specific build, and the queue
nixbot-cli build
nixbot-cli build <number>
nixbot-cli queue
# failed attributes and log tails
nixbot-cli failures
nixbot-cli failures <number> --tail 200
# logs for a build, optionally narrowed to one attribute
nixbot-cli logs <number> --tail 200
nixbot-cli logs <number> <attribute> --tail 200
# watch until terminal; exit non-zero on failure/cancel
nixbot-cli watch --compact --exit-status --interval 10
nixbot-cli watch <number> -R owner/repo --compact --exit-status --interval 10
# find recent builds for an attribute
nixbot-cli attr <attribute> -R owner/repo --limit 10
# retry, stop, enable, or disable
nixbot-cli restart <number>
nixbot-cli cancel <number>
nixbot-cli enable -R owner/repo
nixbot-cli disable -R owner/repo
```

Machine output: add `--json`, `--edn`, `--plain`, or `--format <format>`.

## Forge statuses without nixbot-cli

Fallback only. Use the forge UI or GitHub's statuses API via `gh` when
`nixbot-cli` is unavailable:

```bash
gh api repos/OWNER/REPO/commits/SHA/statuses --jq '.[] | [.context,.state,.description] | @tsv'
```

This shows status state, but not build numbers. Prefer `nixbot-cli` for logs.
