# prompt.bash
#
# Source this file in .bashrc to use a prompt that shows the last command's exit
# status, current directory, and git status info.
# Author: Jason Cox (dev@jasoncarloscox.com)

__prompt() {
    # preserve exit status
    local exit_code="$?"

    # create part before git prompt
    local DEFAULT='\[\e[m\]'
    local WHITE='\[\e[97;1m\]'
    local RED='\[\e[31;1m\]'
    local GREEN='\[\e[32;1m\]'
    local BLUE='\[\e[34;1m\]'
    local MAGENTA='\[\e[35;1m\]'
    local CYAN='\[\e[36m\]'

    # determine exit msg based on exit code
    if [ "$exit_code" != 0 ]; then
        local exit_msg="$RED✖ $WHITE"
    else
        local exit_msg="$GREEN✔ $WHITE"
    fi

    # try to use fancy path printer; otherwise fall back on \w
    local dir
    if [ -n "$__prompt_use_path_printer" ]; then
        dir="🖿  $(~/dotfiles/scripts/path-printer.bash -l 20)"
    else
        dir="🖿  \w"
    fi

    # only include git status if not in tmux - it's in the status bar there
    if [ -z "$TMUX" ]; then
        if [ -n "$__prompt_use_git" ]; then
            local git="$(~/dotfiles/scripts/git-info.bash \
                --prefix '  ⎇  ' \
                --clean "$GREEN✔$WHITE" \
                --modified "$REDΔ$WHITE" \
                --untracked "$MAGENTA✚$WHITE" \
                --staged "$GREEN●$WHITE" \
                --stashed "$BLUE⚑$WHITE")"
        fi
    fi

    PS1="$exit_msg[ $dir$git ] \\$ $DEFAULT"

    return $exit_code
}

# use script providing git info if present
if [ -f ~/dotfiles/scripts/git-info.bash ]; then
    __prompt_use_git=yes
fi

# use script providing path printing if present
if [ -f ~/dotfiles/scripts/path-printer.bash ]; then
    __prompt_use_path_printer=yes
fi

PROMPT_DIRTRIM=2 # only show two deepest dirs with '\w'
PROMPT_COMMAND=__prompt
