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
" Auto-complete
"Plug 'shougo/deoplete.nvim'
"Plug 'zchee/deoplete-clang'
Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer' }
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
" Build and quickfixes
Plug 'pgdouyon/vim-accio'
" Clang format
Plug 'rhysd/vim-clang-format'
" Markdown
Plug 'plasticboy/vim-markdown'
" Tagbar
Plug 'majutsushi/tagbar'
" RTags
Plug 'lyuts/vim-rtags'
call plug#end()
filetype plugin indent on

" Appearance
" ----------
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_x = ''
let g:airline_section_y = ''
let g:airline_section_error = '' 
let g:airline_section_warning = ''
set background=dark
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
" show line limit
set cc=80
set termguicolors

let g:clang_format#detect_style_file = 1


" General
" -------
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

" search for tags in directories above cwd
setglobal tags-=./tags tags-=./tags; tags^=./tags;

" remap tag following to ü (much better with German/Neo keyboard layout)
nnoremap ü <C-]>
nnoremap # :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap Ü <C-O>

" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)
" Tab completion
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>" 
" " Start deoplete automatically
let g:ycm_confirm_extra_conf = 0
let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:deoplete#enable_at_startup = 1
" let g:deoplete#sources#clang#libclang_path='/usr/lib/llvm-3.5/lib/libclang.so'
" let g:deoplete#sources#clang#clang_header='/usr/lib/llvm-3.5/lib/clang'

" Markdown
" --------
" gitit pages are markdown as well
au BufNewFile,BufRead *.page set filetype=markdown

let g:vim_markdown_math = 1
let g:vim_markdown_folding_disabled = 1

" search for files up to $HOME
set path=.;$HOME

" Syntastic setup
let g:syntastic_cpp_checkers = ["clang_tidy", "clang_check", "cppcheck"]
let g:syntastic_check_on_wq = 0
let g:syntastic_cpp_clang_tidy_post_args = ""
let g:syntastic_cpp_clang_check_post_args = ""

nnoremap <esc> :noh<return><esc>

nmap <M-b> <Plug>LLBreakSwitch

let g:ctrlp_custom_ignore = '\v[\/](build|release|build_gcc)$'

set makeprg=ninja\ -C\ ../build
set errorformat=%f:%l:%c:\ %trror:\ %m,%f:%l:%c:\ %tarning:\ %m,%f:%l:%c:\ %m,%f:%l:\ %trror:\ %m,%f:%l:\ %tarning:\ %m,%f:%l:\ %m,%-G%s

"set makeprg=ninja\ -C\ ../build_gcc
nmap <F12> :Neomake!<CR>

nmap <M-b> <Plug>LLBreakSwitch
vmap <F2> <Plug>LLStdInSelected
nnoremap <F4> :LLstdin<CR>
nnoremap <F5> :LLmode debug<CR>
nnoremap <S-F5> :LLmode code<CR>
nnoremap <F8> :LL continue<CR>
nnoremap <S-F8> :LL process interrupt<CR>
nnoremap <F9> :LL print <C-R>=expand('<cword>')<CR>
vnoremap <F9> :<C-U>LL print <C-R>=lldb#util#get_selection()<CR><CR>

" Show buffers and wait for buffer to go to
nnoremap gb :ls<CR>:b<space>

" Go to header/cpp file
map gc :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

nmap <F10> :TagbarToggle<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %
