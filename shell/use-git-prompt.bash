# use-git-prompt.bash
# Source this file in .bashrc to use a prompt that shows the git status info.

# load script providing __git_ps1 function used in prompt - it may be provided
# already with git completion, but I include it here to be safe.
[[ -f ~/dotfiles/shell/git-prompt.sh ]] && . ~/dotfiles/shell/git-prompt.sh

PROMPT_PRE_GIT="[\[\e[32m\]\W\[\e[m\]"
PROMPT_POST_GIT="]\\$ "

if command -v __git_ps1; then
    GIT_PS1_SHOWDIRTYSTATE="yes"
    GIT_PS1_SHOWSTASHSTATE="yes"
    GIT_PS1_SHOWUNTRACKEDFILES="yes"
    GIT_PS1_SHOWCOLORHINTS="yes"
    PROMPT_COMMAND="__git_ps1 \"$PROMPT_PRE_GIT\" \"$PROMPT_POST_GIT\""
else
    PS1="$PROMPT_PRE_GIT$PROMPT_POST_GIT"
fi

