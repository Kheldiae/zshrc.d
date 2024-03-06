declare -A c_fetch_image
declare -A c_kitty_opacity

declare -A colors_light colors_dark

c_fetch_image[dark]="$HOME/.local/etc/fetch_image_dark.png"
c_fetch_image[light]="$HOME/.local/etc/fetch_image_light.png"

c_gitfetch_nix_shell_image="$HOME/.local/etc/gitfetch_nix_shell_image.png"
c_gitfetch_image="$HOME/.local/etc/gitfetch_image.png"

c_kitty_opacity[dark]="0.7"
c_kitty_opacity[light]="0.7"

colors_dark[goyo_bg]="#404552"
colors_dark[ssh_bg]="#544635"
colors_light[goyo_bg]="#d9d9da"
colors_light[ssh_bg]="#b9caff"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

[ -f "$HOME/.zsh-colors" ] && source "$HOME/.zsh-colors"

# vim: ft=zsh
