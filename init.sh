files=".zshrc .vimrc .vim/colors/molokai.vim .vim/snippets/tex.snippets .xmonad/xmonad.hs .gtkrc-2.0 .config/xfce4/terminal/terminalrc"

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.xmonad ~/.vim/colors ~/.vim/tmp ~/.vim/snippets

for file in $files; do
    ln -s ~/.dotfiles/$file ~/$file
done
