#!/bin/bash

set -e

DIR=$(dirname $0)

mkdir -p ~/.vim/colors
cp -a $DIR/.vim/colors/ ~/.vim/colors

cp -a $DIR/.tmux.conf ~/.tmux.conf

exit

# https://github/junegunn/vim-plugin vim plugin manager
mkdir -p ~/.vim/autoload
curl -o ~/.vim/autoload/plug.vim \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


echo "Next steps:"
echo "  - :PlugInstall or :PlugUpdate"
echo "  - :GoInstallBinaries or :GoUpdateBinaries"
