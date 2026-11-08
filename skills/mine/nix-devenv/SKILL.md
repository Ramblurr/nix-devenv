---
name: nix-devenv
description: Use ramblurr/nix-devenv when creating a project, working in a project that imports it, or changing its devshell, Clojure toolchain, formatting, checks, or dependency-lock setup. Covers Clojure and generic project templates; not devenv.sh.
---

# nix-devenv

`ramblurr/nix-devenv` provides flakelight-based project flakes and reusable numtide/devshell modules called **capsules**. It is not `devenv.sh`; use the project's `flake.nix`, not `devenv.nix` conventions.

## Start with the project

1. **Existing project:** read its instructions, `flake.nix`, and `.envrc`; for Clojure, also read `bb.edn` and `deps.edn`. Identify the nix-devenv input (often named `devenv`), imported capsules, and project commands before changing anything. Preserve project customizations rather than replacing them with a template.
2. **New project:** choose `clojure` for a Clojure starter or `generic` for other languages. Read [project setup](references/project-setup.md) for creation commands, placeholders, and integration details. Finish setup with real project metadata and an environment that starts successfully.
3. **Run inside the project environment:** use direnv or `nix develop --command …`. When the project requires devshell enforcement, follow [nix-devshell-requirement](../nix-devshell-requirement/SKILL.md). A missing tool is a reason to check the environment and declared packages, not install an ad hoc global copy.

## Choose the feature

| Task | Use |
|---|---|
| Add project tools or commands | The project's `pkgs.devshell.mkShell` packages/commands. `capsules.base` is currently empty; it does not supply a general toolchain. |
| Work on Clojure | `capsules.clojure`: Java/Clojure, Babashka, brepl, clojure-lsp, clj-kondo, cljfmt, and delimiter-repair tooling. Use [clojure-eval](../clojure-eval/SKILL.md) for REPL interaction and [clojure-paren-repair](../clojure-paren-repair/SKILL.md) for delimiter errors. |
| Select Java | Set `clojure.jdk` inside the devshell module; it selects the JDK for both Java and Clojure. Default: `pkgs.jdk25`. |
| Configure project-wide formatting | Set `treefmtConfig`; `nix fmt` uses the treefmt wrapper. Choose formatters explicitly. See [formatting and checks](references/project-setup.md#formatting-and-checks). |
| Control automatic build checks | `devenv.autoChecks` controls devshell and system-configuration checks, not package or formatting checks. See the same reference before disabling anything. |
| Build a Clojure artifact or update its dependency lock | Use the project's `clj-helpers` input and locker. Read [Clojure projects](references/clojure-projects.md); these builders belong to `clojure-nix-locker-helpers`, not nix-devenv. |
| Understand a Clojure library or deps.edn setting | Read [clojure-libraries](../clojure-libraries/SKILL.md), then the relevant entry. |

## Verify the change

- Devshell/toolchain changes: enter the affected shell and verify the changed command or Java/Clojure version there.
- Formatting changes: run the configured formatter and formatting check; the presence of treefmt alone does not mean a language formatter is enabled.
- Clojure dependency or alias changes: keep `deps.edn`, `bb.edn`, Nix prep/prefetch aliases, and the Nix test command consistent. Regenerate `deps-lock.json` with `nix run .#locker`, then run the affected tests/build.
- New projects: replace template placeholders, verify required task aliases exist, and run the project's checks before calling setup complete. Templates are starting points, not evidence that every task works in the target environment.

Use the project's validation/resource policy; do not substitute an unbounded full build for a focused check. Report which commands passed and which could not run.
