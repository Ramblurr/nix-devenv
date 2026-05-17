{ withCategory, ... }:
{ pkgs, ... }:
{
  commands = map (withCategory "base") [
    {
      package = pkgs.garnix-cli;
      name = "garnix-cli";
    }
    {
      package = pkgs.spdx;
      name = "spdx";
      help = "Manage SPDX licenses and copyright headers";
    }
  ];
  packages = [
  ];
}
