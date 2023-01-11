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

function _zsh_autosuggest_strategy_dirhist() {
    emulate -L zsh
    local zcmd=${${(z)1}[1]}
    if [[ "$zcmd" =~ "^[1-9]$" ]]
    then
        if [[ -v dirstack[$zcmd] ]]
        then
            typeset -g suggestion="$1 # -> ${dirstack[$zcmd]}"
        else
            typeset -g suggestion="$1 # (no stack entry)"
        fi
    fi
}

# Completion modes (controls tab behavior per-command)
compdef _precommand ,
compdef _precommand $
compdef _is is
compdef _new new

# Add comma highlighter
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main comma)

# Add directory stack strategy to autosuggest
ZSH_AUTOSUGGEST_STRATEGY=(dirhist history)

# Load Zoxide smart cd if installed
which -p zoxide >&/dev/null && eval "$(zoxide init zsh --cmd cd)"
