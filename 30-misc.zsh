#
# Other commands that modify the zsh session
#

bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}"  end-of-line
bindkey -e                  # Bind Home and End keys

if (( ${+TMUX} ))
then
    export TERM=screen-256color
fi                          # On tmux, Vim doesn't use 256color by default.
