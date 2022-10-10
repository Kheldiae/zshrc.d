#
# zsh-dirs plugin to pin a directory
#

function pin() {
    [[ $# != 1 ]] && { echo "Usage: pin <alias name>"; return; }
    export $1="$PWD"
    echo "export $1=\"$PWD\"" >> $ZSH_CONFIG_PATH/99-dirs.zsh
}

export run="$XDG_RUNTIME_DIR"
