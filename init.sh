if [[ ! -d ~/.config/nvim/tmp ]]; then
    mkdir -p ~/.config/nvim/tmp
    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi
stow nvim
mkdir -p ~/.config/nvim/tmp
stow git
stow misc
