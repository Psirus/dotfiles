# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd extendedglob HIST_IGNORE_DUPS

setopt correctall
unsetopt beep

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U zcalc

PROMPT="%{$fg_no_bold[cyan]%}%n|%1~» %{$reset_color%}"

# go up/down searching through the history with what you have typed so far
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "\e[A" history-beginning-search-backward-end
bindkey "\e[B" history-beginning-search-forward-end

export PATH=~/Code/Bash:~/.cabal/bin:/usr/local/texlive/2013/bin/x86_64-linux:/bin:$PATH

# Aliases
alias ls='ls --color=auto'
alias GB='cd ~/Studium/GB'
alias tlmgr='sudo env PATH=$PATH tlmgr'
alias merge='git mergetool -t gvimdiff'
alias -s pdf='zathura'

# make directory and change into it
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# up 4 -> go 4 directories up (i.e cd ../../../..)
function up() {
    ups=""
    for i in $(seq 1 $1)
    do
    ups=$ups"../"
    done
    cd $ups
}

bindkey '^[[7~' vi-beginning-of-line   # Home
bindkey '^[[8~' vi-end-of-line         # End of Line
bindkey '^[[2~' beep                   # Insert
bindkey '^[[3~' delete-char            # Del
bindkey '^[[5~' vi-backward-blank-word # Page Up
bindkey '^[[6~' vi-forward-blank-word  # Page Down
