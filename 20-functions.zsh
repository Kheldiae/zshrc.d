#
# Function definitions in Z shell
#

function _get_theme() {
    RUNDIR=${XDG_RUNTIME_DIR:-/tmp/run-$UID}
    if [[ -v DESKTOP_THEME ]]
    then
        echo $DESKTOP_THEME
    elif [[ -r $RUNDIR/theme ]]
    then
        head -n1 $RUNDIR/theme | grep .
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
        kitty @ set-background-opacity $c_kitty_opacity[`_get_theme`]
    else
        shift 2
        "$@"
    fi
}

function bat() {
    export BAT_THEME=$(if [[ `_get_theme` == "light" ]]; then <<< "gruvbox-light"; else <<< "gruvbox-dark"; fi)
    $(which -p bat) "$@" --italic-text always
}

function b() {
    lang=$1

    shift 1
    bat -l$lang --style numbers "$@"
}

function pat() {
    pandoc "$@" -w markdown | bat -l markdown --file-name "$1"
}

function duf() {
    $(which -p duf) -theme "$(_get_theme)" "$@"
}

function fetch() {
    [[ $TERM == xterm-kitty ]] && kitty @resize-os-window --height 34
    neofetch --source ${c_fetch_image[`_get_theme`]}
}

function ifetch() {
    image=$1
    shift 1
    neofetch --source $image "$@"
}

function t() {
    twurl -d "status=$1" /1.1/statuses/update.json &>/dev/null
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

function z() {
    if [[ $# == 0 ]]
    then
        >&2 echo "Usage: z <query> [command]"
        return 1
    elif [[ $# == 1 ]]
    then
        zoxide query "$1"
    else
        DIR="$1"
        shift 1
        (AUTO_LS_COMMANDS= __zoxide_z "$DIR" && "$@")
    fi
}

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

function ijava() {
    [ -f "$PWD/settings.gradle" ] && gradle build
    local IJAVA_CLASSPATH
    local jarfiles=(./*/build/libs/*.jar(N) ./build/libs/*.jar(N))
    for file in $jarfiles
    do
        IJAVA_CLASSPATH="$file:$IJAVA_CLASSPATH"
    done
    IJAVA_CLASSPATH="$IJAVA_CLASSPATH" jupyter console --kernel java
}                           # Invoke IJava Jupyter kernel with smart classpath
                            # if we're in a Gradle workspace.

function watt() {
    qalc -t $(sensors -A BAT0-acpi-0 | cut -sd' ' -f2- | sed ':a; N; $!ba; s/\n/*/g')
}                           # Parse sensors data to gather real-time battery
                            # flow/drain in watts

function dsd-play() {
    dsf2flac -d -r 352800 -i $1 -o - 2>/dev/null \
        | ffmpeg -i - -r 352800 -c pcm_s32le -f alsa hw:1
}                           # Play back DSD files using DSD-over-PCM packing.
                            # WARNING: May damage equipment and/or hearing if
                            # played on unsupported hardware. Signal is not PCM
                            # sound.

function gtree() {
    REPO_ROOT=$(git rev-parse --show-toplevel || return 1)
    lsd --tree $(while read m; do <<<"-I $m"; done <$REPO_ROOT/.gitignore)
}

if which -p nom &>/dev/null
then
    function nix-build()    { $(which -p nix-build) $@ |& nom; }
    function nix-env()      { $(which -p nix-env) $@ |& nom; }
    function nixos-rebuild(){ $(which -p nixos-rebuild) $@ |& nom; }
fi
