declare -A c_fetch_image
declare -A c_kitty_opacity

declare -A colors_light colors_dark

c_fetch_image[dark]="$HOME/.local/etc/fetch_image_dark.png"
c_fetch_image[light]="$HOME/.local/etc/fetch_image_light.png"

c_gitfetch_image="$HOME/.local/etc/gitfetch_image.png"

c_kitty_opacity[dark]="0.3"
c_kitty_opacity[light]="0.6"

colors_dark[goyo_bg]="#404552"
colors_dark[ssh_bg]="#040454"
colors_light[goyo_bg]="#d9d9da"
colors_light[ssh_bg]="#b9caff"

# vim: ft=zsh
