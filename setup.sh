#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -s "$(pwd)/$1" "$2"
}

# Shell
rm -f ~/.profile ~/.bash_profile ~/.bashrc
link shell/profile ~/.profile
link shell/bash_profile ~/.bash_profile
link shell/bashrc ~/.bashrc

# Vim
rm -rf ~/.vim
link vim ~/.vim

# Git
rm -f ~/.gitconfig
link git/gitconfig ~/.gitconfig

# VS Code
mkdir -p "$HOME/.config/Code - OSS/User"
rm -rf "$HOME/.config/Code - OSS/User/settings.json" "$HOME/.config/Code - OSS/User/keybindings.json"
link vscode/settings.json "$HOME/.config/Code - OSS/User/settings.json"
link vscode/keybindings.json "$HOME/.config/Code - OSS/User/keybindings.json"
