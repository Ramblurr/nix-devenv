{ withCategory, ... }:
{
  config,
  lib,
  pkgs,
  ...
}:
let
  jdk = config.clojure.jdk;
  clojure = pkgs.clojure.override { inherit jdk; };
in
{
  options.clojure.jdk = lib.mkOption {
    type = lib.types.package;
    default = pkgs.jdk25;
    description = "JDK package used by Java and Clojure in the development shell.";
  };

  config = {
    commands = map (withCategory "clojure") [
      {
        package = pkgs.babashka-unwrapped;
        name = "bb";
        help = "task runner for clojure see `bb help`";
      }
      { package = pkgs.brepl; }
    ];
    packages = [
      jdk
      clojure
      pkgs.brepl
      pkgs.clojure-mcp-light
      pkgs.clojure-lsp
      pkgs.clj-kondo
      pkgs.cljfmt
      pkgs.babashka-unwrapped
    ];
  };
}
