files=".zshrc .vimrc .vim/colors/molokai.vim .vim/snippets/tex.snippets .xmonad/xmonad.hs .gtkrc-2.0"

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.xmonad ~/.vim/colors ~/.vim/tmp ~/.vim/snippets

for file in $files; do
    ln -s ~/.dotfiles/$file ~/$file
done
