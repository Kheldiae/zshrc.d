#
# Icons wrapping suite, meant to ensure no bugs when using the fetches later.
#

function __icons::ensure_dir() {
    if ! [[ -d $HOME/.local/etc ]]
    then
        mkdir $HOME/.local/etc
        >&2 echo "Created icons directory"
    fi
}

function __icons::clone() {
    __icons::ensure_dir
    for icon in $($ZSH_CONFIG_PATH/icons/*.png)
    do
        cp $ZSH_CONFIG_PATH/icons/$icon $HOME/.local/etc
        >&2 echo "copied $icon"
    done
}

__icons::clone
unfunction __icons::ensure_dir
unfunction __deps::check
touch $HOME/.zsh_has_icons
