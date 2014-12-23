files=".zshrc .vimrc .vim/indent/tex.vim .vim/colors/molokai.vim .vim/snippets/tex.snippets .xmonad/xmonad.hs .gtkrc-2.0.mine .Xresources .xinitrc"

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.xmonad ~/.vim/colors ~/.vim/tmp ~/.vim/snippets ~/.vim/indent

for file in $files; do
    ln -sf ~/.dotfiles/$file ~/$file
done
