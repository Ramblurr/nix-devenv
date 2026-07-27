---
description: Polylith poly CLI command reference for workspace inspection, validation, and brick creation
---

# Polylith CLI Commands

When starting work in a Polylith workspace, check once whether the standalone `poly`
CLI is available:

```bash
command -v poly >/dev/null && poly version
```

If `poly` is present, prefer it for all Polylith commands in this session. If it is
not present, use the Clojure alias form instead, typically `clojure -M:poly`.
These forms are equivalent command-for-command: `clojure -M:poly info` is equivalent
to `poly info`, `clojure -M:poly check` is equivalent to `poly check`, and so on.

Many projects also wrap these in Babashka tasks (`bb check`, `bb info`) — check
`bb.edn` if present.

## Workspace Inspection

```bash
# Summarize workspace: bricks, projects, changed/stable state
poly info

# Full workspace data as EDN
poly ws

# Show library dependencies
poly libs

# Show what changed since last stable point (git tag)
poly diff
```

## Validation

```bash
# Validate workspace structure and dependency rules
poly check
```

Run `check` after any structural change. It catches:
- Components depending on other components' implementation namespaces
- Missing interface namespaces
- Circular dependencies
- Misconfigured projects

## Creating Bricks

```bash
# Create a new component
poly create component name:my-component

# Create a new base
poly create base name:my-base

# Create a new project
poly create project name:my-project
```

After creating a component:
1. Implement `src/<top-ns>/my-component/interface.cljc` — the public surface
2. Add implementation in `src/<top-ns>/my-component/core.cljc`
3. Write tests in `test/<top-ns>/my-component/interface_test.cljc`
4. Add the component to relevant project `deps.edn` files

## Running Tests

```bash
# Run tests for changed bricks only
poly test

# Run tests for a specific project
poly test project:my-project

# Run all tests regardless of change detection
poly test :all
```

## Repo Tasks

If the repo provides Babashka tasks, prefer them over ad hoc `clojure -M:...` test aliases:

```bash
# Run targeted verification using the repo's supported wrapper
bb test

# Run full verification when available
bb qa
```

## Stable Points

Polylith uses git tags to track "stable" commits. Tests only run for bricks
that changed since the last stable point.

```bash
# Mark current HEAD as stable
git tag -f stable-$(git rev-parse --short HEAD)
```
