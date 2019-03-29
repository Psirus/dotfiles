" Plugins
" --------
call plug#begin('~/.config/nvim/plugged')
" Nice status line
Plug 'itchyny/lightline.vim'
" Different cursor shape depending on mode
Plug 'jszakmeister/vim-togglecursor'
" Easy aligning of tables etc
Plug 'junegunn/vim-easy-align'
" CRTLP - fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" Ack
Plug 'mileszs/ack.vim'
" Git Wrapper
Plug 'tpope/vim-fugitive'
" Improve netrw
Plug 'tpope/vim-vinegar'
" Distraction free writing
Plug 'junegunn/goyo.vim'
" Clang format
Plug 'rhysd/vim-clang-format'
" Black - Python formatter
Plug 'ambv/black'
" Markdown
Plug 'plasticboy/vim-markdown'
" Commenter
Plug 'scrooloose/nerdcommenter'
" Color schemes
Plug 'morhetz/gruvbox'
" Tables
Plug 'dhruvasagar/vim-table-mode'
" TeX
Plug 'lervag/vimtex'
" Shell commands from vim, sugarized
Plug 'tpope/vim-eunuch'
" Repeat
Plug 'tpope/vim-repeat'
Plug 'dahu/LearnVim'
Plug 'tpope/vim-abolish'
" Universal text linking
Plug 'vim-scripts/utl.vim'
" Repeat
Plug 'tpope/vim-repeat'
Plug 'dahu/LearnVim'
" Debugger
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'
" Close all buffers but the current one
Plug 'vim-scripts/BufOnly.vim'
Plug 'tpope/vim-surround'
Plug 'vim-syntastic/syntastic'
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

" next in quickfix list
nmap <leader>n :cn<CR>

" Easily switch between files; CRTL+^ is not easily reachable on neo
nmap <leader>s <C-^>
" quickly edit my vimrc
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
nmap <leader>m :make<CR>

inoremap nr <esc>
vnoremap nr <esc>
cnoremap nr <C-c>

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
let g:vimtex_indent_enabled=0

set ttimeout
set ttimeoutlen=100

" Delete comment character when joining commented lines
set formatoptions+=j 

set incsearch
" write ~ and .swp wiles to tmp directory
set backupdir=~/.config/nvim/tmp,.
set directory=~/.config/nvim/tmp,.

set undofile
set undodir=~/.config/nvim/tmp

" search for files up to $HOME
set path=.;$HOME

set clipboard+=unnamedplus

set inccommand=split

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

" Clang Format
" ------------
let g:clang_format#detect_style_file = 1
let g:clang_format#auto_format = 0

" CTRL-P
" ------
" I have submodules in git, and if you are in a 'sub' file it won't find
" 'parent' files
let g:ctrlp_working_path_mode = 'rwa'
let g:ctrlp_custom_ignore = { 'dir': 'build_doxygen' }

" Goyo
" ----
let g:goyo_width = 80


" Markdown
" --------
" gitit pages are markdown as well
au BufNewFile,BufRead *.page set filetype=markdown
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1


" vimtex
" ------
let g:vimtex_compiler_latexmk = {
\ 'backend' : 'nvim',
\ 'background' : 1,
\ 'build_dir' : '',
\ 'callback' : 1,
\ 'continuous' : 1,
\ 'executable' : 'latexmk',
\ 'options' : [
\   '-pdf',
\   '-lualatex',
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
\   '-shell-escape',
\   '-interaction=nonstopmode',
\ ],
\}

" Ack
let g:ackprg = "ag"

nmap Q :call TeX_fmt()<CR>

let g:syntastic_python_pylint_args="--disable=invalid-name"

nmap ö [
nmap ä ]
omap ö [
omap ä ]
xmap ö [
xmap ä ]

" have the usual <Esc> behaviour in term windows
tnoremap <Esc> <C-\><C-n>

nmap <Tab> <C-w>
