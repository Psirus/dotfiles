" Plugins
" --------
call plug#begin('~/.config/nvim/plugged')
" Tpope - Netrw, comments, repeating
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
" Fzf and aligning
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
" Bling
Plug 'itchyny/lightline.vim'
Plug 'morhetz/gruvbox'
" Tables
Plug 'dhruvasagar/vim-table-mode'
call plug#end()

" Mappings
" --------
let mapleader = ' '
let maplocalleader = ' '

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

" making moving around easier
nmap <Tab> <C-w>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" remove search highlighting on escape
nnoremap <esc> :noh<return><esc>

" next in quickfix list
nnoremap <leader>n :cn<CR>
" Easily switch between files; CRTL+^ is not easily reachable on neo
nnoremap <leader>s <C-^>
" quickly edit my vimrc (also a global mark V, so 'V is equivalent to <leader>v)
nnoremap <leader>v :e ~/.config/nvim/init.vim<CR>
" Show buffers and wait for buffer to go to
nnoremap <leader>b :ls<CR>:b<space>
" Python debugging
nnoremap <leader>pd ofrom<space>IPython<space>import<space>embed;<space>embed()<ESC>
nnoremap <leader>m :make!<CR>
nnoremap <leader>c :Commentary<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>F :GFiles<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" have the usual <Esc> behaviour in term windows
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au FileType fzf tnoremap <buffer> <Esc> <c-c>

" Behaviour
" ---------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10

" Indentation
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Delete comment character when joining commented lines
set formatoptions+=j 

set incsearch
set inccommand=split

" write ~ and .swp wiles to tmp directory
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

" make undo persistent
set undofile
set undodir=~/.config/nvim/tmp

" search for files up to $HOME when using gf
set path=.;$HOME

" no need for explict register for clipboard (
set clipboard+=unnamed

set mouse=a

" switch between buffers, even if current buffer was modified
set hidden

" Appearance
" ----------
set background=dark
colorscheme gruvbox
set termguicolors

" mode already in lightline
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
    \ 'active': {
    \   'left':  [['mode', 'paste'],
    \             ['readonly', 'filename', 'modified']],
    \   'right': [['lineinfo'],
    \             ['percent'],
    \             ['filetype']] }
    \ }
