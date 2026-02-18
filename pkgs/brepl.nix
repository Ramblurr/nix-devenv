{
  pkgs,
  fetchFromGitHub,
  callPackage,
  ...
}:
callPackage (
  fetchFromGitHub {
    owner = "licht1stein";
    repo = "brepl";
    rev = "v2.7.0";
    hash = "sha256-eTQS5LvAOLvx46YS6V/2+bYkWSELTTwZ1ir77eLk99M=";
  }
  + "/package.nix"
) { }
