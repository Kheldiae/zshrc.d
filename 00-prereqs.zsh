#
# Prerequisite checking for my Z Shell config.
#

typeset -A __FAILED_DEPS

function __deps::check() {
    if ! which -p "$1" &>/dev/null
    then
        __FAILED_DEPS[$1]="$2"
    fi
}

function __deps::print_missing() {
    for cmd in ${(k)__FAILED_DEPS}
    do
        >&2 echo "- $cmd"
    done
}

function __deps::resolve() {
    if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
    then
        return              # All deps matched
    fi

    >&2 echo "The following dependencies are missing:"
    __deps::print_missing

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

function __deps::resolve_optional() {
    if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
    then
        return              # All deps matched
    fi
    >&2 echo "The following optional dependencies are missing:"
    __deps::print_missing

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
        __deps::check_optional
        if [[ ${#__FAILED_DEPS[@]} -eq 0 ]]
        then
            >&2 echo "Looks like you're not missing anything right now."
            return              # All deps matched
        fi
        >&2 echo "The following dependencies will be installed:"
        __deps::print_missing
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

function __deps::check_optional() {
    unset __FAILED_DEPS
    typeset -Ag __FAILED_DEPS    # Reset list of failed dependencies
    __deps::check   neofetch     neofetch
    __deps::check   twurl        twurl
    __deps::check   qrencode     qrencode
    __deps::check   gst-play-1.0 gst_all_1.gst-plugins-base
    __deps::check   nom          nix-output-monitor
    __deps::check   qalc         libqalculate
    __deps::check   ,            comma
}

if ! [[ -f $HOME/.zsh_has_deps ]]
then
    __deps::check   lsd      lsd
    __deps::check   bat      bat
    __deps::check   onefetch onefetch
    __deps::check   git      git
    __deps::resolve
    touch $HOME/.zsh_has_deps   # Don't recheck every time

    __deps::check_optional
    __deps::resolve_optional
fi

unfunction __deps::resolve
unfunction __deps::resolve_optional

unset __FAILED_DEPS
