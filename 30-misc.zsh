#
# Other commands that modify the zsh session
#

if (( ${+TMUX} ))
then
    export TERM=screen-256color         # 256color by default
    nvim +"Tmuxline airline" +q >/dev/null 2>&1
                                        # Apply Vim airline to tmux
fi

function _is() { service=type _which; }

# Completion modes (controls tab behavior per-command)
compdef _precommand ,
compdef _precommand $
compdef _is is


# zsh-syntax-highlighting plugin for comma
: ${ZSH_HIGHLIGHT_STYLES[comma:pfx]:=fg=blue}

function _zsh_highlight_highlighter_comma_predicate() {
    which -p , >/dev/null 2>&1
}

function _zsh_highlight_highlighter_comma_paint() {
    setopt localoptions extendedglob
    #local -a args
    #args=(${(z)BUFFER})
    [[ "$BUFFER" =~ ", +([^ ]+)" ]] 2>/dev/null || return
    if grep "^$match\$" $HOME/.cache/nix-index/cmds >/dev/null 2>&1
    then
        _zsh_highlight_add_highlight $((mbegin - 1)) $mend arg0
    else
        _zsh_highlight_add_highlight $((mbegin - 1)) $mend unknown-token
    fi
    _zsh_highlight_add_highlight $((MBEGIN - 1)) $MBEGIN comma:pfx
    unset mbegin mend match MBEGIN MEND MATCH
}

export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main comma)

# Update the cached index of /bin commands (i.e. comma commands) because
# nix-locate is way too slow for our needs.
if which -p nix-locate , >/dev/null 2>&1 && \
    ! find $HOME/.cache/nix-index/cmds      \
        -newer $HOME/.cache/nix-index/files | grep ".*" >/dev/null 2>&1
then
    nix-locate --at-root /bin/ | cut -d/ -f6 | sort -u > $HOME/.cache/nix-index/cmds
    echo "Updated nix commands cache."
fi
