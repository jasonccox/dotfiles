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
    link clang_format ~/.clang-format
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

setup_vscode() {
    echo Setting up vscode...
    mkdir -p "$HOME/.config/Code - OSS/User"
    rm -rf "$HOME/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
    link vscode/settings.json "$HOME/.config/Code - OSS/User/settings.json"
    link vscode/keybindings.json "$HOME/.config/Code - OSS/User/keybindings.json"
}

setup_tmux() {
    echo Setting up tmux...
    rm -f ~/.tmux.conf
    link tmux/tmux.conf ~/.tmux.conf

    mkdir -p ~/.local/bin
    case "$OSTYPE" in
        linux*)     link tmux/gitmux-linux ~/.local/bin/gitmux ;;
        darwin*)    link tmux/gitmux-macos ~/.local/bin/gitmux ;;
    esac

    echo Installing tmux-mem and tmux-cpu \(you may be prompted for your password\)...
    (command -v nvm && nvm deactivate; sudo npm i -g tmux-mem tmux-cpu)
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
}

# check for help arg
if [ "$1" = help ]; then
    echo "USAGE: ./setup.sh [shell] [vim] [git] [tmux] [vscode] [pim] [ssh]"
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
            vscode )    setup_vscode
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
        esac
    done
else
    # setup everything
    setup_shell
    setup_vim
    setup_git
    setup_vscode
    setup_tmux
    setup_pim
    setup_ssh
fi
