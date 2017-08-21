set nocompatible              " be iMproved, required

" Plugins
" --------
call plug#begin('~/.config/nvim/plugged')
" Nice status line
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Different cursor shape depending on mode
Plug 'jszakmeister/vim-togglecursor'
" Easy aligning of tables etc
Plug 'junegunn/vim-easy-align'
" Auto-complete
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer', 'for': 'cpp' }
" Syntax checking
Plug 'scrooloose/syntastic'
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
" Debugger
Plug 'critiqjo/lldb.nvim'
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
Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
" Snippets
Plug 'SirVer/ultisnips'
" Tables
Plug 'dhruvasagar/vim-table-mode'
" TeX
Plug 'lervag/vimtex'
" Orgmode
Plug 'jceb/vim-orgmode'
" Speeddating
Plug 'tpope/vim-speeddating'
" Universal text linking
Plug 'vim-scripts/utl.vim'
" Repeat
Plug 'tpope/vim-repeat'
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
nmap <leader>n :set invrelativenumber<CR>
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

" Airline
" -------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_error = '' 
let g:airline_section_warning = ''
let g:airline_theme = "hybrid"


" Clang Format
" ------------
let g:clang_format#detect_style_file = 1

" CTRL-P
" ------
" I have submodules in git, and if you are in a 'sub' file it won't find
" 'parent' files
let g:ctrlp_working_path_mode = 'rwa'

" Goyo
" ----
let g:goyo_width = 120


" Markdown
" --------
" gitit pages are markdown as well
au BufNewFile,BufRead *.page set filetype=markdown
let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1


" Neomake
" -------
set makeprg=ninja\ -C\ ../build
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
