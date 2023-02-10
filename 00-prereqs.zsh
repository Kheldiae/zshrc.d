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
            nix-env -iA ${:-nixpkgs.${^__FAILED_DEPS}}
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
            nix-env -iA ${:-nixpkgs.${^__FAILED_DEPS}}
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
        >&2 echo -n "Do you wish to install them using Nix? [Y/n] "

        read -q && >&2 echo \
            && {
            nix-env -iA ${:-nixpkgs.${^__FAILED_DEPS}}
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
    __deps::check   pandoc       pandoc
    __deps::check   zoxide       zoxide
    __deps::check   notify-send  libnotify
}

# Check if user cloned submodules, and ask if we can do it for them.
# Git is a required dependency, so we don't need to check for that.
function __deps::fetch_zplug() {
    if ! [[ -r $ZSH_CONFIG_PATH/zplug/init.zsh ]]
    then
        >&2 echo "zplug could not be found, most likely because this repository's"
        >&2 echo "submodules weren't cloned."
        >&2 echo -n "Do you wish to try retrieving them? [Y/n] "

        if ! (read -q && git -C $ZSH_CONFIG_PATH submodule update --init)
        then
            >&2 echo "This zsh config will not work without zplug."
            >&2 echo "Run \`git submodule update --init\` in the config directory then try again."
            exec zsh --no-rcs
        fi
    fi
}

if ! [[ -f $HOME/.zsh_has_deps ]]
then
    __deps::check   lsd         lsd
    __deps::check   bat         bat
    __deps::check   onefetch    onefetch
    __deps::check   git         git
    __deps::check   perl        perl
    __deps::check   grep        gnugrep
    __deps::check   find        findutils
    __deps::check   awk         gawk
    __deps::check   sed         gnused
    __deps::check   tar         gnutar
    __deps::check   tput        ncurses
    __deps::check   gzip        gzip
    __deps::check   curl        curl
    __deps::check   wget        wget
    __deps::resolve
    __deps::fetch_zplug
    touch $HOME/.zsh_has_deps   # Don't recheck every time

    __deps::check_optional
    __deps::resolve_optional
fi


unfunction __deps::resolve
unfunction __deps::resolve_optional
unfunction __deps::fetch_zplug

unset __FAILED_DEPS
