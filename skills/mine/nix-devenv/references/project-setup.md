# Project setup

## Create from a template

Run in the parent directory; choose one:

```sh
nix flake new my-project -t github:ramblurr/nix-devenv#generic
nix flake new my-project -t github:ramblurr/nix-devenv#clojure
```

Read the generated files before running `direnv allow` in the project. Alternatively, use `nix develop`. Both templates use `use flake` in `.envrc`; the generic template also loads dotenv. Keep credentials out of Git.

For Clojure, continue with [Clojure projects](clojure-projects.md). For another language, add its packages and commands to the generic devshell. The base capsule is an empty extension point.

## Integrate with an existing flake

Use this shape only when the project needs integration; keep its existing nixpkgs pin and custom outputs. The input name `devenv` is conventional, not required.

```nix
{
  inputs = {
    nixpkgs.url = "github:ramblurr/nixpkgs/channel/personal-unstable";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:ramblurr/nix-devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ devenv, devshell, ... }:
    devenv.lib.mkFlake ./. {
      inherit inputs;
      withOverlays = [ devshell.overlays.default devenv.overlays.default ];
      devShell = pkgs: pkgs.devshell.mkShell {
        imports = [ devenv.capsules.clojure ];
        # Optional: clojure.jdk = pkgs.jdk27;
        packages = [ ];
        commands = [ ];
      };
    };
}
```

For non-Clojure projects, omit the Clojure capsule or replace it with `devenv.capsules.base`. The devshell overlay supplies `mkShell`; the nix-devenv overlay supplies its packaged tools.

`devenv.lib.mkFlake` extends flakelight with nix-devenv's default module and automatic-check handling. A default `flakelightModules` export also exists for module composition; prefer the wrapper above for its documented behavior, including check opt-outs.

## Formatting and checks

Configure `treefmtConfig` at the `mkFlake` module level, not inside `pkgs.devshell.mkShell`. For example:

```nix
treefmtConfig.programs.nixfmt.enable = true;
```

The integration supplies:

- A treefmt-backed `formatter`, invoked with `nix fmt`.
- `checks.<system>.formatting` for the project source.
- The wrapper and selected formatter programs in the devshell by default. Control inclusion with `treefmtWrapperInDevShell` and `treefmtProgramsInDevShell`.

The formatter selections in nix-devenv's own flake are not a promise that consuming projects inherit those selections. Inspect the consumer's configuration.

Automatic checks expose devshells as `devShells-<name>` and retain flakelight's system-configuration checks. At the `mkFlake` module level:

```nix
devenv.autoChecks = {
  enable = true;
  devShells = true;
  nixosConfigurations = true;
  homeConfigurations = true;
};
```

All default to true. Set a category false to omit its automatic checks, or `enable = false` to disable the group. Package and formatting checks remain. Follow the project's resource policy when choosing which checks to build.

## Source pointers

For behavior not covered here, inspect the project's pinned nix-devenv revision, especially `capsules/`, `flakelight-treefmt.nix`, `flakelight-auto-checks.nix`, and `templates/`. Use the local checkout through [local-git-reference](../../local-git-reference/SKILL.md); avoid assuming today's template matches an older project pin.
