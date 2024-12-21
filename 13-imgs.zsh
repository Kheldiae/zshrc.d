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

function __icons::setup() {
    __icons::ensure_dir
    for icon in $(find $ZSH_CONFIG_PATH/icons/*.png -type f | grep png)
    do
        cp $icon $HOME/.local/etc
        >&2 echo "copied $icon"
    done
}

if ! [[ -f $HOME/.zsh_has_icons ]]
then
    __icons::setup
    unfunction __icons::ensure_dir
    unfunction __icons::setup
    touch $HOME/.zsh_has_icons
fi
