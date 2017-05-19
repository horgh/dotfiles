#!/bin/bash

set -e

# Script directory. May be relative.
REL_DIR=$(dirname $0)

# Absolute path to the script directory.
DIR=$(readlink -f $REL_DIR)

function print_usage () {
	echo "Usage: $0 <environment>"
	echo ""
	echo "  Environment is one of: snorri, gisli"
	echo ""
}

function install_common () {
	rm -f ~/.tmux.conf
	ln -s $DIR/.tmux.conf ~/

	rm -f ~/.vimrc
	ln -s $DIR/.vimrc ~/

	mkdir -p ~/.vim/colors
	rm -f ~/.vim/colors/proton.vim
	ln -s $DIR/.vim/colors/proton.vim ~/.vim/colors/

	mkdir -p ~/.vim/autoload
	curl -o ~/.vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function install_snorri () {
	rm -f ~/.ratpoisonrc
	ln -s $DIR/snorri/.ratpoisonrc ~/
}

function install_gisli () {
	rm -f ~/.ratpoisonrc
	ln -s $DIR/gisli/.ratpoisonrc ~/

	rm -f ~/.vim/env.vim
	ln -s $DIR/gisli/env.vim ~/.vim/
}

function end_instructions () {
	echo "Next steps:"
	echo "  - :PlugInstall or :PlugUpdate"
	echo "  - :GoInstallBinaries or :GoUpdateBinaries"
	echo "  - Install ratpoison"
	echo "  - Install pt"
}

if [ $# -ne 1 ]
then
	print_usage
	exit 1
fi

if [ "$1" == "snorri" ]
then
	install_common
	install_snorri
	end_instructions
	exit 0
fi

if [ "$1" == "gisli" ]
then
	install_common
	install_gisli
	end_instructions
	exit 0
fi

echo "Error: Unknown environment: $1"
exit 1
