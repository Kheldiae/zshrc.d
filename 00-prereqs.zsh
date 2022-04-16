#
# Prerequisite checking for my Z Shell config.
#

typeset -A __FAILED_DEPS

function __check_dependency() {
    if ! which -p "$1" &>/dev/null
    then
        __FAILED_DEPS[$1]="$2"
    fi
}

function __print_missing_deps() {
    for cmd in ${(k)__FAILED_DEPS}
    do
        >&2 echo "- $cmd"
    done
}

function __resolve_dependencies() {
    if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
    then
        return              # All deps matched
    fi

    >&2 echo "The following dependencies are missing:"
    __print_missing_deps

    if [[ -d /nix ]]
    then
        >&2 echo "It looks like Nix is installed on your system."
        >&2 echo -n "Do you want to try loading the missing commands? [y/N] "
        read -q && >&2 echo \
            && {
                for pkg in $__FAILED_DEPS
                do nix-env -iA nixpkgs.$pkg
                done
            }   \
            && return       # Nix installed our deps
    fi
    >&2 echo "This zsh config will not work without these programs."
    >&2 echo "Install the missing commands above then try again."
    exec zsh --no-rcs       # Bail out to rc-less zsh
}

function __resolve_optionaldeps() {
    if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
    then
        return              # All deps matched
    fi
    >&2 echo "The following optional dependencies are missing:"
    __print_missing_deps

    if [[ -d /nix ]]
    then
        >&2 echo "It looks like Nix is installed on your system."
        >&2 echo -n "Do you want to try loading the missing commands? [y/N] "
        read -q && >&2 echo \
            && {
                for pkg in $__FAILED_DEPS
                do nix-env -iA nixpkgs.$pkg
                done
            }   \
            && return       # Nix installed our deps
        >&2 echo
    fi

    >&2 echo "Some commands may not work properly without these programs."
    if [[ -d /nix ]]
    then
        >&2 echo "You can install them at any time by running 'install-deps'."
    else
        >&2 echo "Consider installing them through your system's package manager."
    fi
}

#NOTE: Public command
function install-deps() {
    if ! [[ -d /nix ]]
    then
        >&2 echo "This command only works on systems with Nix installed."
        return 1
    else
        __check_optionaldeps
        if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
        then
            >&2 echo "Looks like you're not missing anything right now."
            return              # All deps matched
        fi
        >&2 echo "The following dependencies will be installed:"
        __print_missing_deps
        >&2 echo -n "Do you wish to install them using Nix? [Y/n]"

        read -q && >&2 echo \
            && {
                for pkg in $__FAILED_DEPS
                do nix-env -iA nixpkgs.$pkg
                done
            }   \
            && return       # Nix installed our deps
    fi
}

function __check_optionaldeps() {
    unset __FAILED_DEPS
    typeset -Ag __FAILED_DEPS    # Reset list of failed dependencies
    __check_dependency neofetch     neofetch
    __check_dependency twurl        twurl
    __check_dependency qrencode     qrencode
    __check_dependency gst-play-1.0 gst_all_1.gst-plugins-base
    __check_dependency nom          nix-output-monitor
    __check_dependency qalc         libqalculate
    __check_dependency ,            comma
}

if ! [[ -f $HOME/.zsh_has_deps ]]
then
    __check_dependency lsd      lsd
    __check_dependency bat      bat
    __check_dependency onefetch onefetch
    __check_dependency git      git
    __resolve_dependencies
    touch $HOME/.zsh_has_deps   # Don't recheck every time

    __check_optionaldeps
    __resolve_optionaldeps
fi

unfunction __resolve_dependencies
unfunction __resolve_optionaldeps

unset __FAILED_DEPS
