#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -s "$(pwd)/$1" "$2"
}

setup_shell() {
    echo Setting up shell...
    rm -f ~/.profile ~/.bash_profile ~/.bashrc
    link shell/profile ~/.profile
    link shell/bash_profile ~/.bash_profile
    link shell/bashrc ~/.bashrc
}

setup_vim() {
    echo Setting up vim...
    rm -rf ~/.vim
    link vim ~/.vim
    vim +'silent! helptags ALL' +q
}

setup_git() {
    echo Setting up git...
    rm -f ~/.gitconfig
    link git/gitconfig ~/.gitconfig
}

setup_tmux() {
    echo Setting up tmux...
    rm -f ~/.tmux.conf
    link tmux/tmux.conf ~/.tmux.conf
}

setup_ssh() {
    echo Setting up SSH...
    mkdir -p ~/.ssh
    rm -f ~/.ssh/config
    link ssh/config ~/.ssh/config
}

# check for help arg
if [ "$1" = help ]; then
    echo "USAGE: ./setup.sh [shell] [vim] [git] [tmux] [ssh]"
    echo "If no arguments are provided, everything will be setup."
    exit 0
fi

# init git modules
echo Initializing git modules...
git submodule init
git submodule update

# check for other args
if [ "$1" ]; then
    # setup each thing specified in args
    while [ "$1" ]; do
        case "$1" in
            shell )     setup_shell
                        shift
                        ;;
            vim )       setup_vim
                        shift
                        ;;
            git )       setup_git
                        shift
                        ;;
            tmux )      setup_tmux
                        shift
                        ;;
            ssh )       setup_ssh
                        shift
                        ;;
        esac
    done
else
    # setup everything
    setup_shell
    setup_vim
    setup_git
    setup_tmux
    setup_ssh
fi
