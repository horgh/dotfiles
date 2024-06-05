export PATH=~/bin/ratpoison-git/src:$PATH
export PATH=~/code/ratpoison/src:$PATH

# For Go.
export PATH=~/bin/go/bin:$PATH

# For pt, etc.
export PATH=~/go/bin:$PATH

# ruby-install path.
export PATH=~/.rubies/ruby-3.3.2/bin:$PATH

# Ruby gems.
export PATH=~/.gem/ruby/3.3.0/bin:$PATH

export HISTSIZE=-1
export HISTFILESIZE=-1

# Make fzf use pt
export FZF_DEFAULT_COMMAND='pt -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

export FZF_DEFAULT_OPTS="--color=light"

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

if [ -z "$SSH_AUTH_SOCK" ]
then
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

unset PROMPT_COMMAND # MM sets this in /etc/profile.d. I don't need it.

# docker-credential-gcloud is here when using the SDK from a snap.
export PATH=/snap/google-cloud-sdk/current/bin:$PATH
