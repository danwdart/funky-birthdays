{
  nixpkgs ? import <nixpkgs> {},
  haskell-tools ? import (builtins.fetchTarball "https://github.com/danwdart/haskell-tools/archive/master.tar.gz") {
    nixpkgs = nixpkgs;
    compiler = compiler;
  },
  compiler ? "ghc910"
} :
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  tools = haskell-tools compiler;
  lib = nixpkgs.pkgs.haskell.lib;
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      funky-birthdays = lib.dontHaddock (self.callCabal2nix "funky-birthdays" (gitignore ./.) {});
      # Not yet released - https://github.com/chrra/iCalendar/issues/52
      iCalendar = lib.doJailbreak (self.callCabal2nix "iCalendar" (builtins.fetchGit {
        url = "https://github.com/chrra/iCalendar.git";
        ref = "master";
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

