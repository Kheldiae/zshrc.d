#
# Prerequisite checking for my Z Shell config.
#

typeset -a __FAILED_DEPS

function __check_dependency() {
    if ! which -p "$1" >/dev/null
    then
        __FAILED_DEPS+="$1"
    fi
}

function __print_missing_deps() {
    for cmd in $__FAILED_DEPS
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
        read -q && echo \
            && nix-env -i $__FAILED_DEPS \
            && return       # Nix installed our deps
    fi
    >&2 echo "This zsh config will not work without these programs."
    >&2 echo "Install the missing commands above then try again."
    exec zsh --no-rcs       # Bail out to rc-less zsh
}

if ! [[ -f $HOME/.cache/zsh_has_deps ]]
then
    __check_dependency lsd
    __check_dependency bat
    __check_dependency onefetch
    __check_dependency git
    __resolve_dependencies
    touch $HOME/.cache/zsh_has_deps # Don't recheck every time
fi

unfunction __check_dependency
unfunction __print_missing_deps
unfunction __resolve_dependencies
