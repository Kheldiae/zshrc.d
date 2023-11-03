#
# Function definitions in Z shell
#

function _get_theme() {
    local rundir=${XDG_RUNTIME_DIR:-/tmp/run-$UID}
    if [[ -v DESKTOP_THEME ]]
    then
        echo $DESKTOP_THEME
    elif [[ -r $rundir/theme ]]
    then
        head -n1 $rundir/theme | grep .
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
    local BAT_THEME
    export BAT_THEME=$(if [[ `_get_theme` == "light" ]]; then <<< "gruvbox-light"; else <<< "gruvbox-dark"; fi)
    command bat "$@" --italic-text always
}

function b() {
    local lang=$1
    shift 1
    bat -l$lang --style numbers "$@"
}

function pat() {
    pandoc "$@" -w markdown | bat -l markdown --file-name "$1"
}

function duf() {
    command duf -theme "$(_get_theme)" "$@"
}

function fetch() {
    [[ $TERM == xterm-kitty ]] && kitty @resize-os-window --height 34
    neofetch --source ${c_fetch_image[`_get_theme`]}
}

function ifetch() {
    local image=$1
    shift 1
    neofetch --source $image "$@"
}

function '$'() {
    if [[ $# == 0 ]]
    then
        >&2 echo "Usage: $ <command>..."
        return 1
    fi
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
        local DIR="$1"
        shift 1
        (AUTO_LS_COMMANDS= __zoxide_z "$DIR" && "$@")
    fi
}

function surf-md() {
    local target=$(mktemp "surf-md.XXXXXXXXXX.html" --tmpdir)
    pandoc -f markdown -t html $1 > $target
    surf $target
    rm $target
}

function qr-echo() {
    local qrfile=$(mktemp "qr-echo.XXXXXXXXXX.png" --tmpdir)
    qrencode "$@" -o $qrfile
    sleep .1
    kitty +kitten icat $qrfile
    sleep .1
    rm $qrfile
}

function is() {
    builtin which "$@" | bat -lzsh --style numbers
}

function sport() {
    echo "Now serving port ${2} to ${1}... (Ctrl+C to stop)"
    command ssh -NL "${2}:127.0.0.1:${2}" "${1}"
}

function sslcat() {
    if [[ $# -ge 2 ]]
    then
        hs=$1
        pt=$2
        shift 2
        openssl s_client -connect "${hs}:${pt}" "$@"
    else
        >&2 echo "Usage: sslcat <host> <port> [openssl options]"
        return 1
    fi
}

function ijava() {
    if [ -f "$PWD/settings.gradle" ]
        then gradle build
    elif [ -f "$PWD/pom.xml" ]
        then mvn compile
    fi
    local IJAVA_CLASSPATH
    local jarfiles=(./*/build/libs/*.jar(N) ./build/libs/*.jar(N) ./target/classes)
    for file in $jarfiles
    do
        IJAVA_CLASSPATH="$file:$IJAVA_CLASSPATH"
    done
    IJAVA_CLASSPATH="$PWD:$IJAVA_CLASSPATH" jupyter console --kernel java
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
    local REPO_ROOT=$(git rev-parse --show-toplevel || return 1)
    lsd --tree $(while read m; do <<<"-I $m"; done <$REPO_ROOT/.gitignore)
}

if which -p nom &>/dev/null
then
    function nix-build()    { $(which -p nix-build) $@ |& nom; }
    function nix-env()      { $(which -p nix-env) $@ |& nom; }
    function nixos-rebuild(){ $(which -p nixos-rebuild) $@ |& nom; }
fi
