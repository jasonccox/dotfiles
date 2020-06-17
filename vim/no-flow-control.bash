# no-flow-control.bash - Disable flow control when running vim from bash so that
# ctrl-s and ctrl-q get passed to vim. Source this script in .bashrc.
#
# Author: Jason Cox (dev@jasoncarloscox.com)
# Original source: https://vim.fandom.com/wiki/Map_Ctrl-S_to_save_current_or_new_files

vim() {
    # save stty options
    if [ "$(uname)" = Darwin ]; then
        local sttyopts="$(stty -g)"
    else
        local sttyopts="$(stty -save)"
    fi

    # turn off flow control
    stty stop '' -ixoff

    # run vim
    command vim "$@"

    # restore stty options
    stty "$sttyopts"
}
