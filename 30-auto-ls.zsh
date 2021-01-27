#
# Specific Z shell configuration for auto-ls plugin
#

function auto-ls-reset() { [[ ${WIDGET} == accept-line ]] && clear; }
function auto-ls-echo() { echo; }

function auto-ls-readme() {
    find . -maxdepth 1 -iname "README*" -exec bat --paging=never \{\} \;
}

function auto-ls-nix-sh() {
    [[ -v NIX_BUILD_SHELL ]] && return 0
    scanpath=$PWD
    while [[ "$(df $scanpath --output=target | tail -n 1)" == "$(df $PWD --output=target | tail -n 1)" ]] && [[ $scanpath != / ]]
    do
        find "$scanpath" -maxdepth 1 -mindepth 1 \
                     -type f         \
                     -readable       \
                     -name shell.nix \
        | grep . 2>&1 >/dev/null && \
        {
            echo -n "A Nix shell workspace was found. ($scanpath/shell.nix) Load? [y/N] "
            read -q && nix-shell $scanpath/shell.nix
            return 0
        }
        scanpath="$(readlink -f "$scanpath/..")"
    done
}

export AUTO_LS_COMMANDS=(reset readme "$(which lsd) --group-dirs=first" git-status nix-sh echo)
