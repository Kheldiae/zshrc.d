#
# Other commands that modify the zsh session
#

if (( ${+TMUX} ))
then
    export TERM=screen-256color         # 256color by default
fi

if [ -f $HOME/.box-name ]
then
    typeset -g POWERLEVEL9K_CONTEXT_REMOTE_TEMPLATE="$(< $HOME/.box-name) (%n)"
fi                                      # Box name (like Honukai)

function _is() { service=type _which; }

function _new() {
    for dir in $HOME/.templates/*
    do  compadd $(basename $dir)
    done
}

# Completion modes (controls tab behavior per-command)
compdef _precommand ,
compdef _precommand $
compdef _is is
compdef _new new

# Add comma highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main comma)
