#
# Configuration for Antigen plugins on the Z shell
# Implies Nix installed, but works without.
#

source $ANTIGEN_PATH

antigen use oh-my-zsh
antigen theme thesola10/nix-honukai-zsh

antigen bundle MichaelAquilina/zsh-you-should-use
antigen bundle MichaelAquilina/zsh-auto-notify

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle arzzen/calc.plugin.zsh

antigen bundle bilelmoussaoui/flatpak-zsh-completion
antigen bundle spwhitt/nix-zsh-completions
antigen bundle chisui/zsh-nix-shell

antigen bundle zuxfoucault/colored-man-pages_mod

antigen bundle desyncr/auto-ls

antigen apply

unalias _       # Disable oh-my-zsh alias for sudo
