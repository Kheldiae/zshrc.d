#
# Function definitions in Z shell
#

function _get_theme() {
    if [[ -v DESKTOP_THEME ]]
    then
        echo $DESKTOP_THEME
    elif [[ -r $XDG_RUNTIME_DIR/theme ]]
    then
        head -n1 $XDG_RUNTIME_DIR/theme | grep .
    elif ((IS_DARWIN))
    then
        ( defaults read -g AppleInterfaceStyle 2>/dev/null || echo 'light' ) | tr '[:upper:]' '[:lower:]'
    else
        echo 'dark'
    fi
}

function _kitty_color() {
    function __get_color() {
        if [[ `_get_theme` == "light" ]]
        then
            echo $colors_light[$1]
        else
            echo $colors_dark[$1]
        fi
    }

    if (( ${+KITTY_WINDOW_ID} ))
    then
        kitty @ set-colors background=$(__get_color $1)
        kitty @ set-background-opacity $2

        shift 2
        "$@"

        kitty @ set-colors -a -c ~/.config/kitty/kitty.conf
        kitty @ set-background-opacity $c_kitty_opacity[`< $XDG_RUNTIME_DIR/theme`]
    else
        shift 2
        "$@"
    fi
}

function bat() {
    export BAT_THEME=$([[ `_get_theme` == "light" ]] && <<< "Monokai Extended Light")
    $(which -p bat) "$@"
}

function b() {
    lang=$1

    shift 1
    bat -l$lang --style numbers "$@"
}

function duf() {
    $(which -p duf) -theme "$(_get_theme)" "$@"
}

function fetch() {
    neofetch --source ${c_fetch_image[`_get_theme`]}
}

function ifetch() {
    image=$1
    shift 1
    neofetch --source $image "$@"
}

function t() {
    twurl -d "status=$1" /1.1/statuses/update.json > /dev/null
}                           # Tweet to @sola10_mp4 instantly

function '$'() {
    a=
    while true
    do
        echo -n "$@> "
        read a
        { [[ "$a" =~ 'exit' ]] && break; } || eval "$@ $a"
    done
}                           # Turn any command into a prompt

function surf-md() {
    TARGET=$(mktemp "surf-md.XXXXXXXXXX.html" --tmpdir)
    pandoc -f markdown -t html $1 > $TARGET
    surf $TARGET
    rm $TARGET
}

function qr-echo() {
    QRFILE=$(mktemp "qr-echo.XXXXXXXXXX.png" --tmpdir)
    qrencode "$@" -o $QRFILE
    kitty +kitten icat $QRFILE
    rm $QRFILE
}

function is() {
    builtin which "$@" | bat -lzsh --style numbers
}

function sport() {
    echo "Now serving port ${2} to ${1}... (Ctrl+C to stop)"
    $(which -p ssh) -NL "${2}:127.0.0.1:${2}" "${1}"
}

function dsd-play() {
    dsf2flac -d -r 352800 -i $1 -o - 2>/dev/null \
        | ffmpeg -i - -r 352800 -c pcm_s32le -f alsa hw:1
}                           # Play back DSD files using DSD-over-PCM packing.
                            # WARNING: May damage equipment and/or hearing if
                            # played on unsupported hardware. Signal is not PCM
                            # sound.
