set nocompatible 
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Plugin management:
Bundle 'gmarik/vundle'
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
" Snippets
Bundle 'garbas/vim-snipmate'
" Syntax checking
Bundle 'scrooloose/syntastic'
" Orgmode
Bundle 'jceb/vim-orgmode'
" Airline
Bundle 'bling/vim-airline'
" Jedi
Bundle 'davidhalter/jedi-vim'

syntax on
filetype plugin indent on 

if $COLORTERM == 'xfce4-terminal'
    set t_Co=256
endif

colorscheme molokai
set enc=utf-8
" show overly long lines
set cc=80
let g:tex_flavor='latex'

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

set laststatus=2
let g:bufferline_echo = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
set tags=./tags;~/home_server/workspace/3D_XFEM
" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>
