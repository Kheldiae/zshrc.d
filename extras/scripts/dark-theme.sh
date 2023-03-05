#!/bin/bash

if [[ "`< $XDG_RUNTIME_DIR/theme`" != "dark" ]]
then
    echo "dark" > $XDG_RUNTIME_DIR/theme
    echo 1 > /sys/class/leds/dell::kbd_backlight/brightness
    dconf write /org/gnome/shell/extensions/user-theme/name "'Orchis-Dark'"

    source ~/.config/zshrc.d/11-colors.zsh

    for pid in $(ps fU $(whoami)|grep '[0-9]  \\_ kitty' | cut -f 4 -d ' ')
    do
    {
        kcolor=$(kitty @ --to=unix:@kitty-$pid get-colors|grep "^background"|tail -c8|tr -d $'\n')
        kncolor="#0A0B2C"
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
