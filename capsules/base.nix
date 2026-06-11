{ withCategory, ... }:
{ pkgs, ... }:
{
  commands = map (withCategory "base") [
  ];
  packages = [
  ];
}
