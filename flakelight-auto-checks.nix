{
  config,
  lib,
  ...
}:

let
  cfg = config.devenv.autoChecks;
in
{
  options.devenv.autoChecks = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether nix-devenv should add automatic flake checks for buildable outputs.";
    };

    devShells = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to expose devShells as checks.";
    };

    nixosConfigurations = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to keep automatically generated NixOS configuration checks.";
    };

    homeConfigurations = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to keep automatically generated home-manager configuration checks.";
    };
  };

  config = {
    outputs.__devenvAutoChecks = {
      inherit (cfg)
        enable
        devShells
        nixosConfigurations
        homeConfigurations
        ;
    };

    checks = lib.mkIf (cfg.enable && cfg.devShells) (
      pkgs:
      lib.mapAttrs' (name: drv: lib.nameValuePair "devShells-${name}" drv) (
        config.outputs.devShells.${pkgs.stdenv.hostPlatform.system} or { }
      )
    );
  };
}
