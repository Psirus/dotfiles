mkdir -p ~/.vim/bundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
sudo ln -sf ~/.dotfiles/vtwheel /usr/lib/urxvt/perl/vtwheel
stow wm
stow vim
stow git
stow misc
stow mpd
