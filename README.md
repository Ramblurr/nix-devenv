# nix-devenv

Reusable Nix Flake [devshells] for my frequently used toolchains.

This flake also exposes it self as [a flakelight module][flakelight]. It extends your flakelight project to replace the builtin formatter with one powered by treefmt-nix.

## Devshell Capsules

I ship my devshells as "capsules" which are snippets of [numtide/devshell][devshell] configuration.

Available capsules:

| Capsule   |
|-----------|
| `clojure` |

<details>
<summary><b>Here is a minimal flake using the flakelight functionality and my clojure devshell capsule.</b></summary>

``` nix
{
  description = "my dev env";
  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # tracks nixpkgs unstable branch
    devshell.url = "github:numtide/devshell";
    devenv.url = "https://flakehub.com/f/ramblurr/nix-devenv/*";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    {
      self,
      flakelight,
      devenv,
      devshell,
      ...
    }:
    devenv.lib.mkFlake ./. {
      # inside here we are flakelight
      # refer to https://github.com/nix-community/flakelight/blob/master/API_GUIDE.md
      # for all attrs and functions
      withOverlays = [
        devshell.overlays.default
        devenv.overlays.default
      ];
      devShell =
        pkgs:
        pkgs.devshell.mkShell {
          # https://numtide.github.io/devshell
          imports = [
            devenv.capsules.clojure
          ];
          commands = [
            { package = pkgs.cowsay; }
          ];
          packages = [ ];
        };
    };
}
```
</details>

## Clojure package builders

The `devenv.clojure` output re-exports the library from
[clojure-nix-locker-helpers]: clj-nix style builders (`mkCljBin`, `mkCljLib`,
`mkCljApp`, `customJdk`, `mkGraalBin`, `mkCljCli`) powered by
[clojure-nix-locker], plus the low-level `mkLockfile` / `mkLocker` escape
hatches and the `cleanCljSource` / `gitRev` utilities.

```nix
packages = {
  default = pkgs: devenv.clojure.mkCljLib {
    inherit pkgs;
    name = "my-lib";
    version = "0.1.0";
    src = ./.;
    prepAliases = [ "dev" "kaocha" ];
    prefetchAliases = [ "dev:kaocha" ];
    checkCommand = "clojure -Srepro -M:dev:kaocha";
    gitRev = devenv.clojure.gitRev self;
  };
  locker = pkgs: self.packages.${pkgs.system}.default.locker;
};
```

Run `nix run .#locker` to (re)generate `deps-lock.json`. See the
[clojure-nix-locker-helpers] docs for the full API.

## Automatic checks

`devenv.lib.mkFlake` exposes buildable environment outputs as flake checks so CI can build them with `nix flake check`:

- `devShells.${system}.${name}` becomes `checks.${system}.devShells-${name}`.
- Flakelight's NixOS and home-manager checks remain enabled as `checks.${system}.nixos-${name}` and `checks.${system}.home-${name}`.

Opt out per output:

```nix
{
  devenv.autoChecks.devShells = false;
  devenv.autoChecks.nixosConfigurations = false;
  devenv.autoChecks.homeConfigurations = false;
}
```

Or disable all nix-devenv automatic checks for these outputs:

```nix
{
  devenv.autoChecks.enable = false;
}
```

This does not disable package or formatting checks.

## Templates

Use `nix flake new` to create new projects.

| Template  | Description                                                                      |
|-----------|----------------------------------------------------------------------------------|
| `clojure` | A minimal clojure application template with a deps.edn, bb.edn and kaocha setup. |
| `generic` | A minimal generic nix flake template.                                            |

Example:

```bash
nix flake new my-project -t "github:ramblurr/nix-devenv#clojure"
```

[devshell]: https://github.com/numtide/devshell
[flakelight]: https://github.com/nix-community/flakelight
[clojure-nix-locker-helpers]: https://github.com/outskirtslabs/clojure-nix-locker-helpers
[clojure-nix-locker]: https://github.com/bevuta/clojure-nix-locker
