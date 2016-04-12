scriptencoding utf-8
set encoding=utf-8
set title
syntax on
set number
set tabstop=2
set shiftwidth=2
set scrolloff=1000
set ignorecase
set wrapscan
set smarttab
set expandtab
set autoindent
set smartindent
set hlsearch
set laststatus=2
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set showmatch
set matchtime=1
set display=lastline
set wildmenu wildmode=list:full
set nospell
set cursorline

source ~/.vim/dailymemo.vim

"source ~/.vim/localrc.vim
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
"
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
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('scrooloose/syntastic')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('tyru/open-browser.vim')
call dein#add('terryma/vim-multiple-cursors')
call dein#add('kovisoft/slimv.git')
call dein#end()

"" NeoBundleを初期化
"call neobundle#begin(expand('~/.vim/bundle/'))
"
"" インストールするプラグインをここに記述
"NeoBundle 'Shougo/unite.vim'
"NeoBundle 'Shougo/vimfiler'
"NeoBundle 'scrooloose/syntastic'
"NeoBundle 'editorconfig/editorconfig-vim'
"NeoBundle 'tyru/open-browser.vim'
"NeoBundle 'terryma/vim-multiple-cursors'
"NeoBundle 'kovisoft/slimv.git'
"let g:syntastic_javascript_checkers=['eslint']
"let g:syntastic_python_checkers = ['flake8']
"let g:slimv_swank_cmd = '!osascript -e "tell application \"Terminal\" to do script \"sbcl --load ~/.vim/bundle/slimv/slime/start-swank.lisp\""'
"" 検索系
"let g:netrw_nogx = 1
"
"call neobundle#end()

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on
