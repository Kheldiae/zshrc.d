#
# Other commands that modify the zsh session
#

if (( ${+TMUX} ))
then
    export TERM=screen-256color         # 256color by default
    nvim +"Tmuxline airline" +q >/dev/null 2>&1
                                        # Apply Vim airline to tmux
fi

# Completion modes (controls tab behavior per-command)
export _comps[,]=_precommand
export _comps[$]=_precommand
