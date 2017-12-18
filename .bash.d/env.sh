if [ -z "$GOPATH" ]
then
	export GOPATH=~/go
fi

export PATH=$GOPATH/bin:$PATH
export PATH=~/bin/ratpoison-git/src:$PATH
export PATH=~/bin/go/bin:$PATH

export HISTSIZE=-1
export HISTFILESIZE=-1

# Make fzf use pt
export FZF_DEFAULT_COMMAND='pt -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Make fzf use colours. This appears to be automatic for some TERM variables.
export FZF_DEFAULT_OPTS="--color=16"

# Colourful bash prompt.
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w$(__git_ps1 " (%s)")\[\033[00m\]\$ '
PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"

# Colourful ls
eval "$(dircolors -b)"
alias ls='ls --color=auto'

complete -F _fzf_path_completion -o default -o bashdefault dev/bin/test/prove-this
complete -F _fzf_path_completion -o default -o bashdefault gvim
complete -F _fzf_path_completion -o default -o bashdefault vim
complete -F _fzf_path_completion -o default -o bashdefault git
