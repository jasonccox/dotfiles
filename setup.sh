#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -sf "$(pwd)/$1" "$2"
}

setup_shell() {
    echo Setting up shell...
    [ -f shell/profile ] && link shell/profile ~/.profile
    link shell/bash_profile ~/.bash_profile
    link shell/bashrc ~/.bashrc
}

setup_vim() {
    echo Setting up vim...
    link vim ~/.vim

    if [ -f /usr/share/doc/fzf/examples/fzf.vim ]; then
        ln -s /usr/share/doc/fzf/examples/fzf.vim ~/.vim/plugin/fzf.vim
    fi
}

setup_git() {
    echo Setting up git...
    link git/gitconfig ~/.gitconfig
}

setup_tmux() {
    echo Setting up tmux...
    link tmux/tmux.conf ~/.tmux.conf

    if ! infocmp tmux-256color &> /dev/null; then
        tic -xe tmux-256color tmux/tmux-256color.terminfo
    fi
}

setup_pim() {
    echo Setting up PIM...
    mkdir -p ~/.config/khal ~/.config/todoman ~/.config/vdirsyncer
    link pim/khal.conf ~/.config/khal/config
    link pim/todoman.conf ~/.config/todoman/todoman.conf
    link pim/vdirsyncer.conf ~/.config/vdirsyncer/config

    echo Enter password for user jason for nextcloud.jlcox.com:
    keyring set nextcloud.jlcox.com jason

    mkdir -p ~/cal

    vdirsyncer discover
    vdirsyncer sync
    vdirsyncer metasync

    mkdir -p ~/.config/systemd/user
    link pim/vdirsyncer-sync.service ~/.config/systemd/user/vdirsyncer-sync.service
    link pim/vdirsyncer-sync.timer ~/.config/systemd/user/vdirsyncer-sync.timer

    systemctl --user start vdirsyncer-sync.timer
    systemctl --user enable vdirsyncer-sync.timer
}

setup_ssh() {
    echo Setting up SSH...
    mkdir -p ~/.ssh
    link ssh/config ~/.ssh/config

    link_authorized_keys=yes
    if [ -f ~/.ssh/authorized_keys ]; then
        read \
            -p "An authorized_keys file already exists - do you want to overwrite it? (y/N) " \
            answer
        if [[ "$answer" != y* ]] && [[ "$answer" != Y* ]]; then
            link_authorized_keys=no
        fi
    fi

    if [ "$link_authorized_keys" = yes ]; then
        link ssh/authorized_keys ~/.ssh/authorized_keys
    fi
}

setup_karabiner() {
    echo Settinp up Karabiner...
    mkdir -p ~/.config/karabiner
    link karabiner ~/.config/karabiner
}

setup_pop() {
    mkdir -p ~/.config/pop-shell

    link pop-shell-config.json ~/.config/pop-shell/config.json
}

# check for help arg
if [ "$1" = help ]; then
    echo "USAGE: ./setup.sh [shell] [vim] [git] [tmux] [pim] [ssh] [karabiner]"
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
        setup_"$1"
        shift
    done
else
    # setup everything
    setup_shell
    setup_vim
    setup_git
    setup_tmux
    setup_pim
    setup_ssh
    setup_karabiner
    setup_pop
fi
