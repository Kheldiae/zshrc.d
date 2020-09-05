#
# Modifications to default environment in Z shell
#

export HISTFILE=~/.cache/zsh-history
export HISTSIZE=1000
export SAVEHIST=1000
export PATH="$HOME/.gem/ruby/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/.local/bin:/opt/flutter/bin:$PATH"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
                            # Needed for home-manager
export SSH_AUTO_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
                            # Enable Yubikey ssh authentication
export VISUAL=nvim          # Default editor, should have done this long ago

export AUTO_NOTIFY_THRESHOLD=120
export AUTO_NOTIFY_IGNORE=(ipython tmux nix-shell goyo ranger mpv nethogs bat $AUTO_NOTIFY_IGNORE)

export MAKEFLAGS=-j8        # Go nuts, cowboy.
export RUST_SRC_PATH=/usr/local/src/rust/src
                            # Rust source path for Racer autocomplete
