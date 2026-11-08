{
  description = "dev env";
  inputs = {
    nixpkgs.url = "github:ramblurr/nixpkgs/channel/personal-unstable";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    devenv.url = "github:ramblurr/nix-devenv";
    devenv.inputs.nixpkgs.follows = "nixpkgs";
    clj-helpers.url = "github:outskirtslabs/clojure-nix-locker-helpers";
    clj-helpers.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      devenv,
      devshell,
      clj-helpers,
      ...
    }:
    let
      package =
        pkgs:
        clj-helpers.lib.mkCljLib {
          inherit pkgs;
          name = "TODO";
          version = "0.0.TODO";
          src = ./.;
          prepAliases = [
            "dev"
            "test"
          ];
          prefetchAliases = [ "dev:test" ];
          checkCommand = "clojure -Srepro -M:dev:test";
          gitRev = clj-helpers.lib.gitRev self;
        };
    in
    devenv.lib.mkFlake ./. {
      inherit inputs;
      withOverlays = [
        devshell.overlays.default
        devenv.overlays.default
      ];
      packages = {
        default = package;
        # regenerates ./deps-lock.json: `nix run .#locker`
        locker = pkgs: (package pkgs).locker;
      };
      devShell =
        pkgs:
        pkgs.devshell.mkShell {
          imports = [
            devenv.capsules.base
            devenv.capsules.clojure
          ];
          # Optional: use a different JDK for both Java and Clojure in this shell.
          # clojure.jdk = pkgs.jdk27;

          # https://numtide.github.io/devshell
          commands = [
            # { package = pkgs.bazqux; }
          ];
          packages = [
            (
              if self ? packages then
                self.packages.${pkgs.system}.locker
              else
                clj-helpers.packages.${pkgs.system}.deps-lock
            )
            # pkgs.foobar
          ];
        };
    };
}
