#!/bin/bash
echo "Now serving desktheme over 19915..."

[[ -f $XDG_RUNTIME_DIR/theme ]] || touch $XDG_RUNTIME_DIR/theme

while true
do
    nc -lcp 19915 < $XDG_RUNTIME_DIR/theme
done
