alias ducks="du -ckshx"             # Shows disk usage by element in one tree lvl
alias btrfs-ducks="btrfs filesystem du -s --human-readable"
                                    # Uses btrfs version of du

alias ls="lsd --group-dirs=first"   # uber cool ls alternative
alias tree="lsd --tree"

alias cp="cp --reflink=auto"        # under btrfs, privilege reflinks

alias type="type -f"                # Enable func printing on zsh type

alias vim="nvim"                    # Switched to Neovim :D
alias goyo='_kitty_color goyo_bg 0.75 nvim --cmd "let g:startGoyo = 1"'
                                    # a simpler editor.
alias psql="_kitty_color pgcli_bg 0.7 pgcli" # SQL editor

alias bake="bear -- make"           # Make with compile_commands.json

alias nya='kitten'                  # shorthand for kitty ^•ﻌ•^

alias ip6="ip -6"                   # IPv6 shorthand config

((IS_DARWIN)) || alias open="xdg-open"
                                    # Think different.

alias diff="diff --color=auto"
alias grep="grep --color=auto"      # JUST
alias zgrep="zgrep --color=auto"    # ADD
alias fgrep="fgrep --color-auto"    # SOME
alias egrep="egrep --color=auto"    # COLOUR. grep is way better with highlight.
alias jel="jello <"

alias murder="kill -9"
alias pmurder="pkill -9"
alias murderall="killall -9"        # SIGKILL ftw

alias anihilate='shred -f -n 40 -z' # Rewrite perms, shred 40 passes and zero out

alias trash="gio trash"             # Use desktop trash in the terminal

alias userctl="systemctl --user"    # Manage user-mode systemd units

alias yelp="noglob yelp"

alias gitfetch="onefetch --image $c_gitfetch_image --no-color-palette"

alias play="gst-play-1.0"

# Jupyter aliases
alias ihs="jupyter console --kernel haskell"
alias icaml="jupyter console --kernel ocaml"
alias irust="jupyter console --kernel rust"
alias icoq="jupyter console --kernel coq"
alias icc="jupyter console --kernel xcpp11"

alias ino="arduino-cli"

alias zplug="LANG=C.UTF-8 zplug"    # Fix for zplug/zplug#419


alias calc="qalc"
aliases[=]='noglob qalc -c'         # = shorthand for calculator

# Nixie handling and global Nix aliases
alias nixie="nix run github:nixie-dev/nixie --"
alias ni="nix profile install"

# Cli-goodies aliases
alias new="new --"

# Confort aliases
alias shut="shutdown now"
