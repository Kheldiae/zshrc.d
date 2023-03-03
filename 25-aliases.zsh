alias sudo="sudo "                  # Important, makes aliases work with sudo

alias ducks="du -ckshx"             # Shows disk usage by element in one tree lvl
alias btrfs-ducks="btrfs filesystem du -s --human-readable"
                                    # Uses btrfs version of du

alias ls="lsd --group-dirs=first"   # uber cool ls alternative
alias tree="lsd --tree"

alias cp="cp --reflink=auto"        # under btrfs, privilege reflinks

alias type="type -f"                # Enable func printing on zsh type

if [[ -v IN_NIX_SHELL ]]
then
    pyver=$(python3 --version | cut -d' ' -f 2| cut -d'.' -f 1-2)
    repypath="PYTHONPATH=$HOME/.local/lib/python$pyver/site-packages:\$PYTHONPATH" 
    alias vim="nvim --cmd \"let g:python3_host_prog = '$OLDPYTHON'\""
    alias ipython="$repypath ipython"
    alias jupyter="$repypath jupyter"
else
    alias vim="nvim"                # Switched to Neovim :D
fi

alias goyo='_kitty_color goyo_bg 1 nvim -u ~/.config/nvim/goyo.vim'
                                    # a simpler editor.

alias ssh='_kitty_color ssh_bg $c_kitty_opacity[`_get_theme`] ssh'
                                    # blue-tint ssh term

((IS_DARWIN)) || alias open="xdg-open"
                                    # Think different.

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

alias gitfetch="onefetch --image $c_gitfetch_image --no-color-palette"

alias play="gst-play-1.0"

alias ihs="jupyter console --kernel haskell"
alias icaml="jupyter console --kernel ocaml"
alias irust="jupyter console --kernel rust"
alias icoq="jupyter console --kernel coq"

alias ino="arduino-cli"

alias zplug="LANG=C.UTF-8 zplug"    # Fix for zplug/zplug#419


alias calc="qalc"

aliases[=]='noglob qalc -c'         # = shorthand for calculator
