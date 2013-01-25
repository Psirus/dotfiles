set nocompatible 
filetype plugin indent on 
syntax on

colorscheme molokai
set enc=utf-8
" show overly long lines
set cc=80

" leave 10 lines at top/bottom while scrolling
set scrolloff=10
set shellcmdflag=-ic

" tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set modeline
set modelines=1
" write ~ and .swp wiles to tmp directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
" save & load folds automatically
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview
set guioptions+=lLrmtT
set guioptions-=lLrmtT

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

set runtimepath+=~/.vim/ultisnips
