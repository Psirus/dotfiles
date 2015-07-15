# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd HIST_IGNORE_DUPS
setopt nonomatch
setopt extended_glob
setopt no_bare_glob_qual

unsetopt beep

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U zcalc

PROMPT="%{$fg_no_bold[red]%}%n|%1~» %{$reset_color%}"

if [[ "$TERM" != emacs ]]; then
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M emacs "$terminfo[kdch1]" delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M emacs "$terminfo[khome]" beginning-of-line
    [[ -z "$terminfo[kend]" ]] || bindkey -M emacs "$terminfo[kend]" end-of-line
    [[ -z "$terminfo[kich1]" ]] || bindkey -M emacs "$terminfo[kich1]" overwrite-mode
    [[ -z "$terminfo[kdch1]" ]] || bindkey -M vicmd "$terminfo[kdch1]" vi-delete-char
    [[ -z "$terminfo[khome]" ]] || bindkey -M vicmd "$terminfo[khome]" vi-beginning-of-line
    [[ -z "$terminfo[kend]" ]] || bindkey -M vicmd "$terminfo[kend]" vi-end-of-line
    [[ -z "$terminfo[kich1]" ]] || bindkey -M vicmd "$terminfo[kich1]" overwrite-mode
     
    [[ -z "$terminfo[cuu1]" ]] || bindkey -M viins "$terminfo[cuu1]" vi-up-line-or-history
    [[ -z "$terminfo[cuf1]" ]] || bindkey -M viins "$terminfo[cuf1]" vi-forward-char
    [[ -z "$terminfo[kcuu1]" ]] || bindkey -M viins "$terminfo[kcuu1]" vi-up-line-or-history
    [[ -z "$terminfo[kcud1]" ]] || bindkey -M viins "$terminfo[kcud1]" vi-down-line-or-history
    [[ -z "$terminfo[kcuf1]" ]] || bindkey -M viins "$terminfo[kcuf1]" vi-forward-char
    [[ -z "$terminfo[kcub1]" ]] || bindkey -M viins "$terminfo[kcub1]" vi-backward-char
     
    # ncurses fogyatekos
    [[ "$terminfo[kcuu1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuu1]/O/[}" vi-up-line-or-history
    [[ "$terminfo[kcud1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcud1]/O/[}" vi-down-line-or-history
    [[ "$terminfo[kcuf1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcuf1]/O/[}" vi-forward-char
    [[ "$terminfo[kcub1]" == "^[O"* ]] && bindkey -M viins "${terminfo[kcub1]/O/[}" vi-backward-char
    [[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M viins "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M viins "${terminfo[kend]/O/[}" end-of-line
    [[ "$terminfo[khome]" == "^[O"* ]] && bindkey -M emacs "${terminfo[khome]/O/[}" beginning-of-line
    [[ "$terminfo[kend]" == "^[O"* ]] && bindkey -M emacs "${terminfo[kend]/O/[}" end-of-line
fi

# go up/down searching through the history with what you have typed so far
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '\eOA' up-line-or-beginning-search
bindkey '\e[A' up-line-or-beginning-search
bindkey '\eOB' down-line-or-beginning-search
bindkey '\e[B' down-line-or-beginning-search

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias merge='git mergetool -t gvimdiff'
alias -s pdf='zathura'
alias -s jpg='viewnior'
alias tlmgr='sudo env PATH=$PATH tlmgr'
function gitsearch() {
    git grep "$*" $(git rev-list --all)
}

# path aliases
alias kuray='cd ~/Code/Python/kuray'

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

function countdown(){
   date1=$((`date +%s` + $1)); 
   while [ "$date1" -ne `date +%s` ]; do 
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 1
   done
}
