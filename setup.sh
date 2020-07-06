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
    rm -rf ~/.vim ~/.clang-format
    link vim ~/.vim
    link clang-format ~/.clang-format
    if command -v yay &> /dev/null; then
        echo Installing C language server \(you may be prompted for your password\)...
        yay -S --noconfirm ccls
    fi
    vim +"CocInstall -sync coc-tsserver coc-html coc-css coc-yaml coc-sh" +"silent! helptags ALL" +"q"
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

    echo Enter password for user jason for cloud.jasoncarloscox.com:
    keyring set cloud.jasoncarloscox.com jason

    mkdir -p ~/cal

    vdirsyncer discover
    vdirsyncer sync
    vdirsyncer metasync

    rm -f ~/.config/autostart-scripts/vdir_autosync
    mkdir -p ~/.config/autostart-scripts/
    link pim/vdir_autosync ~/.config/autostart-scripts/vdir_autosync
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

setup_fonts() {
    echo Setting up fonts...

    if command -v yay &> /dev/null; then
        echo You may be prompted for you password to install the fonts
        yay -S --noconfirm nerd-fonts-hack
    elif command -v brew &> /dev/null; then
        brew cask install font-hack-nerd-font
    else
        echo Neither yay nor brew is available. You\'ll have to install the \
            Hack Nerd fonts yourself.
    fi

    echo Be sure to set your terminal font to Hack Nerd Font Mono!
}

# check for help arg
if [ "$1" = help ]; then
    echo "USAGE: ./setup.sh [shell] [vim] [git] [tmux] [pim] [ssh] [karabiner] [fonts]"
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
            pim )       setup_pim
                        shift
                        ;;
            ssh )       setup_ssh
                        shift
                        ;;
            karabiner ) setup_karabiner
                        shift
                        ;;
            fonts )     setup_fonts
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
    setup_pim
    setup_ssh
    setup_karabiner
    setup_fonts
fi
