# Clojure projects

## Complete the starter

Before treating a generated Clojure project as ready:

- Replace `TODO` name/version fields in `flake.nix` and the project metadata under `[:aliases :neil :project]` in `deps.edn`. Set the URL, description, and license; add the referenced license file.
- Rename starter namespaces/files to the project's names and inspect its starter tests.
- Keep package metadata and tools.build metadata consistent. `build.clj` reads the latter from the `:neil` alias.
- Ensure the build has a Git revision, through `GIT_REV` or Git; `build.clj` requires one. The Nix builder supplies `gitRev` using the helper library.

## Development and tests

Inspect `bb tasks` and the task definitions before choosing a command. Existing projects may differ from the current template.

| Goal | Starter entry point |
|---|---|
| Development REPL | `bb dev`; verify its selected aliases are available before launching. Follow [clojure-eval](../../clojure-eval/SKILL.md) to reuse/start the REPL. |
| Tests | `bb test`, which invokes `clojure -M:dev:test`; `:test` selects Kaocha. `tests.edn` configures its plugins. |
| Formatting | `bb fmt` changes files; `bb fmt:check` checks them with cljfmt. |
| Linting | `bb lint`; `bb lint:copy-configs` imports dependency-provided clj-kondo configuration. |
| Dependency preparation/inspection | `bb prep`, `bb deps-tree`. |
| Combined checks | `bb ci` checks tests, formatting, and lint; `bb qa` formats files before lint/tests. |
| Jar | `bb jar` cleans and calls the tools.build jar function. |

The dev sources configure hashp, clj-reload, and Portal. Read the generated `dev/user.clj` and `dev/dev.clj` before changing startup behavior. Use [clojure-repl-driven-development](../../clojure-repl-driven-development/SKILL.md) for the development loop rather than recreating it here.

`build.clj` also supplies install/deploy functions, and `bb.edn` has a publishing task. Publishing is a separate, explicitly requested operation, not a setup check.

## Nix builds and dependency locks

The template imports `github:outskirtslabs/clojure-nix-locker-helpers` as `clj-helpers`. It supplies `mkCljLib` and other builders; nix-devenv supplies the project environment. Consult that helper's own reference before choosing a different artifact type or builder option.

The template connects these settings:

```nix
prepAliases = [ "dev" "test" ];
prefetchAliases = [ "dev:test" ];
checkCommand = "clojure -Srepro -M:dev:test";
```

`prepAliases` selects preparation aliases; `prefetchAliases` describes alias combinations to prefetch. Keep these aligned with the dependencies needed by the build's actual test command. `-Srepro` makes that command independent of user configuration.

After changing dependencies or selected aliases, run from the consuming project's root:

```sh
nix run .#locker
```

The `locker` package comes from the project's package builder and refreshes `deps-lock.json` using its prep/prefetch/build settings. Review the lock diff and retain it with the dependency change; do not hand-edit hashes. Then run the affected tests and Nix package/check under the project's resource policy.

A successful lock refresh verifies dependency capture, not that tests pass. Report these results separately.
