files=".zshrc .vimrc .vim/colors/molokai.vim .xmonad/xmonad.hs"

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.xmonad ~/.vim/colors ~/.vim/tmp

for file in $files; do
    ln -s ~/.dotfiles/$file ~/$file
done
