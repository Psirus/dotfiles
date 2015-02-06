files=".zshrc .vimrc .vim/indent/tex.vim .vim/colors/molokai.vim .vim/snippets/tex.snippets .xmonad/xmonad.hs .gtkrc-2.0.mine .gitconfig .vimperatorrc .xmonad/lib/XMonad/Layout/EqualSpacing.hs"

git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
mkdir -p ~/.xmonad/lib/XMonad/Layout ~/.vim/colors ~/.vim/tmp ~/.vim/snippets ~/.vim/indent

for file in $files; do
    ln -sf ~/.dotfiles/$file ~/$file
done
