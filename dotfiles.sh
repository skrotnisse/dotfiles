#!/bin/bash

install_package() {
    if hash pacman 2>/dev/null; then
	sudo pacman -S $1
    elif hash apt-get 2>/dev/null; then
	sudo apt-get install $1
    elif hash brew 2>/dev/null; then
	brew install $1
    fi
}

ensure_command() {
    if hash $1 2>/dev/null; then
	echo -e "-- Command '$1' found."
    else
	echo -e "-- Command '$1' not found, installing.."
	install_package $1
    fi
}

install_oh-my-zsh() {
    curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
}

install_emacs() {
    install_package emacs23-nox
    install_package emacs-goodies-el
}

install_pygmetize() {
    install_package python-pygments
}

clear_existing_configuration() {
    rm -f ~/.gitconfig
    rm -f ~/.gitignore_global
    rm -f ~/.zshrc
    rm -f ~/.gdbinit
    rm -f ~/.emacs
}

update_symlinks() {
    STOW_ARGS="-vt ~"
    case $1 in
	"refresh") STOW_ARGS="-R $STOW_ARGS" ;;
	"delete")  STOW_ARGS="-D $STOW_ARGS" ;;
	*) ;;
    esac

#    eval "(cd .      && stow $STOW_ARGS linux_debian)"
#    eval "(cd .      && stow $STOW_ARGS linux_arch)"
    eval "(cd common && stow $STOW_ARGS git)"
    eval "(cd common && stow $STOW_ARGS zsh)"
    eval "(cd common && stow $STOW_ARGS gdb)"
    eval "(cd common && stow $STOW_ARGS emacs)"
#    eval "(cd .      && stow $STOW_ARGS private)"
}


case $1 in
    
    "install") 
	ensure_command stow
	ensure_command git
	ensure_command zsh
	ensure_command curl

	install_emacs
	install_oh-my-zsh
	install_pygmetize

	clear_existing_configuration
	update_symlinks refresh
	;;
    
    "refresh")
	update_symlinks refresh
	;;
    
    "delete")
	update_symlinks delete
	;;
    
    *)
	echo -e "Usage: dotfiles.sh <command>\n"
	echo -e "The commands are:"
	echo -e "\tinstall \tInstalls applications and creates all dotfile symlinks."
	echo -e "\trefresh \tSynchronizes dotfiles to symlinks."
	echo -e "\tdelete  \tDeletes all symlinks."
	;;

esac
