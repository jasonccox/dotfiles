# use-git-prompt.bash
# Source this file in .bashrc to use a prompt that shows the git status info.

# load script providing __git_ps1 function used in prompt - it may be provided
# already with git completion, but I include my own tweaked version.
[[ -f ~/dotfiles/shell/git-prompt.sh ]] && . ~/dotfiles/shell/git-prompt.sh

PROMPT_DIRTRIM=2 # only show two deepest dirs with '\w'

__prompt_pre_git() {
    local EXIT_CODE="$?"
    local DEFAULT='\[\e[m\]'
    local RED='\[\e[31;1m\]'
    local GREEN='\[\e[32;1m\]'
    local CYAN='\[\e[36m\]'

    # determine exit msg based on exit code
    if [ "$EXIT_CODE" != 0 ]; then
        local exit_msg="$RED✖ $DEFAULT"
    else
        local exit_msg="$GREEN✔ $DEFAULT"
    fi

    echo "$exit_msg[ 🖿  $CYAN\w$DEFAULT"
}

PROMPT_POST_GIT=" ] \\$ "

# use git prompt if available
if command -v __git_ps1 &> /dev/null; then
    GIT_PS1_SHOWDIRTYSTATE="yes"
    GIT_PS1_SHOWSTASHSTATE="yes"
    GIT_PS1_SHOWUNTRACKEDFILES="yes"
    GIT_PS1_SHOWUPSTREAM="yes"
    GIT_PS1_SHOWCOLORHINTS="yes"
    GIT_PS1_STATESEPARATOR=""
    PROMPT_COMMAND="__git_ps1 \"\$(__prompt_pre_git)\" \"$PROMPT_POST_GIT\" \"  ⎇  %s\""
else
    PROMPT_COMMAND="PS1=\"\$(__prompt_pre_git)$PROMPT_POST_GIT"\"
fi

