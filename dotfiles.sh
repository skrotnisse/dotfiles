#!/bin/bash

install_package() {
    if hash pacman 2>/dev/null; then
	sudo pacman -S $1
    elif hash apt-get 2>/dev/null; then
	sudo apt-get --yes install $1
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
    mv ~/.i3 ~/.dotfiles_backup 2>/dev/null
}

update_symlinks() {
    STOW_ARGS="$1 -vt ~"
    eval "(cd common && stow $STOW_ARGS git)"
    eval "(cd common && stow $STOW_ARGS zsh)"
    eval "(cd common && stow $STOW_ARGS gdb)"
    eval "(cd common && stow $STOW_ARGS emacs)"
    eval "(cd common && stow $STOW_ARGS irssi)"
    eval "(cd common && stow $STOW_ARGS i3)"
}


case $1 in
    
    "install") 
	# stow
        install_package stow

	# git
        install_package git

	# zsh
        install_package zsh
        curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

	# curl
        install_package curl

	# emacs
        install_package emacs23-nox
        install_package emacs-goodies

	# python pygments
        install_package python-pygments

	# irssi
	install_package irssi
        install_package irssi-plugin-xmpp

        # i3
        install_package i3

        # setup symlinks
	backup_configuration
	update_symlinks "-R"

        # switch to zsh
        chsh -s /bin/zsh

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
	echo -e "\tinstall \tInstalls applications and creates symlinks for all dotfiles."
	echo -e "\trefresh \tRefreshes all symlinks."
	echo -e "\tdelete  \tDeletes all symlinks."
	;;

esac
