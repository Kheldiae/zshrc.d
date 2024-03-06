#
# Extra configuration installer for third-party apps.
#

typeset -a __MISSING_CONFS


function __extras::systemd_enable() {
    for u in $EXTRAS_CONFIG_PATH/systemd/*
    do
        if ! [[ -e $HOME/.config/systemd/user/$u:t ]]
        then
            mkdir -p $HOME/.config/systemd/user
            ln -s $u $HOME/.config/systemd/user/$u:t
            systemctl --user enable $u:t
        fi
    done
}

function __extras::check() {
    [[ -f $HOME/.zsh_has_extras ]] && return
    for d in $EXTRAS_CONFIG_PATH/extras/*
    do
        if [[ -e $HOME/.config/$d:t ]] && \
            [[ "$(readlink $HOME/.config/$d:t)" != "$d" ]]
        then
            __MISSING_CONFS+="$d:t"
        elif ! [[ -e $HOME/.config/$d:t ]]
        then
            __MISSING_CONFS+="$d:t"
        fi
    done
    if [[ ${#__MISSING_CONFS[@]} -eq 0 ]]
    then
        touch $HOME/.zsh_has_extras
    fi
}

function __extras::print_missing() {
    for d in ${__MISSING_CONFS[@]}
    do
        >&2 echo "- $d"
    done
}

function __extras::install() {
    if [[ -e $HOME/.config/$1 ]]
    then
        >&2 echo "An existing configuration was found for '$1'."
        >&2 echo -n "Replace it? [y/N] "
        read -q || return
        mv $HOME/.config/$1 $HOME/.config.backup/$1
    fi
    if [[ $1 =~ .dconf$ ]]
    then
        dconf load / < $EXTRAS_CONFIG_PATH/extras/$1
    else
        ln -s $EXTRAS_CONFIG_PATH/extras/$1 $HOME/.config/$1
    fi
}

function install-extras() {
    __extras::check
    if ! [[ -f $HOME/.zsh_has_extras ]]
    then
        >&2 echo "For the best experience, the following additional configs"
        >&2 echo "can be installed:"
        mkdir -p $HOME/.config.backup
        __extras::print_missing
        >&2 echo -n "Proceed? [y/N] "
        if read -q
        then
            pgrep systemd >/dev/null && __extras::systemd_enable
            for d in ${__MISSING_CONFS[@]}
            do
                __extras::install $d
            done
        elif [[ -v FIRST ]]
        then
            >&2 echo "You can always install configs using 'install-extras'"
            touch $HOME/.zsh_asked_extras
        fi
    elif ! [[ -v FIRST ]]
    then
        >&2 echo "Extra configs have already been installed."
    fi
}

if ! [[ -v ZSH_CONFIG_DEMO ]]
then
(){
    local EXTRAS_CONFIG_PATH
    # Do not create config symlinks to our Nix Store path, instead use a layer
    # of indirection to keep things up-to-date.
    if [[ $ZSH_CONFIG_PATH =~ ^/nix/store ]]
    then
        [[ -L $HOME/.config/zshrc.d ]] \
            && [[ $(readlink ~/.config/zshrc.d) =~ ^/nix/store ]] \
            && ln -fsn $ZSH_CONFIG_PATH $HOME/.config/zshrc.d
            # Update existing link
        [[ -e $HOME/.config/zshrc.d ]] \
            || ln -s $ZSH_CONFIG_PATH $HOME/.config/zshrc.d
            # Create link for the first time
        EXTRAS_CONFIG_PATH=$HOME/.config/zshrc.d
    else
        EXTRAS_CONFIG_PATH=$ZSH_CONFIG_PATH
    fi

    [[ -f $HOME/.zsh_asked_extras ]] || \
        FIRST=1 EXTRAS_CONFIG_PATH=$EXTRAS_CONFIG_PATH install-extras
}
fi
