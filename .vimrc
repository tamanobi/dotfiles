scriptencoding utf-8
set encoding=utf-8
"colorscheme elflord
colorscheme desert
set title
syntax on
set number
set tabstop=2
set shiftwidth=2
set scrolloff=1000
set ignorecase
set wrapscan
set noswapfile
set nobackup
set smarttab
set expandtab
set autoindent
set smartindent
set hlsearch
set incsearch
set mouse=a
hi CursorLineNr term=bold   cterm=BOLD ctermfg=228 ctermbg=8
set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set showmatch
set matchtime=1
set display=lastline
set wildmenu wildmode=list:full
set nospell
set cursorline

" for memo
source ~/.vim/dailymemo.vim

let mapleader = "\<Space>"
" save file
nnoremap <Leader>w :w<CR>

" Key Map
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ( "zdi^V(<C-R>z)<ESC>
vnoremap " "zdi^V"<C-R>z^V"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" Buffer
nnoremap <C-n> :bp<CR>
nnoremap <C-p> :bn<CR>
" You must prepare Directory(ex. mkdir -p ~/.vim/undo)
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
" Keep Cursor Position(Last Position) When Open File
" @see also: https://wiki.archlinuxjp.org/index.php/Vim#Vim_.E3.81.AB.E3.83.95.E3.82.A1.E3.82.A4.E3.83.AB.E3.81.AE.E3.82.AB.E3.83.BC.E3.82.BD.E3.83.AB.E4.BD.8D.E7.BD.AE.E3.82.92.E8.A8.98.E6.86.B6.E3.81.95.E3.81.9B.E3.82.8B
" @see also: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\""
noremap! <C-A> <Home>
noremap! <C-E> <End>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
noremap! <C-D> <Del>
" 移動
nnoremap <C-H> ^
nnoremap <C-L> $
inoremap <C-L> <ESC>
" magic
nnoremap / /\v
" cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
inoremap <C-w> <ESC>bcw
" ブラウザを開く
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
vnoremap <C-n> y:MultipleCursorsFind <C-R>"<CR>
" Plugin
if has('vim_starting')
   " 初回起動時のみruntimepathにneobundleのパスを指定する
   set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" dein
if &compatible
   set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.vim/dein'))
"call dein#add({path to dein.vim directory})
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
"call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('scrooloose/syntastic')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('tyru/open-browser.vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('kovisoft/slimv.git')
call dein#end()
" ------------------------------------- 
" Unite settings
let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <C-P> :Unite buffer<CR>
" ファイル一覧
nnoremap <C-N> :Unite -buffer-name=file file<CR>
" MRU
nnoremap <C-Z> :Unite file_mru<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" ------------------------------------- 
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['flake8']
let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp\""'
" 検索系
let g:netrw_nogx = 1

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on

nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
endif
