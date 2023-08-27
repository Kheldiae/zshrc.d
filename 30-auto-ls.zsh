#
# Specific Z shell configuration for auto-ls plugin
#

function auto-ls-reset() { [[ ${WIDGET} == accept-line ]] && clear; }
function auto-ls-echo() { echo; }
function auto-ls-lsd() { lsd --group-dirs=first; }

function auto-ls-readme() {
    [[ ${WIDGET} == accept-line ]] && return 0
    for f in $(find . -maxdepth 1 -iname "README*")
    do
        bat --style numbers,header --paging=never $f
        echo
    done
}

function auto-ls-onefetch() {
    if git status &>/dev/null
    then
        if [ -v IN_NIX_SHELL ]
        then gfi=$c_gitfetch_nix_shell_image
        else gfi=$c_gitfetch_image
        fi

        onefetch --image-protocol kitty --image $gfi --no-color-palette
        git status -s
        echo
    fi
}

function auto-ls-nix-flake() {
    export SKIP_NIX_SHELL_SCAN=0
    [[ ${WIDGET} == accept-line ]]  && return 0 # newline widget broken

    if ! ( find --version     | grep GNU \
        && df --version       | grep GNU \
        && readlink --version | grep GNU) &>/dev/null
    then
        echo "The Nix flake file scanner requires the GNU coreutils and findutils."
        return 0
    fi          # wrong df, wrong find, or wrong readlink.

    function _choose_nix_dev() {
        nsys=$(nix show-config --json | jq -r .system.value)

        if _=$(nix flake show "$1" --json 2>/dev/null | jq -r .devShells.\"$nsys\"\[\] 2>/dev/null)
        then
            >&2 echo -e "A Nix flake was found. ($scanpath/flake.nix)"
            nss="$(nix flake show "$1" --json 2>/dev/null | jq -r .devShells.\"$nsys\"\|keys\[\])"
            if (( $(wc -l <<< $nss) == 1 ))
            then
                >&2 echo -ne "Load development shell '$nss'? [y/N] "
                read -q && echo "devShells.$nsys.$nss"
            else
                >&2 echo "This flake provides several development shells."
                mysh=$(fzy -p "Shell (ESC to cancel): " <<< $nss) && echo "devShells.$nsys.$mysh"
            fi
        elif _=$(nix flake show "$1" --json 2>/dev/null | jq -r .packages.\"$nsys\"\[\] 2>/dev/null)
        then
            >&2 echo -e "A Nix flake was found. ($scanpath/flake.nix)"
            nss="$(nix flake show "$1" --json 2>/dev/null | jq -r .packages.\"$nsys\"\|keys\[\])"
            if (( $(wc -l <<< $nss) == 1 ))
            then
                >&2 echo -ne "Load development shell from package '$nss'? [y/N] "
                read -q && echo "packages.$nsys.$nss"
            else
                >&2 echo "This flake provides several packages."
                mysh=$(fzy -p "Package (ESC to cancel): " <<< $nss) && echo "packages.$nsys.$mysh"
            fi
        else
            return 1
        fi
    }

    scanpath=$PWD
    while [[ "$(df $scanpath --output=target | tail -n 1)" == "$(df $PWD --output=target | tail -n 1)" ]] && [[ $scanpath != / ]]
    do
        timeout .2s \
        find "$scanpath" -maxdepth 1 -mindepth 1 \
                    -type f         \
                    -readable       \
                    -name flake.nix 2>/dev/null \
        | grep . &>/dev/null && \
        {
            ns=$(_choose_nix_dev "$scanpath") && {
                tput cr; tput el
                echo -ne "`tput tsl`Building Nix flake shell...`tput fsl`"
                export OLDPYTHON="$(which -p python)"
                nix develop "$scanpath#$ns" -c zsh
            }
            export SKIP_NIX_SHELL_SCAN=1
            return 0
        }
        scanpath="$(readlink -f "$scanpath/..")"
    done
}

function auto-ls-nix-shell() {
    [[ $SKIP_NIX_SHELL_SCAN == 1 ]] && return 0 # Don't scan both flakes and shells
    [[ ${WIDGET} == accept-line ]]  && return 0 # newline widget broken

    if ! ( find --version     | grep GNU \
        && df --version       | grep GNU \
        && readlink --version | grep GNU) &>/dev/null
    then
        echo "The Nix shell file scanner requires the GNU coreutils and findutils."
        return 0
    fi          # Wrong df, wrong find, or wrong readlink.

    scanpath=$PWD
    while [[ "$(df $scanpath --output=target | tail -n 1)" == "$(df $PWD --output=target | tail -n 1)" ]] && [[ $scanpath != / ]]
    do
        scanshell="$(timeout .2s \
                     find "$scanpath" -maxdepth 1 -mindepth 1 \
                                      -type f         \
                                      -readable       \
                                      \( -name shell.nix -or -name default.nix \) 2>/dev/null)"
        grep . &>/dev/null <<<"$scanshell" && \
        {
            if grep 'shell\.nix' &>/dev/null <<<"$scanshell" \
                && grep 'default\.nix' &>/dev/null <<<"$scanshell"
            then
                scanshell="$scanpath/shell.nix"
            fi
            echo -ne "A Nix shell workspace was found. ($scanshell)\nLoad? [y/N] "
            read -q && {
                tput cr; tput el
                echo -ne "`tput tsl`Building Nix shell...`tput fsl`"
                export OLDPYTHON="$(which -p python)"
                nix-shell $scanshell
            }
            return 0
        }
        scanpath="$(readlink -f "$scanpath/..")"
    done
}

export AUTO_LS_COMMANDS=(reset readme onefetch lsd echo)
