#
# Configuration for Antigen plugins on the Z shell
# Implies Nix installed, but works without.
#

source $ZSH_CONFIG_PATH/zplug/init.zsh

zplug "romkatv/powerlevel10k",              as:theme

zplug "MichaelAquilina/zsh-you-should-use"
zplug "MichaelAquilina/zsh-auto-notify"

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

zplug "bilelmoussaoui/flatpak-zsh-completion"
zplug "spwhitt/nix-zsh-completions"
zplug "chisui/zsh-nix-shell"

zplug "zuxfoucault/colored-man-pages_mod"

zplug "desyncr/auto-ls"

# Terminal title
zplug "lib/termsupport",                    from:oh-my-zsh
zplug "lib/key-bindings",                   from:oh-my-zsh
zplug "lib/directories",                    from:oh-my-zsh
zplug "lib/completion",                     from:oh-my-zsh
zplug "lib/history",                        from:oh-my-zsh
zplug "plugins/aliases",                    from:oh-my-zsh


if ! zplug check --verbose
then
    printf "Install zsh plugins? (this may take a while) [y/N] "
    read -q && { echo; zplug install; }
fi

zplug load

