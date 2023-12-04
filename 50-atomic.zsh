#
# Special commands for atomic OS management
#

function edit_sysroot()
{
    echo -e "System root is now ${fg[red]}unlocked\e[0m. Proceed with caution."

    if [[ $# -gt 0 ]]
    then
        sudo unshare -m -- sh -c "umount /etc; mount -o rw,remount /; $*"
    else
        sudo unshare -m -- sh -c "umount /etc; mount -o rw,remount /;\
            PROMPT='🔓%F{red}%m%f:%F{cyan}%~ %f%# ' zsh"
    fi
}

