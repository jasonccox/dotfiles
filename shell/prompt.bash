# prompt.bash
#
# Source this file in .bashrc to use a prompt that shows the last command's exit
# status, current directory, and git status info.
# Author: Jason Cox (dev@jasoncarloscox.com)

__prompt() {
    # preserve exit status
    local exit_code="$?"

    local DEFAULT='\[\e[m\]'
    local WHITE='\[\e[97;1m\]'
    local RED='\[\e[31;1m\]'
    local GREEN='\[\e[32;1m\]'
    local BLUE='\[\e[34;1m\]'
    local MAGENTA='\[\e[35;1m\]'
    local CYAN='\[\e[36m\]'

    # determine exit msg based on exit code
    if [ "$exit_code" != 0 ]; then
        local exit_msg="${RED}✖ $WHITE"
    else
        local exit_msg="${GREEN}✔ $WHITE"
    fi

    # only show exit msg if a cmd was executed (user didn't just hit <Enter>)
    __2nd_last_cmd="$__last_cmd"
    __last_cmd="$(history 1)"
    if [ "$__last_cmd" == "$__2nd_last_cmd" ]; then
        exit_msg=""
    fi

    # try to use fancy path printer; otherwise fall back on \w
    local dir
    if [ -n "$__prompt_use_path_printer" ]; then
        dir=" $(~/dotfiles/scripts/path-printer.bash -l 20)"
    else
        dir=" \w"
    fi

    # only include git status if not in tmux - it's in the status bar there
    if [ -z "$TMUX" ]; then
        if [ -n "$__prompt_use_git" ]; then
            local git="$(~/dotfiles/scripts/git-info.bash \
                --prefix '  שׂ ' \
                --clean "${GREEN}$WHITE" \
                --modified "${RED}$WHITE" \
                --untracked "${MAGENTA}$WHITE" \
                --staged "${GREEN}$WHITE" \
                --stashed "${BLUE}$WHITE" \
                --ahead '' \
                --behind '')"
        fi
    fi

    PS1="$exit_msg$WHITE[ $dir$git ] \\$ $DEFAULT"

    # refresh tmux status bar in background - run in subshell so job # not shown
    ( ([[ "$TMUX" ]] && tmux refresh-client -S) & )

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

# set folder icon if not already set - it's stored in a variable so it can be
# overwritten on systems that don't support the symbol
if [ -z "$__FOLDER_ICON" ]; then
    __FOLDER_ICON='🖿  '
fi

PROMPT_DIRTRIM=2 # only show two deepest dirs with '\w'
PROMPT_COMMAND=__prompt
