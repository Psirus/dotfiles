#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

HOST=$(hostname)
## Bash configuration ##

# enable bash_completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# go up/down searching through the history with what you have typed so far
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

PS1=$'\[\e[0;36m\]\u|\W\xc2\xbb \[\e[m\]'

# my personal scripts & texlive utilities
PATH=~/Code/Skripte:~/.cabal/bin:/usr/local/texlive/2013/bin/x86_64-linux:$PATH

# no duplicates in the history
HISTCONTROL=ignoredups:ignorespace:erasedumps

# append to history
shopt -s histappend

alias ls='ls --color=auto'

## aliases ##
# append to longer lasting commands to alert me when they finish
alias finished='notify-send "Script has finished"'

# easy translations and synonym finding on the command line
alias d2e='dict -d fd-deu-eng'
alias e2d='dict -d fd-eng-deu'
alias esyn='dict -d moby-thesaurus'

alias GB='cd ~/Studium/GB'

if [ "${HOST}" == "PCpohl" ]; then
    alias ipy='ipython notebook --pylab inline ~/home_server/Code/Python/'
else
    alias ipy='ipython notebook --pylab inline ~/Code/Python/'
fi

alias tlmgr='sudo env PATH=$PATH tlmgr'
alias merge='git mergetool -t gvimdiff'

alias speedtest='wget --output-document=/dev/null http://speedtest.wdc01.softlayer.com/downloads/test500.zip'

alias open='xdg-open'
## functions ##
# remindme 10m Pizza! 
remindme() { sleep $1 && notify-send "$2";}

# for quick command line calculations
calc() { bc -l <<<"$@"; }

# make directory and change into it
mcd () { mkdir -p "$@" && cd "$@"; }

# up 4 -> go 4 directories up (i.e cd ../../../..)
up () {
	ups=""
	for i in $(seq 1 $1)
	do
        	ups=$ups"../"
	done
	cd $ups
}

# often quicker than wikipedia, especially in combination with grep
# e.g.: facts algeria | grep -A 5 Literacy
facts () { 	dict -d world02 "$@" | less; }

# check which process uses certain file
psgrep () { ps aux | grep $1 | grep -v grep; }

alias newSystemInstalls='sudo apt-get install git mdadm vim-gnome ipython-notebook'
