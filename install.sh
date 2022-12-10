#!/bin/bash

set -e

# Script directory. May be relative.
REL_DIR=$(dirname $0)

# Absolute path to the script directory.
DIR=$(readlink -f $REL_DIR)

function print_usage () {
	echo "Usage: $0 <environment>"
	echo ""
	echo "  Environment is one of: snorri, maxmind"
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
	rm -f ~/.vim/colors/proton-cterm.vim
	ln -s $DIR/.vim/colors/proton-cterm.vim ~/.vim/colors/

    ln -s $DIR/.vim/after ~/.vim/after

	mkdir -p ~/.vim/autoload
	curl -o ~/.vim/autoload/plug.vim \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

	rm -rf ~/.bash.d
	ln -s $DIR/.bash.d ~/

	UPDATE_BASHRC=0
	grep -q HORGHBASHD ~/.bashrc || UPDATE_BASHRC=1
	if [ $UPDATE_BASHRC -eq 1 ]
	then
		echo 'for HORGHBASHD in ~/.bash.d/*; do source $HORGHBASHD; done' >> ~/.bashrc
	fi

	curl -o ~/.bash.d/git-prompt.sh \
		https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

    mkdir -p ~/.gnupg
    rm -f ~/.gnupg/gpg-agent.conf
    ln -s $DIR/.gnupg/gpg-agent.conf ~/.gnupg

	rm -f ~/.ratpoisonrc
	ln -s $DIR/snorri/.ratpoisonrc ~/

	rm -f ~/.xinitrc
	ln -s $DIR/.xinitrc ~/

	rm -f ~/.Xmodmap
	ln -s $DIR/.Xmodmap ~/

	rm -rf ~/.Xresources
	ln -s $DIR/snorri/.Xresources ~/

	rm -rf ~/.xscreensaver
	ln -s $DIR/snorri/.xscreensaver ~/
}

function install_snorri () {
	rm -f ~/.gitconfig
	ln -s $DIR/snorri/.gitconfig ~/

	rm -f ~/.gitignore_global
	ln -s $DIR/snorri/.gitignore_global ~/
}

function install_maxmind () {
	rm -f ~/.vim/env.vim
	ln -s $DIR/maxmind/env.vim ~/.vim/
}

function end_instructions () {
	echo "Next steps:"
	echo "- :PlugInstall or :PlugUpdate (installs/updates fzf)"
	echo "- :GoInstallBinaries or :GoUpdateBinaries (installs golangci-lint and more)"
	echo "- Install ratpoison (if workstation)"
	echo "- Install pt (go install github.com/monochromegane/the_platinum_searcher/cmd/pt@latest)"
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

if [ "$1" == "maxmind" ]
then
	install_common
	install_maxmind
	end_instructions
	exit 0
fi

echo "Error: Unknown environment: $1"
exit 1
