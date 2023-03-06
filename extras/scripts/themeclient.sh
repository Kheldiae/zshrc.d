#!/bin/bash
[[ -v SSH_TTY ]] || exit 0

RUNDIR=${XDG_RUNTIME_DIR:-/tmp/run-$UID}

rm -f $RUNDIR/theme
mkfifo $RUNDIR/theme

while nc -n 127.0.0.1 19915 </dev/null >$RUNDIR/theme
do true
done

# If we fail, delete the FIFO to not block scripts
rm $RUNDIR/theme
