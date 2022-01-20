alias sudo="sudo "                  # Important, makes aliases work with sudo

alias ducks="du -cksh"              # Shows disk usage by element in one tree lvl
alias btrfs-ducks="btrfs filesystem du -s --human-readable"
                                    # Uses btrfs version of du

alias ls="lsd --group-dirs=first"   # uber cool ls alternative
alias tree="lsd --tree"

alias cp="cp --reflink=auto"        # under btrfs, privilege reflinks

alias type="type -f"                # Enable func printing on zsh type

alias vim="DESKTOP_THEME=`_get_theme` nvim"
                                    # Switched to Neovim :D

alias goyo='_kitty_color goyo_bg 1 nvim -u ~/.config/nvim/goyo.vim'
                                    # a simpler editor.

alias ssh='_kitty_color ssh_bg $c_kitty_opacity[`_get_theme`] ssh $@'
                                    # blue-tint ssh term

alias open="xdg-open"               # Think different.

alias grep="grep --color=auto"      # JUST
alias zgrep="zgrep --color=auto"    # ADD
alias fgrep="fgrep --color-auto"    # SOME
alias egrep="egrep --color=auto"    # COLOUR. grep is way better with highlight.

alias murder="kill -9"
alias pmurder="pkill -9"
alias murderall="killall -9"        # SIGKILL ftw

alias anihilate='shred -f -n 40 -z' # Rewrite perms, shred 40 passes and zero out

alias trash="gio trash"             # Use desktop trash in the terminal

alias userctl="systemctl --user"    # Manage user-mode systemd units

alias yelp="noglob yelp"

alias ghci="LANG=C.UTF-8 ghci"
                                    # Fixes locale for Nix ghci

alias gitfetch="onefetch --image-backend kitty -i $c_gitfetch_image --no-color-palette"

alias play="gst-play-1.0"

alias ihs="jupyter console --kernel haskell"
alias icaml="jupyter console --kernel ocaml"

alias ino="arduino-cli"


alias calc="qalc"

aliases[=]='noglob qalc -c'         # = shorthand for calculator
