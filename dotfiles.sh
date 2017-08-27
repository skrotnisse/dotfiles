#!/bin/bash

install_package() {
    echo -e "--------------------------------------------------------------------"
    echo -e "---- Installing $1"
    echo -e "--------------------------------------------------------------------"
    if hash pacman 2>/dev/null; then
	sudo pacman -S -q $1
    elif hash apt-get 2>/dev/null; then
	sudo apt-get --yes -qq install $1
    elif hash brew 2>/dev/null; then
	brew install $1
    fi
}

backup_configuration() {
    mkdir -p ~/.dotfiles_backup
    mv ~/.gitconfig ~/.dotfiles_backup 2>/dev/null
    mv ~/.gitconfig_global ~/.dotfiles_backup 2>/dev/null
    mv ~/.zshrc ~/.dotfiles_backup 2>/dev/null
    mv ~/.gdbinit ~/.dotfiles_backup 2>/dev/null
    mv ~/.emacs ~/.dotfiles_backup 2>/dev/null
    mv ~/.irssi ~/.dotfiles_backup 2>/dev/null
    mv ~/.xinitrc ~/.dotfiles_backup 2>/dev/null
    mv ~/.Xresources ~/.dotfiles_backup 2>/dev/null
    mv ~/.i3 ~/.dotfiles_backup 2>/dev/null
}

update_symlinks() {
    STOW_ARGS="$1 -vt ~"
    eval "(cd common && stow $STOW_ARGS git)"
    eval "(cd common && stow $STOW_ARGS zsh)"
    eval "(cd common && stow $STOW_ARGS gdb)"
    eval "(cd common && stow $STOW_ARGS emacs)"
    eval "(cd common && stow $STOW_ARGS irssi)"
    eval "(cd common && stow $STOW_ARGS xorg)"
    eval "(cd common && stow $STOW_ARGS i3)"
}

case $1 in

    "install")
        echo -e "--------------------------------------------------------------------"
        echo -e "---- Dotfiles: INSTALLING                                        ---"
        echo -e "--------------------------------------------------------------------"
	# git (should already be installed)
        install_package git

	# various applications and dependencies
        install_package curl
        install_package stow
        install_package net-tools
        install_package python-pygments

	# zsh
        install_package zsh
        curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

	# emacs
        install_package emacs-nox
        install_package emacs-goodies-el
        install_package elpa-magit

	# irssi
	install_package irssi
        install_package irssi-plugin-xmpp

        # i3
        install_package i3
        install_package feh
	mkdir -p ~/wallpapers

        # i3
        install_package rxvt-unicode

        # setup symlinks
	backup_configuration
	update_symlinks "-R"

        # switch to zsh
        sudo chsh -s /bin/zsh $(whoami)

        echo -e "--------------------------------------------------------------------"
        echo -e "---- Dotfiles: COMPLETED                                         ---"
        echo -e "--------------------------------------------------------------------"
        echo -e "---- NOTE:                                                       ---"
        echo -e "----    X needs to be restarted for all changes to be activated. ---"
        echo -e "--------------------------------------------------------------------"

	;;

    "refresh")
	update_symlinks "-R"
	;;

    "delete")
	update_symlinks "-D"
	;;

    *)
	echo -e "Usage: dotfiles.sh <command>\n"
	echo -e "The commands are:"
	echo -e "\tinstall \tInstalls applications and creates symlinks."
	echo -e "\trefresh \tRefreshes all symlinks."
	echo -e "\tdelete  \tDeletes all symlinks."
	;;

esac
