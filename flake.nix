{ description = "Flake for my Zsh meta-config";

  inputs."nixpkgs".url = github:NixOS/nixpkgs;
  inputs."flake-utils".url = github:numtide/flake-utils;

  outputs = { self, nixpkgs, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let
      pkgs = import nixpkgs { inherit system; };
    in
    { legacyPackages = pkgs;
      packages.default = self.packages.${system}.zsh;
      packages."zsh" = pkgs.stdenv.mkDerivation
      { inherit (pkgs.zsh) version;
        pname = "zsh-thesola10";
        nativeBuildInputs = with pkgs; [ makeWrapper ];
        buildInputs = with pkgs;
          [ zsh
            zplug
          ];

        src = ./.;

        installPhase = ''
          mkdir -p $out/bin
          cat > $out/.zshrc <<EOF
            source \$HOME/.zshrc

            ZSH_CONFIG_PATH=${./.}
            ZPLUG_PATH=${pkgs.zplug}/share/zplug

            for file in \$ZSH_CONFIG_PATH/*.zsh
            do
              . \$file
            done
          EOF
          makeWrapper ${pkgs.zsh}/bin/zsh $out/bin/zsh \
            --prefix ZDOTDIR : $out
        '';
      };
    });
}
