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
" RTags
Plug 'lyuts/vim-rtags'
" Commenter
Plug 'scrooloose/nerdcommenter'
" Color schemes
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'trusktr/seti.vim'
" Tables
Plug 'dhruvasagar/vim-table-mode'
" TeX
Plug 'lervag/vimtex'
" Orgmode
"Plug 'jceb/vim-orgmode'
Plug '~/Code/VimL/vim-orgmode'
" Speeddating
Plug 'tpope/vim-speeddating'
" Shell commands from vim, sugarized
Plug 'tpope/vim-eunuch'
" Universal text linking
Plug 'vim-scripts/utl.vim'
" Repeat
Plug 'tpope/vim-repeat'
Plug 'dahu/LearnVim'
" Close all buffers but the current one
Plug 'vim-scripts/BufOnly.vim'
Plug 'tpope/vim-surround'
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

" fixit
nmap <Leader>f :YcmCompleter FixIt<CR>
" toggle line numbers
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

inoremap ii <esc>
vnoremap ii <esc>
cnoremap ii <C-c>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %

nnoremap <leader>y :0,$!yapf3<CR>

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

" treat swig interface files as cpp
au BufNewFile,BufRead *.i set filetype=cpp

" tikz, cls and tex are likely LaTeX files
au BufNewFile,BufRead *.tikz set filetype=tex
au BufNewFile,BufRead *.cls set filetype=tex
au BufNewFile,BufRead *.tex set filetype=tex
au BufNewFile,BufRead *.tex set foldmethod=expr
au BufNewFile,BufRead *.tex set foldexpr=vimtex#fold#level(v:lnum)
au BufNewFile,BufRead *.tex set foldtext=vimtex#fold#text()

" for python files, set python3 as make
autocmd Filetype python setlocal makeprg=python3\ %

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
let g:ackprg = "ag --ignore doc"

let g:vebugger_leader='<Leader>d'

" Reformat lines (getting the spacing correct)
fun! TeX_fmt()
    if (getline(".") != "")
    let save_cursor = getpos(".")
        let op_wrapscan = &wrapscan
        set nowrapscan
        let par_begin = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\\[\|\\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
        let par_end   = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\\[\|\\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
    try
      exe '?'.par_begin.'?+'
    catch /E384/
      1
    endtry
        norm V
    try
      exe '/'.par_end.'/-'
    catch /E385/
      $
    endtry
    norm gq
        let &wrapscan = op_wrapscan
    call setpos('.', save_cursor)
    endif
endfun

nmap Q :call TeX_fmt()<CR>

let g:syntastic_python_pylint_args="--disable=invalid-name"
