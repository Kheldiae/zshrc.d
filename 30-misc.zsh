#
# Other commands that modify the zsh session
#

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey -e                  # Bind Home and End keys

if (( ${+TMUX} ))
then
    export TERM=screen-256color         # 256color by default
    nvim +"Tmuxline airline" +q >/dev/null 2>&1
                                        # Apply Vim airline to tmux
fi
