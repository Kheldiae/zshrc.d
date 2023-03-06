#!/bin/bash
echo "Now serving desktheme over 19915..."

if [[ $(uname -s) == Darwin ]]
then
    pgrep -qx Finder || exit 0
    _get_theme() {
        (defaults read -g AppleInterfaceStyle 2>/dev/null || echo 'light') | tr '[:upper:]' '[:lower:]'
    }
else
    [[ -f $XDG_RUNTIME_DIR/theme ]] || touch $XDG_RUNTIME_DIR/theme
    _get_theme() {
        < $XDG_RUNTIME_DIR/theme
    }
fi

while true
do
    _get_theme | nc -lcp 19915
done
