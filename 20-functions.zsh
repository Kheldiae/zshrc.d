#
# Function definitions in Z shell
#

function kitty-color() {
    if (( ${+KITTY_WINDOW_ID} ))
    then
        kitty @ set-colors background=$1
        kitty @ set-background-opacity $2

        shift 2
        "$@"

        kitty @ set-colors -a -c ~/.config/kitty/kitty.conf
        kitty @ set-background-opacity $c_kitty_opacity
    else
        shift 2
        "$@"
    fi
}

function fetch() {
    neofetch --kitty $c_fetch_image --size 240 --color_blocks off \
                                               --disable resolution \
                                               --disable term_font \
                                               "${c_fetch_argextra[@]}"
}

function ifetch() {
    image=$1
    shift 1
    neofetch --kitty $image --size 240 --color_blocks off \
                                       --disable resolution \
                                       --disable term_font \
                                       $@
}

function t() {
    twurl -d "status=$1" /1.1/statuses/update.json > /dev/null
}                           # Tweet to @sola10_mp4 instantly

function '$'() {
    a=
    while ! [[ "$a" =~ 'exit' ]]
    do
        echo -n "$@> "
        read a
        eval "$@ $a"
    done
}                           # Turn any command into a prompt

function surf-md() {
    TARGET=$(mktemp "surf-md.XXXXXXXXXX.html" --tmpdir)
    pandoc -f markdown -t html $1 > $TARGET
    surf $TARGET
    rm $TARGET
}

function qr-echo {
    QRFILE=$(mktemp "qr-echo.XXXXXXXXXX.png" --tmpdir)
    qrencode "$@" -o $QRFILE
    kitty +kitten icat $QRFILE
    rm $QRFILE
}
