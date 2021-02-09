#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -s "$(pwd)/$1" "$2"
}

setup_shell() {
    echo Setting up shell...
    rm -f ~/.profile ~/.bash_profile ~/.bashrc
    [ -f shell/profile ] && link shell/profile ~/.profile
    link shell/bash_profile ~/.bash_profile
    link shell/bashrc ~/.bashrc
}

setup_vim() {
    echo Setting up vim...
    rm -rf ~/.vim
    link vim ~/.vim

    if [ -f /usr/share/doc/fzf/examples/fzf.vim ]; then
        ln -s /usr/share/doc/fzf/examples/fzf.vim ~/.vim/plugin/fzf.vim
    fi
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

    if ! infocmp tmux-256color &> /dev/null; then
        tic -xe tmux-256color tmux/tmux-256color.terminfo
    fi
}

setup_pim() {
    echo Setting up PIM...
    rm -f ~/.config/khal/config ~/.config/todoman/todoman.conf ~/.config/vdirsyncer/config
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

    rm -f ~/.config/systemd/user/vdirsyncer-sync.{service,timer}
    mkdir -p ~/.config/systemd/user
    link pim/vdirsyncer-sync.service ~/.config/systemd/user/vdirsyncer-sync.service
    link pim/vdirsyncer-sync.timer ~/.config/systemd/user/vdirsyncer-sync.timer

    systemctl --user start vdirsyncer-sync.timer
    systemctl --user enable vdirsyncer-sync.timer
}

setup_ssh() {
    echo Setting up SSH...
    mkdir -p ~/.ssh
    rm -f ~/.ssh/config
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
        rm -f ~/.ssh/authorized_keys
        link ssh/authorized_keys ~/.ssh/authorized_keys
    fi
}

setup_karabiner() {
    echo Settinp up Karabiner...
    mkdir -p ~/.config/karabiner
    rm -rf ~/.config/karabiner
    link karabiner ~/.config/karabiner
}

setup_pop() {
    mkdir -p ~/.config/pop-shell

    rm -f ~/.config/pop-shell/config.json
    link pop-shell-config.json ~/.config/pop-shell/config.json
}

setup_sway() {
    mkdir -p ~/.config

    rm -rf ~/.config/sway{,lock}
    rm -rf ~/.config/wofi
    rm -rf ~/.config/mako
    link sway/sway ~/.config/sway
    link sway/swaylock ~/.config/swaylock
    link sway/wofi ~/.config/wofi
    link sway/mako ~/.config/mako
}

setup_alacritty() {
    mkdir -p ~/.config

    rm -rf ~/.config/alacritty
    link alacritty ~/.config/alacritty
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
    setup_sway
    setup_alacritty
fi
