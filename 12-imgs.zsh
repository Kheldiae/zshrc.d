#
# Since this configuration uses a bunch of images, this file aims to symlink
# them wherever they need to be.
#

function __imgs::ensure_dir() {
    if [[ -ne $HOME/.local/etc ]]
    then
        mkdir $HOME/.local/etc
    fi
}

function __imgs::link() {
    [[ -e $HOME/.zsh_has_imgs ]] && return

    >&2 echo "The following images are not linked :"
    __imgs::ensure_dir()
    __imgs::print_missing()
    >&2 echo "Do you wish linking them ?"
    read -q || return

    # TODO file loop for symlinking
}
