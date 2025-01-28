declare -A c_fetch_image
declare -A c_kitty_opacity

declare -A colors_light colors_dark

# Icons paths
c_fetch_image[dark]="$HOME/.local/etc/fetch_image_dark.png"
c_fetch_image[light]="$HOME/.local/etc/fetch_image_light.png"
c_gitfetch_nix_shell_image="$HOME/.local/etc/gitfetch_nix_shell_image.png"
c_gitfetch_image="$HOME/.local/etc/gitfetch_image.png"

# Opacity values for _kitty_color
c_kitty_opacity[dark]="0.8"
c_kitty_opacity[light]="0.8"

# Colorscheme
colors_light[goyo_bg]="#d9d9da"
colors_dark[goyo_bg]="#404552"
colors_dark[pgcli_bg]="#444444"
colors_light[pgcli_bg]="#444444"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

[ -f "$HOME/.zsh-colors" ] && source "$HOME/.zsh-colors"

# ASCII colors, useful sometimes
function colors::ascii() {
    for i in {0..255}
    do
        print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " \
            ${${(M)$((i%6)):#3}:+$'\n'}
    done
}

function colors::rgb() {
    val="$1"
    while [[ $(expr length "$val") -lt 3 ]]; do val="0$val"; done
    col=$(cat $ZSH_CONFIG_PATH/res/colors.csv | grep -F "$val;")
    print -P "%K{$val}  %k%F{$val}${(l:6::0:)col}"
}

# vim: ft=zsh
