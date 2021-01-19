alias sudo="sudo "                  # Important, makes aliases work with sudo

alias ducks="du -cksh"              # Shows disk usage by element in one tree lvl

alias ls="lsd --group-dirs=first"   # uber cool ls alternative
alias tree="lsd --tree"

alias cp="cp --reflink=auto"        # under btrfs, privilege reflinks

alias nasmdump="objdump -M intel"

alias type="type -f"                # Enable func printing on zsh type

alias vim="nvim"                    # Switched to Neovim :D

alias goyo='kitty-color $c_kitty_goyo_bg 1 nvim -u ~/.config/nvim/goyo.vim'
                                    # a simpler editor.

alias ssh='kitty-color $c_kitty_ssh_bg $c_kitty_opacity ssh $@'
                                    # blue-tint ssh term

alias open="xdg-open"               # Think different.

alias grep="grep --color=auto"      # ADD
alias fgrep="fgrep --color-auto"    # SOME
alias egrep="egrep --color=auto"    # COLOUR. grep is way better with highlight.

alias murder="kill -9"
alias pmurder="pkill -9"
alias murderall="killall -9"        # SIGKILL ftw

alias anihilate='shred -f -n 40 -z' # Rewrite perms, shred 15 passes and zero out

alias trash="gio trash"             # Use desktop trash in the terminal

alias userctl="systemctl --user"    # Manage user-mode systemd un

alias icat="kitty +kitten icat"     # kitty's image viewer

alias up="TERM=xterm-256color up"   # up (nix) doesn't work with xterm-kitty

alias yelp="noglob yelp"

alias ssh-cremi="ssh -YCt4 kvergnes@sshproxy.emi.u-bordeaux.fr ssh -YCt trelawney zsh"
                                    # Just zoom past the proxy and connect to mcgonagall

alias ghci="TERM=xterm-256color LANG=C.UTF-8 ghci"
                                    # Fixes TERM var and locale

alias reboot-efi-setup="sudo efibootmgr -n 0010 && sudo reboot now"
