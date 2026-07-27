---
name: clojure-polylith-new-brick
description: >
  Create new Polylith bricks in Clojure workspaces. Use when adding a new
  component, base, or project and when wiring the new brick into workspace
  config before implementation so it is visible to dev and deployable projects.
---

# New Brick Workflow

Use this sequence whenever creating a new component, base, or project:

1. Confirm the brick type, name, and dialect.
2. Read `workspace.edn` for `:top-namespace`, `:interface-ns`, `:dialects`, and `:projects`.
3. Check once whether `poly` is available:

```bash
command -v poly >/dev/null && poly version
```

If `poly` is present, prefer it for this session. `clojure -M:poly ...` is equivalent to
`poly ...` and can be used as the fallback.

Do all workspace wiring immediately after `poly create ...`, before writing real implementation
code. That keeps the new brick visible to the development project, IDE, and target deployable
projects while the change is still fresh.

If `workspace.edn` has `:vcs {:auto-add false}`, generated files may still need `git add`.

## Naming

Choose the name before creating the brick:

- For a component that does one thing, prefer an action-oriented name such as `validator`, `invoicer`, or `purchaser`
- If the component centers on one concept and does several related things, a noun can be appropriate, such as `account` or `car`
- For a component that mainly wraps a third-party API, consider the `-api` suffix, such as `foobarcorp-api`
- For common cloud services, plain service names like `s3`, `dynamodb`, and `cloudwatch` are fine; vendor-grouped names like `aws-s3` can also improve `poly info` and `poly deps` output
- By default, use the same name for the component and its interface
- If two components share one interface and one is mostly a delegating or remote implementation, prefer names like `invoicer` and `invoicer-remote`
- Name bases after what they expose, plus the API type, such as `invoicer-rest-api` or `report-generator-lambda`
- Name deployable projects after the artifact or service they produce, such as `invoicer` or `report-generator`

## Component

Before creating a component, decide whether it introduces a new interface or is another
implementation of an existing interface. The default is a new interface matching the component
name. Use `interface:<name>` only when intentionally implementing an existing interface from a
different component.

Create it:

```bash
poly create component name:{component_name}
```

Possible variants:

```bash
poly create component name:{component_name} dialect:cljs
poly create component name:{component_name} interface:{shared_interface_name}
```

Immediately wire it:

- Add `poly/{component_name} {:local/root "components/{component_name}"}` to `./deps.edn` under `:aliases :dev :extra-deps`
- Add `"components/{component_name}/test"` to `./deps.edn` under `:aliases :test :extra-paths`
- Add the component to each `./projects/*/deps.edn` that should include it
- Run `poly info` and `poly check`

Only after that, implement the component:

- Start from the generated files and generated interface path; do not hard-code the namespace layout from memory
- Keep the interface small and delegate to implementation namespaces
- A component interface is usually one namespace, but it may also be split into sub-namespaces under an `interface/` directory when truly needed
- In `src`, require only other components' interfaces, never their implementation namespaces
- Add third-party library deps to `components/{component_name}/deps.edn`
- Do not add local brick dependencies to the component's own `deps.edn`; those belong in root or project `deps.edn` files via `:local/root`

## Base

Create it:

```bash
poly create base name:{base_name}
```

Possible variant:

```bash
poly create base name:{base_name} dialect:cljs
```

Immediately wire it:

- Add `poly/{base_name} {:local/root "bases/{base_name}"}` to `./deps.edn` under `:aliases :dev :extra-deps`
- Add `"bases/{base_name}/test"` to `./deps.edn` under `:aliases :test :extra-paths`
- Add the base to each `./projects/*/deps.edn` that should include it
- Run `poly info` and `poly check`

Only after that, implement the base:

- Bases have no interface namespace
- Put the entrypoint or external-facing integration in the base and delegate inward to component interfaces
- In `src`, require component interfaces only
- Add third-party library deps to `bases/{base_name}/deps.edn`
- Never add a dependency from a base `deps.edn` to a component; project and development config supply local bricks

## Project

Create it:

```bash
poly create project name:{project_name}
```

Possible variant:

```bash
poly create project name:{project_name} dialect:cljs
```

Immediately wire it:

- Add a project alias to `./workspace.edn` under `:projects`, for example `"{project_name}" {:alias "{short_alias}"}`
- Edit `projects/{project_name}/deps.edn` and add the components and bases it should include via `:local/root`
- Use `../../components/...` and `../../bases/...` paths from project `deps.edn`
- Run `poly info` and `poly check`

Project rules:

- A deployable project selects which bricks are included in an artifact
- A deployable project normally has no `src` directory; production code should live in bricks
- Project-specific `resources` or `test` directories are fine when needed

## Validation Checklist

Before writing implementation code, confirm all of this is already true:

- `poly info` shows the new brick or project
- `poly check` passes
- The root `./deps.edn` includes the new component or base in `:dev` and test paths
- Each relevant deployable project `deps.edn` includes the new brick
- `workspace.edn` has the project alias if a new project was created
- The namespace path matches the generated files and current workspace settings

## Supporting References

- Read `../clojure-polylith/commands.md` for command usage
- Read `../clojure-polylith/patterns.md` for interface and dependency patterns
- Read `../clojure-polylith/conventions.md` for naming conventions
