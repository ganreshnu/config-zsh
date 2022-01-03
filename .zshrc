# completion system
zmodload zsh/complist
autoload -U compinit; compinit -d "$XDG_CACHE_HOME/.zcompdump"

# enable colors in completions
eval "$(TERM=xterm dircolors)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# case insensitive matching
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# program specific completions
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# enable the completion menu
zstyle ':completion:*' menu select
# vim keys in completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# history
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$XDG_STATE_HOME/zsh_history"

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances of the shell

# prompt
autoload -U promptinit; promptinit
PS1="%~ %# "

# use editor to edit command line
autoload -U edit-command-line; zle -N edit-command-line
bindkey -M viins '^e' edit-command-line

autoload -U scheme

alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# gpg-agent
#unset SSH_AGENT_PID
export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
export GPG_TTY=$(tty)

gpg-ssh-id() {
	if [[ -n "$1" ]]; then
		local keygrip=$(gpg --with-keygrip --list-key $1 | awk '/Keygrip = /{ if (lastline ~ /^sub.+\[.*A.*\]/) { print $3 } } { lastline = $0 }')
	fi
	if [[ -n "$keygrip" ]]; then
		echo $keygrip > $HOME/.gnupg/sshcontrol
	fi
}
