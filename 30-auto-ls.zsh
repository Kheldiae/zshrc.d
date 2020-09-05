#
# Specific Z shell configuration for auto-ls plugin
#

function auto-ls-readme() {
    [[ -f README     ]] && bat --paging=never README
    [[ -f README.md  ]] && bat --paging=never README.md
    [[ -f README.rst ]] && bat --paging=never README.rst
}

export AUTO_LS_COMMANDS=(readme "$(which lsd) --group-dirs=first" git-status "/bin/echo")
