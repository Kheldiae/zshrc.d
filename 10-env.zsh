#
# Modifications to default environment in Z shell
#

[[ $(uname) == "Darwin" ]]  && IS_DARWIN=1  || IS_DARWIN=0

export HISTFILE=~/.cache/zsh-history
export HISTSIZE=1000
export SAVEHIST=1000
export PATH="$HOME/.gem/ruby/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/.local/bin:/opt/flutter/bin:$PATH"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
                            # Needed for home-manager
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
                            # Enable Yubikey ssh authentication

export EDITOR=nvim
export VISUAL=nvim          # Default editor, should have done this long ago


export MAKEFLAGS=-j8        # Go nuts, cowboy.
export GOPATH=$HOME/.local  # Lands Go packages right in PATH and prevents
                            # that fugly ~/go dir


AUTO_NOTIFY_THRESHOLD=120
AUTO_NOTIFY_IGNORE+=(ipython tmux nix-shell kitty-color goyo ranger mpv nethogs bat cd)
