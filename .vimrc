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

syntax on

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

filetype plugin indent on

autocmd BufRead,BufNewFile *.org set filetype=markup
autocmd BufRead,BufNewFile *.rst set filetype=markup
autocmd BufRead,BufNewFile *.tex set filetype=tex
autocmd FileType tex set spell spelllang=en_gb
autocmd FileType markup set spell spelllang=en_gb

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

" map F11 to fullscreen (uses Compiz window matching to detect title)
" TODO this definitely needs a better solution!
map <silent> <F11> :set title titlestring=fullscreentitle
map <silent> <F12> :set title titlestring=gVim
