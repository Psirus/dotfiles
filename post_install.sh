#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   	echo "This script must be run as root" 
   	exit 1
else
	#Update and Upgrade
	echo "Updating and Upgrading"
    apt-add-repository restricted
    apt-add-repository universe
    apt-add-repository multiverse
	apt update && sudo apt upgrade -y

	apt install -y dialog
	cmd=(dialog --separate-output --checklist "Please Select Software you want to install:" 22 76 16)
	options=(1 "Base" off    # any option can be set to default to "on"
	         2 "Science" off
	         3 "Desktop" off
             4 "Audio" off)
		choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		clear
		for choice in $choices
		do
		    case $choice in
            1)
				echo "Installing Base packages"
				apt install -y curl stow git neovim python3-neovim zsh apt-file trash-cli silversearcher-ag pass
                apt-file update
				;;

			2)
                echo "Installing Science stuff"
                apt install -y texlive texlive-pictures texlive-latex-extra python3-dolfin paraview python3-matplotlib python3-scipy
				;;
    		3)	
				echo "Installing Desktop packages"
				apt install -y telegram-desktop gnome-tweaks mpv
				;;
            4)
                echo "Installing Audio packages"
                apt install -y ardour calf-plugins sonic-pi amsynth
                ;;
	    esac
	done
fi
