---
name: local-git-reference
description: Use when looking up project docs, source, examples, specs, or upstream context, and extra/ does not contain what you need. Check ~/src first, clone relevant repos with ghq, and prefer local inspection/search over remote browsing.
---

# Local Git Reference

`~/src` is the human (and your) personal library of useful git repositories.

Use it for any git repo that may contain information relevant to the task, not just code repositories. That includes docs repos, examples, specs, infra repos, deployment repos, and companion repos related to a project.

Be proactive. If a project, tool, library, or service seems relevant, look for likely repos and clone them into `~/src` so you can inspect and search them locally.

Related skills: extra-reference-material for material in extra/

## Core workflow

1. Look in `~/src` for a relevant repo first.
2. If a likely useful repo is missing, clone it with `ghq clone`.
3. Prefer reading and searching local files over browsing remote sites when practical.
4. If currentness matters and the clone may be stale, run `git pull` inside the repo before relying on it.

The docs repo may be different from the main code repo. If a docs site or project appears relevant, proactively look for related git repos and clone them too.

## Standard commands

Clone a repo into `~/src`:

```bash
ghq clone https://github.com/owner/repo.git
```

Clone a likely companion repo too when useful:

```bash
ghq clone https://github.com/owner/project-docs.git
```

Refresh a local clone when freshness matters:

```bash
cd ~/src/github.com/owner/repo && git pull --ff-only
```

## Search helpers

Use the bundled scripts to search `~/src` without dumping unbounded output into context.

- `scripts/find-repos.sh`: find candidate repositories by path or repo name
- `scripts/search-src.sh`: search file contents under `~/src`

Both scripts:
- enforce a maximum number of displayed lines by default
- report how many matches were found in total
- report when output is truncated
- print full paths

Examples:

```bash
scripts/find-repos.sh caddy
```

```bash
scripts/search-src.sh 'reverse_proxy'
```

Increase the display cap deliberately when needed:

```bash
scripts/search-src.sh --max-results 80 'tls internal'
```

## What to inspect inside a local repo

Prioritize the files most likely to answer the question:
- `README*`
- `docs/`
- `examples/`
- tests
- configuration files
- source files implementing the relevant feature

Use local repo contents as primary reference material whenever practical.

## Decision rule

Err on cloning a relevant remote repo if it is not already present in `~/src`. Local searchable checkouts are often faster and more useful than repeated remote browsing.
