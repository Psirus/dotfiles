set nocompatible 
filetype off

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'klen/python-mode'

syntax on
filetype plugin indent on 

" Settings for Python-Mode
" Disable pylint checking every save
let g:pymode_lint_write = 0
" Disable line numbers
let g:pymode_options = 0
" Disable python folding
let g:pymode_folding = 0
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

colorscheme molokai
set enc=utf-8
" show overly long lines
set cc=80

set guifont=Droid\ Sans\ Mono\ 10
" leave 10 lines at top/bottom while scrolling
set scrolloff=10
set shellcmdflag=-ic

" tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

au BufNewFile,BufRead *.md set filetype=markdown

set modeline
set modelines=1
" write ~ and .swp wiles to tmp directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
" turn off gui thingies
set guioptions+=lLrmtT
set guioptions-=lLrmtT

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>
