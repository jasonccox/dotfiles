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

    # determine exit msg based on exit code
    if [ "$exit_code" != 0 ]; then
        local exit_msg="${RED}exit $exit_code$WHITE\n"
    fi

    # only show exit msg if a cmd was executed (user didn't just hit <Enter>)
    # (this requires that HISTTIMEFORMAT be set, otherwise entering the same
    # command twice in a row won't show the exit message)
    __2nd_last_cmd="$__last_cmd"
    __last_cmd="$(history 1)"
    if [ "$__last_cmd" == "$__2nd_last_cmd" ]; then
        exit_msg=""
    fi

    # try to use fancy path printer; otherwise fall back on \w
    local dir
    if [ -n "$__prompt_use_path_printer" ]; then
        dir="$(~/dotfiles/scripts/path-printer.bash -l 20)"
    else
        dir="\w"
    fi

    # only include git status if not in tmux - it's in the status bar there
    if [ -z "$TMUX" ]; then
        if [ -n "$__prompt_use_git" ]; then
            local git="$(~/dotfiles/scripts/git-info.bash \
                --prefix '  ' \
                --clean-color "$GREEN" \
                --default-color "$WHITE" \
                --dirty-color "$RED")"
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

PROMPT_DIRTRIM=2 # only show two deepest dirs with '\w'
PROMPT_COMMAND=__prompt
