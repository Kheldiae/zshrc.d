#!/bin/bash

# Don't clobber the themeserver and day/night process of the desktop
[[ $XDG_SESSION_DESKTOP == gnome ]] && exit 0
[[ $XDG_SESSION_DESKTOP == KDE ]] && exit 0

RUNDIR=${XDG_RUNTIME_DIR:-/tmp/run-$UID}

rm -f $RUNDIR/theme
mkfifo $RUNDIR/theme

echo "Starting retrieval of theme information on port 19915..."
while nc -n 127.0.0.1 19915 </dev/null >$RUNDIR/theme
do true
done

# If we fail, delete the FIFO to not block scripts
rm $RUNDIR/theme
