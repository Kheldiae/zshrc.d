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

      packages."zshrc" = pkgs.writeText "zshrc"
        ''
          fpath=(/usr/share/zsh/site-functions ${self.packages.${system}.prereqs}/share/zsh/site-functions $fpath)

          [[ -v ZDIRFILE ]] || ZDIRFILE=$HOME/.cache/zsh-dirs.zsh

          ZSH_CONFIG_PATH=${./.}
          ZPLUG_PATH=${pkgs.zplug}/share/zplug

          for file in $ZSH_CONFIG_PATH/*.zsh
          do
            . $file
          done
        '';

      ### The star of the show
      packages."zsh" = pkgs.stdenv.mkDerivation rec
      { inherit (pkgs.zsh) pname version passthru;
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
          cat > $out/.zprofile <<EOF
            source /etc/profile
          EOF
          cat /dev/stdin ${self.packages.${system}.zshrc} > $out/.zshrc <<EOF
            source \$HOME/.zshrc
          EOF
          makeWrapper ${pkgs.zsh}/bin/zsh $out/bin/zsh \
            --set ZDOTDIR $out \
            --prefix PATH : ${pkgs.lib.makeBinPath buildInputs}
        '';
      };

      ### One-stop-shop variant with optional dependencies also included
      packages."zsh-full" = self.packages.${system}.zsh.overrideAttrs
      (o: { buildInputs = [ self.packages.${system}.optionalDeps ] ++ o.buildInputs; });
    });


}
