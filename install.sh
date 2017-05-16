#!/bin/bash

set -e

DIR=$(dirname $0)

function print_usage () {
	echo "Usage: $0 <environment>"
	echo ""
	echo "  Environment is one of: snorri, gisli"
	echo ""
}

function install_common () {
	cp -a $DIR/.tmux.conf ~/.tmux.conf

	cp -a $DIR/.vimrc ~/.vimrc

	mkdir -p ~/.vim/colors
	cp -a $DIR/.vim/colors/ ~/.vim/colors

	# https://github/junegunn/vim-plugin vim plugin manager
	mkdir -p ~/.vim/autoload
	curl -o ~/.vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function install_snorri () {
	cp -a $DIR/snorri/.ratpoisonrc ~/.ratpoisonrc
}

function install_gisli () {
	cp -a $DIR/gisli/.ratpoisonrc ~/.ratpoisonrc
	cp -a $DIR/gisli/env.vim ~/.vim
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
