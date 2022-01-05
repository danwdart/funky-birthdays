{ 
  nixpkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/haskell-updates.tar.gz") {},
  # https://github.com/chrra/iCalendar/issues/48
  compiler ? "ghc902"
} :
let
  gitignore = nixpkgs.nix-gitignore.gitignoreSourcePure [ ./.gitignore ];
  lib = nixpkgs.pkgs.haskell.lib;
  myHaskellPackages = nixpkgs.pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: rec {
      funky-birthdays = self.callCabal2nix "funky-birthdays" (gitignore ./.) {};
      # Don't know why I need a doJailbreak in here, the version restriction of base
      # looks up-to-date in the repository.
      # https://github.com/stackbuilders/datetime/pull/13
      datetime = lib.doJailbreak (self.callCabal2nix "datetime" (builtins.fetchGit {
        url = "https://github.com/l29ah/datetime.git";
        ref = "time-1.11";
      }) {});
      # Don't know why doJailbreak does nothing here?
      # https://github.com/chrra/iCalendar/pull/46
      iCalendar = lib.doJailbreak (self.callCabal2nix "iCalendar" (builtins.fetchGit {
        url = "https://github.com/markus1189/iCalendar.git";
        ref = "update-bounds";
      }) {});
    };
  };
  shell = myHaskellPackages.shellFor {
    packages = p: [
      p.funky-birthdays
    ];
    shellHook = ''
      gen-hie > hie.yaml
      for i in $(find -type f); do krank $i; done
    '';
    buildInputs = with myHaskellPackages; with nixpkgs; with haskellPackages; [
      apply-refact
      cabal-install
      ghcid
      ghcide
      haskell-language-server
      hasktags
      hlint
      implicit-hie
      krank
      haskellPackages.stan # issue with 9.0.1
      stylish-haskell
      weeder
    ];
    withHoogle = false;
  };
  exe = lib.justStaticExecutables (myHaskellPackages.funky-birthdays);
in
{
  inherit shell;
  inherit exe;
  inherit myHaskellPackages;
  funky-birthdays = myHaskellPackages.funky-birthdays;
}

