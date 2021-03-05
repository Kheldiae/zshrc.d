#
# Special commands for atomic OS management
#

function edit_sysroot()
{
    echo -e "System root is now ${fg[red]}unlocked\e[0m. Proceed with caution."
    
    if [[ $# -gt 0 ]]
    then
        sudo unshare -m -- sh -c "umount /etc; mount -o rw,remount /;\
            rm -f /opt && mkdir /opt && mount -o bind,rw /var/persist/opt /opt; $*"
        sudo rmdir /sysroot/system/current/opt && sudo ln -fsn /var/persist/opt /sysroot/system/current/opt
    else
        sudo unshare -m -- sh -c "umount /etc; mount -o rw,remount /;\
            rm -f /opt && mkdir /opt && mount -o bind,rw /var/persist/opt /opt;\
            PROMPT='🔓%F{red}%m%f:%F{cyan}%~ %f%# ' zsh"
        sudo rmdir /sysroot/system/current/opt && sudo ln -fsn /var/persist/opt /sysroot/system/current/opt
    fi
}

alias snap_sysroot="sudo btrfs subvolume snapshot -r /sysroot/system/current /sysroot/system/\$(date +%Y-%m-%d).snapshot"
