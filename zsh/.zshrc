# History
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
setopt appendhistory autocd HIST_IGNORE_DUPS
setopt nonomatch
setopt extended_glob
setopt no_bare_glob_qual

# allow comments on the command line
setopt interactivecomments

unsetopt beep

autoload -Uz compinit && compinit
autoload -U colors && colors
autoload -U zcalc

DIRSTACKSIZE=10
setopt autopushd pushdminus pushdsilent pushdtohome
alias dh='dirs -v'

export PATH=~/Code/Bash:~/.cargo/bin:~/.nimble/bin:~/.local/bin:~/.dotfiles/bash:$PATH
export EDITOR=nvim

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export MANPAGER="nvim -c 'set ft=man' -"

export TEXINPUTS=.:~/Work/writing/slides/BAM_CD/:$TEXINPUTS

case $(hostname) in 
    ws6779|yana|lena|yenisei)   PROMPT="%{$fg_no_bold[red]%}%n|%1~» %{$reset_color%}";;
    *)                          PROMPT="%{$fg_no_bold[blue]%}%n|%1~» %{$reset_color%}";;
esac

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
# go up/down searching through the history with what you have typed so far
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
function zle-line-init () {
    echoti smkx
}
function zle-line-finish () {
    echoti rmkx
}
zle -N zle-line-init
zle -N zle-line-finish  

# Aliases
alias d2e='dict -d fd-deu-eng'
alias e2d='dict -d fd-eng-deu'
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -lh'
alias -s pdf='zathura'
alias :q='exit'
function gitsearch() {
    git grep "$*" $(git rev-list --all)
}

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

# i've done something i've regretted more than once
alias rm=trash

function ssht () {/usr/bin/ssh -t $@ "tmux attach || tmux new";}

. ~/.dotfiles/z/z.sh

if [[ $(hostname -s) = sv2214 ]]; then
    export LD_LIBRARY_PATH=/home/cpohl/fenics_local/petsc/lib:$LD_LIBRARY_PATH
    source /home/cpohl/.local/share/dolfin/dolfin.conf
fi

source /usr/share/doc/fzf/examples/key-bindings.zsh

export FZF_DEFAULT_COMMAND="rg -g '!Netzwerk' --files ."
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

alias vim='nvim -u ~/Code/vim/sensible.vim'
alias tlmgr='sudo env PATH=$PATH tlmgr'
