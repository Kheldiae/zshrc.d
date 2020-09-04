#
# Special commands for atomic OS management
#

alias lock_sysroot="sudo mount -o ro,remount,force,bind /run/physroot/system/current/ /"
alias unlock_sysroot="sudo mount -o rw,remount /"
alias snap_sysroot="sudo btrfs subvolume snapshot -r /run/physroot/system/current /run/physroot/system/\$(date +%Y-%m-%d).snapshot"
