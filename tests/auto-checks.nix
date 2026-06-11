{
  inputs,
  lib,
  pkgs,
  self,
}:

let
  system = pkgs.stdenv.hostPlatform.system;
  hasPath = path: value: lib.hasAttrByPath path value;
  mkFlake = module: self.lib.mkFlake ./empty module;

  common = {
    inherit inputs;
    systems = [ system ];
    flakelight.builtinFormatters = false;
  };

  devShellFlake = mkFlake (
    common
    // {
      devShell = pkgs: {
        packages = [ pkgs.hello ];
      };
      devShells.tools = pkgs: {
        packages = [ pkgs.hello ];
      };
    }
  );

  devShellOptOutFlake = mkFlake (
    common
    // {
      devenv.autoChecks.devShells = false;
      devShell = pkgs: {
        packages = [ pkgs.hello ];
      };
    }
  );

  nixosModule = {
    nixpkgs.hostPlatform.system = system;
    system.stateVersion = "25.05";
    boot.loader.grub.enable = false;
    fileSystems."/".device = "none";
  };

  nixosFlake = mkFlake (
    common
    // {
      nixosConfigurations.test = {
        modules = [ nixosModule ];
      };
    }
  );

  nixosOptOutFlake = mkFlake (
    common
    // {
      devenv.autoChecks.nixosConfigurations = false;
      nixosConfigurations.test = {
        modules = [ nixosModule ];
      };
    }
  );

  homeModule = {
    home.username = "alice";
    home.homeDirectory = "/home/alice";
    home.stateVersion = "25.05";
  };

  homeFlake = mkFlake (
    common
    // {
      homeConfigurations.alice = {
        inherit system;
        modules = [ homeModule ];
      };
    }
  );

  homeOptOutFlake = mkFlake (
    common
    // {
      devenv.autoChecks.homeConfigurations = false;
      homeConfigurations.alice = {
        inherit system;
        modules = [ homeModule ];
      };
    }
  );

  nestedExtendedFlake =
    let
      extended = self.lib.mkFlake.extend [ { outputs.extended = true; } ];
    in
    (extended.extend [ { outputs.extendedAgain = true; } ]) ./empty common;
in
assert hasPath [ "checks" system "devShells-default" ] devShellFlake;
assert hasPath [ "checks" system "devShells-tools" ] devShellFlake;
assert !(hasPath [ "checks" system "devShells-default" ] devShellOptOutFlake);
assert hasPath [ "checks" system "nixos-test" ] nixosFlake;
assert !(hasPath [ "checks" system "nixos-test" ] nixosOptOutFlake);
assert hasPath [ "checks" system "home-alice" ] homeFlake;
assert !(hasPath [ "checks" system "home-alice" ] homeOptOutFlake);
assert !(hasPath [ "__devenvAutoChecks" ] devShellFlake);
assert nestedExtendedFlake.extended;
assert nestedExtendedFlake.extendedAgain;
assert !(hasPath [ "__devenvAutoChecks" ] nestedExtendedFlake);

pkgs.runCommand "auto-checks-tests" { } ''
  touch $out
''
