{
  inputs = {
    nixpkgs.url = "github:ramblurr/nixpkgs/channel/personal-unstable";
    flakelight.url = "github:nix-community/flakelight";
    flakelight.inputs.nixpkgs.follows = "nixpkgs";
    treefmt-nix.url = "github:numtide/treefmt-nix";
    treefmt-nix.inputs.nixpkgs.follows = "flakelight/nixpkgs";
    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";
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
      {
        config,
        lib,
        outputs,
        ...
      }:
      let
        # Evaluate a template flake for checks. Inputs this flake also has
        # (nixpkgs, devshell, ...) are taken from it, and `devenv` is the
        # local checkout, so templates are checked against this revision.
        # Template-only inputs are resolved from the template's own
        # flake.lock via fetchTree (pure: the lock carries rev + narHash).
        mkTemplateFlake =
          templateDir:
          let
            template = import (templateDir + "/flake.nix");
            templateLock = builtins.fromJSON (builtins.readFile (templateDir + "/flake.lock"));

            # A lock node reference is either a node name or a `follows` path
            # walked from the root node
            nodeFor = ref: if builtins.isString ref then ref else followPath templateLock.root ref;
            followPath =
              start: path:
              builtins.foldl' (cur: attr: nodeFor templateLock.nodes.${cur}.inputs.${attr}) start path;

            resolveDep =
              name: nodeName: if name == "devenv" then self else inputs.${name} or (callLockedNode nodeName);

            callLockedNode =
              nodeName:
              let
                node = templateLock.nodes.${nodeName};
                src = builtins.fetchTree node.locked;
                flake = import (src + "/flake.nix");
                deps = builtins.mapAttrs (name: ref: resolveDep name (nodeFor ref)) (node.inputs or { });
                outputs = flake.outputs (deps // { self = result; });
                result = outputs // {
                  outPath = src;
                };
              in
              result;

            rootInputs = templateLock.nodes.${templateLock.root}.inputs or { };
            templateInputs = (builtins.mapAttrs (name: ref: resolveDep name (nodeFor ref)) rootInputs) // {
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

        removeAutoCheckOutputs =
          outputs:
          let
            cfg =
              outputs.__devenvAutoChecks or {
                enable = true;
                devShells = true;
                nixosConfigurations = true;
                homeConfigurations = true;
              };
            enabled = output: (cfg.enable or true) && (cfg.${output} or true);
            namesFor =
              system:
              lib.optionals (!(enabled "devShells")) (
                map (name: "devShells-${name}") (builtins.attrNames (outputs.devShells.${system} or { }))
              )
              ++ lib.optionals (!(enabled "nixosConfigurations")) (
                lib.concatMap (name: [
                  "nixos-${name}"
                  "nixosConfigurations-${name}"
                ]) (builtins.attrNames (outputs.nixosConfigurations or { }))
              )
              ++ lib.optionals (!(enabled "homeConfigurations")) (
                lib.concatMap (name: [
                  "home-${name}"
                  "homeConfigurations-${name}"
                ]) (builtins.attrNames (outputs.homeConfigurations or { }))
              );
          in
          (builtins.removeAttrs outputs [ "__devenvAutoChecks" ])
          // lib.optionalAttrs (outputs ? checks) {
            checks = lib.mapAttrs (
              system: checks: builtins.removeAttrs checks (namesFor system)
            ) outputs.checks;
          };

        wrapMkFlake =
          mkFlake:
          mkFlake
          // {
            __functor =
              _: src: root:
              removeAutoCheckOutputs (mkFlake src root);
            extend = modules: wrapMkFlake (mkFlake.extend modules);
          };
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
            imports = [
              ./flakelight-treefmt.nix
              ./flakelight-auto-checks.nix
            ];
            inputs.treefmt-nix = lib.mkDefault treefmt-nix;
          };
        lib.mkFlake = lib.mkForce (
          wrapMkFlake (flakelight.lib.mkFlake.extend [ outputs.flakelightModules.default ])
        );
        functor = lib.mkForce (self: self.lib.mkFlake);
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
          ramblurr-global-deps-edn = pkgs: pkgs.callPackage (import ./pkgs/deps-edn.nix) { };
        };
        checks =
          pkgs:
          (mkTemplateChecks pkgs)
          // {
            auto-checks = import ./tests/auto-checks.nix {
              inherit
                inputs
                lib
                pkgs
                self
                ;
            };
          };
        templates = import ./templates;
        outputs = {
          capsules = import ./capsules;
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
