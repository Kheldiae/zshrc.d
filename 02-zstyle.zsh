#
# System configuration for the Z shell, completion style
#

# cd on directory name, comments on command line
setopt autocd interactivecomments

zstyle ':completion:*' completer        _expand _complete _ignored _approximate
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*' group-name       ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors      ''
zstyle ':completion:*' list-prompt      $'%{\e[38;2;230;219;116m\e[38;5;232;48;2;230;219;116m%} SCROLL %{\e[38;5;15;48;2;48;48;48m%} At %p %{\e[38;2;48;48;48;40m%} %{\e[0m%}'
zstyle ':completion:*' matcher-list     '' \
                                        'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' \
                                        'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' menu             select=long-list select=0 select=0
zstyle ':completion:*' original         true
zstyle ':completion:*' select-prompt   $'%{\e[38;2;128;160;255m\e[38;5;232;48;2;128;160;255m%} SELECT %{\e[38;5;15;48;2;48;48;48m%} At %p %{\e[38;2;48;48;48;40m%}%{\e[0m%}'
zstyle ':completion:*' verbose          true
zstyle ':completion:*' file-list        all
zstyle ':compinstall'  filename         "$ZSH_CONFIG_PATH/02-zstyle.zsh"

autoload -Uz compinit       # Enables the smart completion engine configured above
