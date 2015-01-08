# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory autocd HIST_IGNORE_DUPS
setopt nonomatch

unsetopt beep

export PATH=~/Code/Bash:~/Code/Fortran/fipps:/bin:$PATH

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

if [[ $HOST =~ mlr ]]; then
    alias mpiexec=/mnt/appl/x86_64/petsc/3.3-p7/bin/petscmpiexec
    export PETSC_DIR=/mnt/appl/x86_64/petsc/3.3-p7
    export PETSC_ARCH=
    PATH=~/Code/Bash:~/FiPPS:~/colordiff:~/python:~/texlive/bin/x86_64-linux:/bin:$PATH
    export PYTHONPATH=~/python:$PYTHONPATH
    . /mnt/appl/x86_64/Modules/rc_files/profile.modules
    module load /mnt/appl/x86_64/Modules/modulefiles/modules
    module load /mnt/appl/x86_64/Modules/modulefiles/lft
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias merge='git mergetool -t gvimdiff'
alias -s pdf='zathura'
alias -s jpg='viewnior'
if [[ $HOST != psirus-laptop ]]; then
    alias ack='ack-grep'
fi
alias KB='firefox -new-tab ~/Dokumente/KB/.build/index.html'
alias pylint='/usr/bin/pylint'
alias pylint3='/usr/local/bin/pylint'
alias make='make -j 4'

# path aliases
alias GB='cd ~/Studium/GB'
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
