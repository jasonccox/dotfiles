#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -s "$(pwd)/$1" $2
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
