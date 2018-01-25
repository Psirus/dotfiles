" Plugins
" --------
call plug#begin('~/.config/nvim/plugged')
" Nice status line
Plug 'itchyny/lightline.vim'
" Different cursor shape depending on mode
Plug 'jszakmeister/vim-togglecursor'
" Easy aligning of tables etc
Plug 'junegunn/vim-easy-align'
" The laptop is just too slow
if hostname() != "psirus-laptop"
    " Auto-complete
    Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer', 'for': 'cpp' }
endif
" Syntax checking
"Plug 'scrooloose/syntastic'
" CRTLP - fuzzy file finder
Plug 'ctrlpvim/ctrlp.vim'
" Ack
Plug 'mileszs/ack.vim'
" Git Wrapper
Plug 'tpope/vim-fugitive'
" Undo tree visualization
Plug 'sjl/gundo.vim'
" Improve netrw
Plug 'tpope/vim-vinegar'
" Build and quickfixes
Plug 'neomake/neomake'
" Distraction free writing
Plug 'junegunn/goyo.vim'
" Clang format
Plug 'rhysd/vim-clang-format'
" Markdown
Plug 'plasticboy/vim-markdown'
" RTags
Plug 'lyuts/vim-rtags'
" Commenter
Plug 'scrooloose/nerdcommenter'
" Color schemes
Plug 'morhetz/gruvbox'
Plug 'trusktr/seti.vim'
" Snippets
Plug 'SirVer/ultisnips'
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
" Debugger
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'idanarye/vim-vebugger'
" Close all buffers but the current one
Plug 'vim-scripts/BufOnly.vim'
Plug 'julialang/julia-vim'
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
"nmap <leader>n :set invrelativenumber<CR>
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

" hard mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Allow saving of files as sudo when I forgot to start vim using sudo
cmap w!! w !sudo tee > /dev/null %


" Behaviour
" ---------
" leave 10 lines at top & bottom while scrolling
set scrolloff=10
set sidescrolloff=5

" Indentation
set autoindent
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

" switch between buffers, even if current buffer was modified
set hidden

" Lightline
" -------
set noshowmode
let g:lightline = {
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


" Neomake
" -------
set makeprg=ninja\ -C\ ../build\ unit\ integrationtests\ examples
set errorformat=%f:%l:%c:\ %trror:\ %m,%f:%l:%c:\ %tarning:\ %m,%f:%l:%c:\ %m,%f:%l:\ %trror:\ %m,%f:%l:\ %tarning:\ %m,%f:%l:\ %m,%-G%s
nmap <F12> :Neomake!<CR>


" LLDB
" ----
nmap <M-b> <Plug>LLBreakSwitch
vmap <F2> <Plug>LLStdInSelected
nnoremap <F4> :LLstdin<CR>
nnoremap <F5> :LLmode debug<CR>
nnoremap <S-F5> :LLmode code<CR>
nnoremap <F8> :LL continue<CR>
nnoremap <S-F8> :LL process interrupt<CR>
nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>


" Syntastic
" ---------
let g:syntastic_cpp_checkers = ["clang_tidy", "clang_check", "cppcheck"]
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_clang_tidy_post_args = ""
let g:syntastic_cpp_clang_check_post_args = ""


" YouCompleteMe
" -------------
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_python_binary_path = '/usr/bin/python3'

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
\   '-pdflatex=lualatex',
\   '-verbose',
\   '-file-line-error',
\   '-synctex=1',
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
