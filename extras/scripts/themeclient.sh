#!/bin/sh
rm -f $XDG_RUNTIME_DIR/theme
mkfifo $XDG_RUNTIME_DIR/theme

while nc -n 127.0.0.1 19915 </dev/null >$XDG_RUNTIME_DIR/theme
do true
done

# If we fail, delete the FIFO to not block scripts
rm $XDG_RUNTIME_DIR/theme
