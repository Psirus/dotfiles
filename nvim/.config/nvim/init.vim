set nocompatible              " be iMproved, required

" Plugins
" --------
filetype off
call plug#begin('~/.config/nvim/plugged')
" Nice status line
Plug 'bling/vim-airline'
" Nice color scheme
Plug 'morhetz/gruvbox'
" Different cursor shape depending on mode
Plug 'jszakmeister/vim-togglecursor'
" Easy aligning of tables etc
Plug 'junegunn/vim-easy-align'
" Better markdown syntax highlighting
Plug 'plasticboy/vim-markdown'
call plug#end()
filetype plugin indent on

" Appearance
" ----------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set background=dark
colorscheme gruvbox
" show line limit
set cc=80

" General
" -------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10

" tabs are 4 spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" write ~ and .swp wiles to tmp directory
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

" search for tags in directories above cwd
set tags=./tags;
" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" Markdown
" --------
" Don't fold markdown
let g:vim_markdown_folding_disabled = 1
" Highlight TeX math in markdon
let g:vim_markdown_math = 1
" Disable error checking for LaTeX syntax; yields false positives
let g:tex_no_error = 1
" gitit pages are markdown as well
au BufNewFile,BufRead *.page set filetype=markdown
