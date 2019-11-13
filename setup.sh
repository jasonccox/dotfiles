#!/bin/bash

# Link real configs to the ones in dotfiles

link() {
    ln -s "$(pwd)/$1" $2
}

# Bash
rm -f ~/.bash_profile ~/.bashrc
link bash/bash_profile ~/.bash_profile
link bash/bashrc ~/.bashrc

# Vim
rm -rf ~/.vim
link vim ~/.vim

# Git
rm -f ~/.gitconfig
link git/gitconfig ~/.gitconfig
