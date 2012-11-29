#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

## Bash configuration ##

# enable bash_completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# go up/down searching through the history with what you have typed so far
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# fuck tty compability
PS1='\[\e[0;36m\]\u|\W≫\[\e[m\]'

# my personal scripts & texlive utilities
PATH=~/Code/Skripte:/usr/local/texlive/2011/bin/x86_64-linux:$PATH

# no duplicates in the history
HISTCONTROL=ignoredups:ignorespace:erasedumps

# append to history
shopt -s histappend

# http://unix.stackexchange.com/questions/1288
# After each command, save and reload history
# export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

alias ls='ls --color=auto'

## aliases ##
# append to longer lasting commands to alert me when they finish
alias finished='notify-send "Script has finished"'

# easy translations and synonym finding on the command line
alias d2e='dict -d deu-eng'
alias e2d='dict -d eng-deu'
alias esyn='dict -d moby-thes'

# get to Thesis folder
alias thesis='cd ~/Studium/IPA/Thesis'

# quickly edit bashrc & vimrc
alias vimrc='vim $HOME/.vimrc'
alias bashrc='vim $HOME/.bashrc'

# set random new background
alias newback="find /home/psirus/Bilder/Backgrounds/ -maxdepth 1 -type f \( -name '*.jpg' -o -name '*.png' \) -print0 | shuf -n1 -z | xargs -0 feh --bg-scale"

alias shutdown='sudo shutdown -h now'
alias reboot='sudo shutdown -r now'

alias tlmgr='sudo env PATH=$PATH tlmgr'
alias ipy='ipython notebook --pylab inline ~/Code/Ipython/'

## functions ##
# remindme 10m Pizza! 
remindme() { sleep $1 && notify-send "$2" & }

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

# print usage of the shell 
usage () {
	cut -f1 -d" " .bash_history | sort | uniq -c | sort -nr | head -n 30
}

## arch specific stuff
_isarch=false
[ -f /etc/arch-release ] && _isarch=true

if $_isarch; then

	# find explicitly installed packages, for clean-up purposes
	alias explicits='pacman -Qei | grep Name | cut -c 18-'
fi
