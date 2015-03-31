if [[ ! -d ~/.vim/bundle/vundle ]]; then
    mkdir -p ~/.vim/bundle
    git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
fi
if [[ ! -f /usr/lib/urxvt/perl/vtwheel ]]; then
    sudo ln -sf ~/.dotfiles/vtwheel /usr/lib/urxvt/perl/vtwheel
fi
stow wm
stow vim
stow git
stow misc
stow mpd
