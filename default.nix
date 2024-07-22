{
  nixpkgs ? import <nixpkgs> {},
  haskell-tools ? import (builtins.fetchTarball "https://github.com/danwdart/haskell-tools/archive/master.tar.gz") {
    nixpkgs = nixpkgs;
    compiler = compiler;
  },
  compiler ? "ghc94"
} :
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  tools = haskell-tools compiler;
  lib = nixpkgs.pkgs.haskell.lib;
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      funky-birthdays = lib.dontHaddock (self.callCabal2nix "funky-birthdays" (gitignore ./.) {});
      # Don't know why I need a doJailbreak in here, the version restriction of base
      # looks up-to-date in the repository.
      # https://github.com/stackbuilders/datetime/pull/13
      datetime = lib.doJailbreak (self.callCabal2nix "datetime" (builtins.fetchGit {
        url = "https://github.com/l29ah/datetime.git";
        ref = "time-1.11";
      }) {});
      # Don't know why doJailbreak does nothing here?
      # https://github.com/chrra/iCalendar/issues/48
      # https://github.com/chrra/iCalendar/pull/51
      iCalendar = lib.doJailbreak (self.callCabal2nix "iCalendar" (builtins.fetchGit {
        url = "https://github.com/zenhack/iCalendar.git";
        ref = "update-deps";
      }) {});
    };
  };
  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.funky-birthdays
    ];
    shellHook = ''
      gen-hie > hie.yaml
      for i in $(find -type f | grep -v dist-newstyle); do krank $i; done
    '';
    buildInputs = tools.defaultBuildTools;
    withHoogle = false;
  };
  in
{
  inherit shell;
  funky-birthdays = lib.justStaticExecutables (myHaskellPackages.funky-birthdays);
}

