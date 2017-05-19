if [ -n "$GOPATH" ]
then
	export PATH=$GOPATH/bin:$PATH
else
	export PATH=~/go/bin:$PATH
fi

export PATH=~/bin/ratpoison-git/src:$PATH

export HISTSIZE=-1
export HISTFILESIZE=-1

export FZF_DEFAULT_COMMAND='pt -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
