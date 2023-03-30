#!/bin/bash

if [[ "`< $XDG_RUNTIME_DIR/theme`" != "light" ]]
then
    echo "light" > $XDG_RUNTIME_DIR/theme
    echo 0 > /sys/class/leds/dell::kbd_backlight/brightness
    dconf write /org/gnome/shell/extensions/user-theme/name "'Orchis-Yellow-Light'"

    source ~/.config/zshrc.d/11-colors.zsh

    for pid in $(ps fU $(whoami)|grep '[0-9]  \\_ kitty' | grep -o '^ *[0-9]*')
    do
    {
        kcolor=$(kitty @ --to=unix:@kitty-$pid get-colors|grep "^background"|tail -c8|tr -d $'\n')
        kncolor="#C3D4EE"
        for c in "${!colors_dark[@]}"
        do
            [[ "$kcolor" == "${colors_dark[$c]}" ]] && export kncolor=${colors_light[$c]} && break
        done

        kitty @ --to=unix:@kitty-$pid set-colors -a -c ~/.config/kitty/kitty-light.conf background=$kncolor
        kitty @ --to=unix:@kitty-$pid set-background-opacity "${c_kitty_opacity[light]}"
    } &
    done
    ln -fsn kitty-light.conf ~/.config/kitty/kitty.conf
    ln -fsn kvantum.light.kvconfig ~/.config/Kvantum/kvantum.kvconfig
else
    echo "[DEBUG] Light theme already set, ignoring..." >&2
fi
