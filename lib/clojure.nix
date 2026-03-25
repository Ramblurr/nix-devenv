{ inputs }:
let
  defaultMavenRepos = [
    "https://repo1.maven.org/maven2/"
    "https://repo.clojars.org/"
  ];
in
rec {
  mkLockerPkgs =
    {
      pkgs,
      jdk ? pkgs.jdk25,
    }:
    pkgs
    // {
      clojure = pkgs.clojure.override { inherit jdk; };
    };

  mkLockfile =
    {
      pkgs,
      jdk ? pkgs.jdk25,
      src ? null,
      lockfile,
      mavenRepos ? defaultMavenRepos,
      extraPrepInputs ? [ pkgs.git ],
    }:
    let
      lockerPkgs = mkLockerPkgs { inherit pkgs jdk; };
    in
    (import "${inputs.clojure-nix-locker}/default.nix" { pkgs = lockerPkgs; }).lockfile {
      inherit
        src
        lockfile
        mavenRepos
        extraPrepInputs
        ;
    };

  mkLocker =
    {
      pkgs,
      jdk ? pkgs.jdk25,
      src ? null,
      lockfile,
      command,
      mavenRepos ? defaultMavenRepos,
      extraPrepInputs ? [ pkgs.git ],
    }:
    let
      locked = mkLockfile {
        inherit
          pkgs
          jdk
          src
          lockfile
          mavenRepos
          extraPrepInputs
          ;
      };
    in
    {
      locker = locked.commandLocker command;
      homeDirectory = locked.homeDirectory;
      shellEnv = locked.shellEnv;
      wrapClojure = locked.wrapClojure;
      wrapPrograms = locked.wrapPrograms;
    };
}
