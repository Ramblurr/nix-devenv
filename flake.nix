{
  inputs = {
    #nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1"; # tracks nixpkgs unstable branch
    nixpkgs.url = "github:ramblurr/nixpkgs/channel/personal-unstable";
    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "flakelight/nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
    clojure-nix-locker.url = "github:bevuta/clojure-nix-locker";
    clojure-nix-locker.inputs.nixpkgs.follows = "nixpkgs";
    fh.url = "https://flakehub.com/f/DeterminateSystems/fh/0.1.*";
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    nix.url = "https://flakehub.com/f/DeterminateSystems/nix-src/*";
    flake-schemas.url = "https://flakehub.com/f/DeterminateSystems/flake-schemas/0.2.0";
  };
  outputs =
    {
      self,
      flakelight,
      treefmt-nix,
      home-manager,
      ...
    }@inputs:
    flakelight ./. (
      { config, lib, ... }:
      let
        mkTemplateFlake =
          templateDir:
          let
            template = import (templateDir + "/flake.nix");
            templateInputs = inputs // {
              self = {
                outPath = templateDir;
              };
              devenv = self;
            };
          in
          template.outputs (templateInputs // { inputs = templateInputs; });

        mkTemplateChecks =
          pkgs:
          let
            system = pkgs.stdenv.hostPlatform.system;
            mkTemplateChecks' =
              name: dir:
              let
                template = mkTemplateFlake dir;
              in
              {
                "template-${name}-devshell" = template.devShells.${system}.default;
              }
              // lib.mapAttrs' (checkName: drv: lib.nameValuePair "template-${name}-${checkName}" drv) (
                template.checks.${system} or { }
              );
          in
          (mkTemplateChecks' "generic" ./templates/generic)
          // (mkTemplateChecks' "clojure" ./templates/clojure);
      in
      {
        inherit inputs;
        imports = [
          flakelight.flakelightModules.extendFlakelight
          ./flakelight-treefmt.nix
        ];
        flakelightModule =
          { lib, ... }:
          {
            imports = [ ./flakelight-treefmt.nix ];
            inputs.treefmt-nix = lib.mkDefault treefmt-nix;
          };
        treefmtConfig = {
          programs = {
            nixfmt.enable = true;
            mdformat.plugins =
              ps: with ps; [
                mdformat-gfm
                mdformat-gfm-alerts
              ];
          };
        };
        withOverlays = [
          self.overlays.default
        ];
        #homeConfigurations = import ./home-modules/default.nix;
        packages = {
          brepl = pkgs: pkgs.callPackage (import ./pkgs/brepl.nix) { };
          #catnipContainer = pkgs: (import ./pkgs/catnip-container.nix) { inherit self inputs pkgs; };
          clojure-mcp-light = pkgs: pkgs.callPackage (import ./pkgs/clojure-mcp-light.nix) { };
          deps-lock = pkgs: inputs.clojure-nix-locker.packages.${pkgs.stdenv.hostPlatform.system}.default;
          ramblurr-global-deps-edn = pkgs: pkgs.callPackage (import ./pkgs/deps-edn.nix) { };
        };
        devShell = pkgs: {
          packages = [
            pkgs.deps-lock
          ];
        };
        checks = mkTemplateChecks;
        templates = import ./templates;
        outputs = {
          capsules = import ./capsules;
          clojure = import ./lib/clojure.nix { inherit inputs; };
          # disable schemas for now, this breaks flakehub
          #schemas = inputs.flake-schemas.schemas // {
          #  capsules = {
          #    version = 1;
          #    doc = ''
          #      The `capsules` flake output contains common devshell modules specified via numtide/devshell.
          #    '';
          #    inventory = inputs.flake-schemas.lib.derivationsInventory "Devshell Capsules" false;
          #  };
          #};
        };
        flakelight.builtinFormatters = false;
      }
    );
}
