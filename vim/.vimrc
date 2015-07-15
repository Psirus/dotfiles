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
" Ack-Vim
Bundle 'mileszs/ack.vim'
" Align
Bundle 'junegunn/vim-easy-align'
" Tagbar
Bundle 'majutsushi/tagbar'
" Command T (commented out, because it creates segv; will look into it)
" Bundle 'wincent/command-t'
" LaTeX Syntax
Bundle 'gi1242/vim-tex-syntax'
" Undo Tree
Bundle 'mbbill/undotree'
" Text Linking needed for org-mode
Bundle 'vim-scripts/utl.vim'
Bundle 'tpope/vim-speeddating'
Bundle 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'Valloric/YouCompleteMe'

nmap <F8> :TagbarToggle<CR>


syntax on
filetype plugin indent on 

colorscheme molokai
set enc=utf-8
" show overly long lines
set cc=80
let g:tex_flavor='latex'

set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 10
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
" leave 10 lines at top/bottom while scrolling
set scrolloff=10
set shellcmdflag=-ic

" tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" au BufNewFile,BufRead *.md set filetype=markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=1

" write ~ and .swp wiles to tmp directory
set backupdir=~/.vim/tmp,.
set directory=~/.vim/tmp,.
" turn off gui thingies
set guioptions+=lLrmtT
set guioptions-=lLrmtT

set laststatus=2
let g:bufferline_echo = 0
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:CommandTFileScanne = 'find'
set tags=./tags;
" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

map <silent> <F6> :!~/Studium/DA/build.py<CR>
map <silent> <F7> :!dict -d fd-deu-eng <cword><CR>
map <silent> <F8> :!/home/psirus/Dokumente/Acoustics/Wiki/wiki.py<CR>
let fortran_fold = 1
let fortran_fold_conditionals = 1
let g:netrw_browsex_viewer= "xdg-open"

