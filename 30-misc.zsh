#
# Other commands that modify the zsh session
#

if (( ${+TMUX} ))
then
    export TERM=screen-256color         # 256color by default
fi

function _is() { service=type _which; }

# Completion modes (controls tab behavior per-command)
compdef _precommand ,
compdef _precommand $
compdef _is is

# Add comma highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main comma)
