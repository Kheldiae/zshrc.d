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

function link-imgs() {
    >&2 echo "The following images are not linked :"
    __imgs::ensure_dir
    ls -l $ZSH_CONFIG_PATH/imgs
    >&2 echo "Do you wish linking them ?"
    if read -q
    then
        for img in $(ls $ZSH_CONFIG_PATH/imgs)
        do
            cp $ZSH_CONFIG_PATH/imgs/$img $HOME/.local/etc/$img
        done
    else
        >&2 echo "You can still link them with link-imgs"
    fi
}
