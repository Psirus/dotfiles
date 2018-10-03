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

export PATH=~/.julia/bin:~/.cargo/bin:~/.cabal/bin:~/.local/bin:~/Code/Bash:~/Code/Cpp/rtags/bin:/usr/lib/ccache:/opt/anaconda3/bin:$PATH

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

export MANPAGER="nvim -c 'set ft=man' -"

export TEXINPUTS=.:~/Dokumente/writing/slides/BAM_CD/:$TEXINPUTS

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
alias ls='ls --color=auto'
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# i've done something i've regretted more than once
alias rm=trash

function ssht () {/usr/bin/ssh -t $@ "tmux attach || tmux new";}

. ~/.dotfiles/z/z.sh
