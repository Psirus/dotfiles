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

export PATH=~/Code/Bash:~/.nimble/bin:~/Code/nim/nim/bin:~/.local/bin:~/.dotfiles/bash:~/.cargo/bin:$PATH
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
export PATH="/Applications/MacPorts/Emacs.app/Contents/MacOS:$PATH"
export EDITOR=nvim

__conda_setup="$('/Users/pohl/.miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/pohl/.miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/pohl/.miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/pohl/.miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/Users/pohl/.miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/Users/pohl/.miniforge3/etc/profile.d/mamba.sh"
fi

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

case $(hostname) in
    ws6779) export TEXINPUTS=.:~/Dokumente/writing/slides/BAM_CD/:$TEXINPUTS;;
    yana|lena) export TEXINPUTS=.:~/Work/writing/slides/BAM_CD/:$TEXINPUTS;;
esac

case $(hostname) in 
    ws6779|yana|lena|yenisei)   PROMPT="%{$fg_no_bold[red]%}%n|%1~» %{$reset_color%}";;
    *)                          PROMPT="%{$fg_no_bold[blue]%}%n|%1~» %{$reset_color%}";;
esac
autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^[[A" history-beginning-search-backward-end
bindkey "^[[B" history-beginning-search-forward-end

# autoload -Uz up-line-or-beginning-search
# autoload -Uz down-line-or-beginning-search
# zle -N up-line-or-beginning-search
# zle -N down-line-or-beginning-search
# typeset -A key

# key[Home]=${terminfo[khome]}
# key[End]=${terminfo[kend]}
# key[Insert]=${terminfo[kich1]}
# key[Delete]=${terminfo[kdch1]}
# key[Up]=${terminfo[kcuu1]}
# key[Down]=${terminfo[kcud1]}
# key[Left]=${terminfo[kcub1]}
# key[Right]=${terminfo[kcuf1]}
# key[PageUp]=${terminfo[kpp]}
# key[PageDown]=${terminfo[knp]}

# # setup key accordingly
# [[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
# [[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
# [[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
# [[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
# [[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
# [[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
# # go up/down searching through the history with what you have typed so far
# [[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-beginning-search
# [[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-beginning-search

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
# function zle-line-init () {
#     echoti smkx
# }
# function zle-line-finish () {
#     echoti rmkx
# }
# zle -N zle-line-init
# zle -N zle-line-finish  

# Aliases
alias d2e='dict -d fd-deu-eng'
alias e2d='dict -d fd-eng-deu'
case $(hostname) in
    ws6779|yana|lena|yenisei)   alias ls='ls --color=auto --group-directories-first';;
    *)                          alias ls='ls --color=auto -G';;
esac
alias ll='ls -lh'
alias -s pdf='zathura'
alias :q='exit'

# emacs() {
#     emacsclient -c -a emacs $1 &
# }

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

# alias nvim="emacs -nw"

alias get_idf='. ~/Code/C/eps-idf4.0/export.sh'

[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0232323" #black
    echo -en "\e]P82B2B2B" #darkgrey
    echo -en "\e]P1D75F5F" #darkred
    echo -en "\e]P9E33636" #red
    echo -en "\e]P287AF5F" #darkgreen
    echo -en "\e]PA98E34D" #green
    echo -en "\e]P3D7AF87" #brown
    echo -en "\e]PBFFD75F" #yellow
    echo -en "\e]P48787AF" #darkblue
    echo -en "\e]PC7373C9" #blue
    echo -en "\e]P5BD53A5" #darkmagenta
    echo -en "\e]PDD633B2" #magenta
    echo -en "\e]P65FAFAF" #darkcyan
    echo -en "\e]PE44C9C9" #cyan
    echo -en "\e]P7E5E5E5" #lightgrey
    echo -en "\e]PFFFFFFF" #white
    clear #for background artifacting
fi

# BLK="04" CHR="04" DIR="04" EXE="00" REG="00" HARDLINK="00" SYMLINK="06" MISSING="00" ORPHAN="01" FIFO="0F" SOCK="0F" OTHER="02"
# export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"
source <(fzf --zsh)

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

path=('/Users/pohl/.juliaup/bin' $path)
export PATH

# <<< juliaup initialize <<<
