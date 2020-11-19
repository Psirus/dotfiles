" Plugins
" --------
call plug#begin('~/.config/nvim/plugged')
" Nice status line
Plug 'itchyny/lightline.vim'
" Easy aligning of tables etc
Plug 'junegunn/vim-easy-align'
" Improve netrw
Plug 'tpope/vim-vinegar'
" Commenter
Plug 'preservim/nerdcommenter'
" Color schemes
Plug 'morhetz/gruvbox'
" Tables
Plug 'dhruvasagar/vim-table-mode'
" Shell commands from vim, sugarized
Plug 'tpope/vim-eunuch'
" Repeat
Plug 'tpope/vim-repeat'
Plug 'dahu/LearnVim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
call plug#end()

" Appearance
" ----------
set background=dark
colorscheme gruvbox
set termguicolors

" Mappings
" --------
let mapleader = ' '
let maplocalleader = ' '

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap Ü <C-O>

" making moving around easier
nmap <silent> <leader>i :wincmd h<CR>
nmap <silent> <leader>a :wincmd j<CR>
nmap <silent> <leader>l :wincmd k<CR>
nmap <silent> <leader>e :wincmd l<CR>
" or: (not sure which i prefer)
nmap <Tab> <C-w>

" next in quickfix list
nmap <leader>n :cn<CR>

" Easily switch between files; CRTL+^ is not easily reachable on neo
nmap <leader>s <C-^>
" quickly edit my vimrc (also a global mark V, so 'V is equivalent to
" <leader>v)
nmap <leader>v :e ~/.config/nvim/init.vim<CR>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" remove search highlighting on escape
nnoremap <esc> :noh<return><esc>

" Show buffers and wait for buffer to go to
nnoremap gb :ls<CR>:b<space>

" Go to header/cpp file
map gc :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

nmap <leader>pd ofrom<space>IPython<space>import<space>embed;<space>embed()<ESC>
nmap <leader>m :make!<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

" Behaviour
" ---------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10
set sidescrolloff=5

" Indentation
set noautoindent
set smarttab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set ttimeout
set ttimeoutlen=100

" Delete comment character when joining commented lines
set formatoptions+=j 

set incsearch
set inccommand=split

" write ~ and .swp wiles to tmp directory
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

set undofile
set undodir=~/.config/nvim/tmp

" search for files up to $HOME
set path=.;$HOME

set clipboard+=unnamedplus

set mouse=a

" switch between buffers, even if current buffer was modified
set hidden

" Lightline
" -------
set noshowmode
let g:lightline = {
    \ 'colorscheme': 'gruvbox',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified'] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'filetype' ]] }
      \ }

nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" have the usual <Esc> behaviour in term windows
au TermOpen * tnoremap <buffer> <Esc> <c-\><c-n>
au FileType fzf tunmap <buffer> <Esc>

let g:NERDCreateDefaultMappings = 0
nmap <leader>c<space> <plug>NERDCommenterToggle
vmap <leader>c<space> <plug>NERDCommenterToggle
