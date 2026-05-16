---
name: garnix
description: Use when working with Garnix CI, Garnix GitHub checks, Nix flake builds, Garnix badges, Garnix Actions, or garnix-cli - explains how Garnix runs flake CI and how to inspect builds and logs.
---

# Garnix CI

Garnix is hosted CI + binary cache for Nix flakes. It installs as a GitHub App,
builds flake outputs, exposes results as GitHub Checks, and pushes build results
to its cache. Most `github.com/ramblurr/*` and `github.com/outskirtslabs/*`
repositories with `flake.nix` are already connected.

No `.github/workflows/*` file is needed for normal Garnix CI.

## Mental model

- Trigger: push or PR to a connected GitHub repository.
- Input: repository `flake.nix`.
- Outputs: packages, checks, dev shells, and other supported flake outputs.
- Status: GitHub Checks API entries on the commit.
- Logs: Garnix build logs, best fetched with `garnix-cli logs <build-id>`.
- Cache: successful outputs are cached by Garnix.
- Config: `garnix.yaml` exists but is rarely needed.

Garnix Actions are separate: flake `apps` can run as CI actions with network and
tools. Use them only when a build/check derivation is not the right shape.

## Basic workflow

1. Push a commit.
2. Watch the commit's Garnix checks.
3. If a build fails, get the failed build ID.
4. Fetch logs by build ID.
5. Fix, commit, push, repeat.

Prefer `garnix-cli` for steps 2-4.

## garnix-cli

First check whether the tool is available:

```bash
command -v garnix-cli
```

If missing, enter the project dev shell. Most active projects already include it
there. If it is still missing, add `garnix-cli` to the dev shell packages for the
project.

Common commands:

```bash
# recent runs for current repo, auto-detected from git origin
garnix-cli list

# recent runs for another repo
garnix-cli list -R owner/repo --limit 5

# filter runs
garnix-cli list -R owner/repo --status failure

# latest run for current repo
garnix-cli view

# latest run for another repo
garnix-cli view -R owner/repo

# specific commit
garnix-cli view <commit-sha>

# watch until terminal; exit non-zero on failure/cancel
garnix-cli watch -R owner/repo --compact --exit-status --interval 10

# fetch logs from failed build ID shown by view/watch
garnix-cli logs <build-id>
```

Machine output:

```bash
garnix-cli --json list -R owner/repo
garnix-cli --edn view -R owner/repo
garnix-cli --plain watch -R owner/repo --compact
```

Private repos: use `GARNIX_API_TOKEN` if needed.

```bash
export GARNIX_API_TOKEN=...
```

## GitHub checks without garnix-cli

Fallback only. Use GitHub's Checks API via `gh` when `garnix-cli` is unavailable:

```bash
gh api repos/OWNER/REPO/commits/SHA/check-runs --jq '.check_runs[] | [.name,.status,.conclusion] | @tsv'
```

This shows check state, but not Garnix build IDs. Prefer `garnix-cli` for logs.

## Badges

Use the shields.io endpoint wrapper. The raw Garnix badge URL returns JSON, not
an SVG, so GitHub renders it as a broken image.

```markdown
[![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2F<owner>%2F<repo>)](https://garnix.io/repo/<owner>/<repo>)
```

Example:

```markdown
[![built with garnix](https://img.shields.io/endpoint.svg?url=https%3A%2F%2Fgarnix.io%2Fapi%2Fbadges%2Foutskirtslabs%2Fgarnix-cli)](https://garnix.io/repo/outskirtslabs/garnix-cli)
```

## Useful links

- Garnix app: https://github.com/apps/garnix-ci
- Install app: https://github.com/apps/garnix-ci/installations/new
- Getting started: https://garnix.io/docs/getting-started/
- Caching: https://garnix.io/docs/ci/caching/
- Badges: https://garnix.io/docs/ci/badges/
- `garnix.yaml`: https://garnix.io/docs/ci/yaml_config/
- Garnix Actions: https://garnix.io/docs/actions/
- GitHub Checks API: https://docs.github.com/en/rest/checks
