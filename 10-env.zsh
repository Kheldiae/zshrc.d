#
# Modifications to default environment in Z shell
#

[[ $(uname) == "Darwin" ]]  && IS_DARWIN=1 \
                            || IS_DARWIN=0

[[ -v IN_NIX_SHELL ]] && eval "$shellHook"
                            # Evaluate nix-shell/nix develop hook

# Shell history settings
export HISTFILE=~/.cache/zsh-history
export HISTSIZE=1000
export SAVEHIST=1000

# Pathind environment
export PATH="$HOME/.gem/ruby/bin:$HOME/.yarn/bin:$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
export NIX_PATH=$HOME/.nix-defexpr/channels${NIX_PATH:+:}$NIX_PATH
                            # Needed for home-manager
export GOPATH=$HOME/.local  # Lands Go packages right in PATH and prevents
                            # that fugly ~/go dir

export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"
                            # Enable Yubikey ssh authentication

# Edition environment settings
export EDITOR=nvim
export VISUAL=nvim          # Default editor, should have done this long ago

export MAKEFLAGS=-j$(nproc --all)

export DIRENV_LOG_FORMAT=$'\e[1;37mdirenv: \e[0;37m%s\e[0m'
                            # More subdued colors for direnv logs

# Git configuration overlay
export GIT_CONFIG_SYSTEM=$ZSH_CONFIG_PATH/extras/git/config

export XDG_CONFIG_DIRS=$ZSH_CONFIG_PATH/extras:$XDG_CONFIG_DIRS

AUTO_NOTIFY_THRESHOLD=120
AUTO_NOTIFY_IGNORE+=(ipython tmux nix-shell kitty-color goyo ranger mpv nethogs bat cd)

# podman utility
export TMPDIR=/tmp
export CONTAINERS_ROOT=$HOME/.local/share/containers

# Small locale fix
export LOCALE_ARCHIVE=/usr/lib/locale/locale-archive

# TODO add templating toolkit
