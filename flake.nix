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
      packages."optionalDeps" = pkgs.buildEnv {
        name = "zsh-optional-deps";
        paths = with pkgs;
          [ neofetch
            twurl
            qrencode
            gst_all_1.gst-plugins-base
            nix-output-monitor
            libqalculate
            comma
            nix-index
            pandoc
            zoxide
            libnotify
            dsf2flac
          ];
      };
      packages."prereqs" = pkgs.buildEnv {
        name = "zsh-prereqs";
        paths = with pkgs;
          [ lsd
            bat
            onefetch
            git
            perl
            gnugrep
            findutils
            gawk
            gnused
            gnutar
            ncurses
            gzip
            curl
            wget
            jq
            fzy
          ];
      };
      packages."zsh" = pkgs.stdenv.mkDerivation rec
      { inherit (pkgs.zsh) pname version;
        nativeBuildInputs = with pkgs; [ makeWrapper ];
        buildInputs = with pkgs;
          [ zsh
            zplug

            # Prerequisites for this zsh config
            self.packages.${system}.prereqs
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
            --prefix ZDOTDIR : $out \
            --prefix PATH : ${pkgs.lib.makeBinPath buildInputs}
        '';
      };
    });
}
