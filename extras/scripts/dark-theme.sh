#!/usr/bin/bash

if [[ "`< $XDG_RUNTIME_DIR/theme`" != "dark" ]]
then
    echo "dark" > $XDG_RUNTIME_DIR/theme
    echo 1 > /sys/class/leds/dell::kbd_backlight/brightness

    {
        timeout 60s adb -s 192.168.240.112:5555 wait-for-device
        adb -s 192.168.240.112:5555 shell cmd uimode night yes
    } &

    zcpath=$(zsh -ic 'print $ZSH_CONFIG_PATH')
    source $zcpath/11-colors.zsh

    for pid in $(pgrep -x kitty)
    do
    {
        kcolor=$(kitty @ --to=unix:@kitty-$pid get-colors|grep "^background"|tail -c8|tr -d $'\n')
        kncolor="#080A20"
        for c in "${!colors_light[@]}"
        do
            [[ "$kcolor" == "${colors_light[$c]}" ]] && export kncolor=${colors_dark[$c]} && break
        done

        kitty @ --to=unix:@kitty-$pid set-colors -a -c ~/.config/kitty/kitty-dark.conf background=$kncolor
        kitty @ --to=unix:@kitty-$pid set-background-opacity "${c_kitty_opacity[dark]}"
    } &
    done
    ln -fsn kitty-dark.conf ~/.config/kitty/kitty.conf
    ln -fsn kvantum.dark.kvconfig ~/.config/Kvantum/kvantum.kvconfig
else
    echo "[DEBUG] Dark theme already set, ignoring..." >&2
fi
