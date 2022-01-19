#
# System configuration for the Z shell, completion style
#

# cd on directory name
setopt autocd

zstyle ':completion:*' completer        _expand _complete _ignored _approximate
zstyle ':completion:*' group-name       ''
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors      ''
zstyle ':completion:*' list-prompt      $'%{\e[38;5;232;48;5;144m%} SCROLL %{\e[38;5;144;48;5;232m%}%{\e[38;5;232;48;5;67m%}%{\e[38;5;253;48;5;67m%} At %p %{\e[K\e[0m%}'
zstyle ':completion:*' matcher-list     '' \
                                        'm:{[:lower:]}={[:upper:]} l:|=* r:|=*' \
                                        'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
zstyle ':completion:*' menu             select=long-list select=0 select=0
zstyle ':completion:*' original         true
zstyle ':completion:*' select-prompt    $'%{\e[38;5;232;48;5;81m%} SELECT %{\e[38;5;81;48;5;232m%}%{\e[38;5;232;48;5;67m%}%{\e[38;5;253;48;5;67m%} At %p %{\e[K\e[0m%}'
zstyle ':completion:*' verbose          true
zstyle ':compinstall'  filename         "$ZSH_CONFIG_PATH/01-zstyle.zsh"

autoload -Uz compinit       # Enables the smart completion engine configured above
