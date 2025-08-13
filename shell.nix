with import <nixpkgs> {};
# needs mkShell in order to use headers/etc. from deps! how do we do that from nix-shell 
mkShell rec {
    packages = [
        haskell.compiler.ghc912
        cabal-install
        krank
        # pkg-config
        # zlib.dev
        # pcre.dev
        # for gtk version
        # webkitgtk_4_0.dev # only this old version?
        # gobject-introspection.dev
        # libsysprof-capture
        # pcre2.dev
        # util-linux.dev
        # libselinux.dev
        # libsepol.dev
        # libthai.dev
        # libdatrie.dev
        # xorg.libXdmcp.dev
        # lerc.dev
        # libxkbcommon.dev
        # libepoxy.dev
        # xorg.libXtst
        # sqlite.dev
        # libpsl.dev
    ];
    shellHook = ''
        [[ -f ~/.local/bin/refactor ]] || cabal install apply-refact cabal-fmt doctest ghci-dap ghcid ghcide haskell-debug-adapter haskell-language-server hasktags hlint hoogle hpack implicit-hie stan stylish-haskell weeder --overwrite-policy=always --allow-newer
        export PATH=~/.local/bin:$PATH
        gen-hie > hie.yaml
        for i in $(find . -type f | grep -v "dist-*"); do krank $i; done
    '';
}