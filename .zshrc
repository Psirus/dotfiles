# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob HIST_IGNORE_DUPS

setopt correctall
unsetopt beep

autoload -Uz compinit && compinit
autoload -U colors && colors

PROMPT="%{$fg_no_bold[cyan]%}%n|%1~» %{$reset_color%}"

# go up/down searching through the history with what you have typed so far
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

# Aliases
alias ls='ls --color=auto'
alias GB='cd ~/Studium/GB'
alias tlmgr='sudo env PATH=$PATH tlmgr'
alias -s pdf='zathura'

function mcd() {
  mkdir -p "$1" && cd "$1";
}
