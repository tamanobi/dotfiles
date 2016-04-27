scriptencoding utf-8
set encoding=utf-8
filetype off
filetype plugin indent off
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
colorscheme desert
set history=1000
set title
set number
set hidden
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
set list
" 入力中のコマンドを表示する
set showcmd
" 対応する括弧を表示
set showmatch
set matchtime=1
set display=lastline
set wildmenu wildmode=list:full
set nospell
set cursorline
set listchars=tab:>-,extends:<,trail:-
if has('gui') || has('xterm_clipboard')
  set clipboard=unnamed
endif
" -------------------------------------------------------------
" STATUS LINE
" -------------------------------------------------------------
set laststatus=2
" file number
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
" file name
set statusline+=\ %<%F
set statusline+=\ %m%r%h%w
set statusline+=\ [%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y
set statusline+=%=\ %l/%L\
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [line=%04l,%04v][%p%%]%=\[FORMAT=%{&ff}]\[ENC=%{&fileencoding}]\[ROW=%l/%L]
" -------------------------------------------------------------

" -------------------------------------------------------------
" comand shortcut
" -------------------------------------------------------------
let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e<space>%:h<CR>
nnoremap <Leader>q :q!<CR>
" -------------------------------------------------------------
" Unite
" -------------------------------------------------------------
nnoremap <silent> <Leader>o :<C-u>Unite file file_rec<CR>
nnoremap <silent> <Leader>m :<C-u>Unite -no-empty file_mru buffer tab<CR>
nnoremap <silent> <Leader>l :<C-u>UniteWithCursorWord -no-empty line<CR>
nnoremap <silent> <Leader>b :<C-u>Unite -no-empty buffer tab<CR>
nnoremap <silent> <Leader>k :<C-u>UniteWithCursorWord -no-empty file_rec file_mru buffer<CR>
nnoremap <silent> <Leader>i :<C-u>Unite -no-empty grep:.:.:file_rec line -buffer-name=files<CR>
nnoremap <silent> <Leader>c :<C-u>Unite -no-empty change<CR>
" -------------------------------------------------------------
" suspend(fgで復帰する)
nnoremap <silent> <Leader>, <C-z>

" 強制書き込みコマンド
cabbr w!! w !sudo tee > /dev/null %

" Key Map
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
vnoremap { "zdi^V{<C-R>z}<ESC>
vnoremap [ "zdi^V[<C-R>z]<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" Buffer
nnoremap <C-n> :bp<CR>
nnoremap <C-p> :bn<CR>
" Tabpage
nnoremap <C-k> :<C-u>tabp<CR>
nnoremap <C-j> :<C-u>tabn<CR>
" You must prepare Directory(ex. mkdir -p ~/.vim/undo)
if has('persistent_undo')
  set undodir=~/.vim/undo
  set undofile
endif
" Keep Cursor Position(Last Position) When Open File
" @see also: https://wiki.archlinuxjp.org/index.php/Vim#Vim_.E3.81.AB.E3.83.95.E3.82.A1.E3.82.A4.E3.83.AB.E3.81.AE.E3.82.AB.E3.83.BC.E3.82.BD.E3.83.AB.E4.BD.8D.E7.BD.AE.E3.82.92.E8.A8.98.E6.86.B6.E3.81.95.E3.81.9B.E3.82.8B
" @see also: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\""
" カスタマイズ
noremap! <C-A> <Home>
noremap! <C-E> <End>
noremap! <C-F> <Right>
noremap! <C-B> <Left>
nnoremap <C-H> ^
nnoremap <C-L> $
" jjでエスケープ
inoremap <silent> jj <ESC>
inoremap <C-H> <C-O>^
inoremap <C-L> <C-O>$
" ターミナルの操作と統一
inoremap <C-W> <C-O>b<C-O>cw
inoremap <C-U> <C-O>^<C-O>d$
inoremap <C-H> <BS>
" 割当
nnoremap ; :
inoremap <C-J> <ESC>
nnoremap <C-L> <ESC>
vnoremap <C-L> <ESC>
" magic
" nnoremap / /\v

nnoremap <silent><C-e> :NERDTreeToggle<CR>

" cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" ブラウザを開く
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
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
"call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/dein.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('vim-airline/vim-airline')
call dein#add('Shougo/vimproc.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neomru.vim')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/vimfiler')
call dein#add('scrooloose/syntastic')
call dein#add('editorconfig/editorconfig-vim')
call dein#add('tyru/open-browser.vim')
call dein#add('kovisoft/slimv.git')
call dein#add('digitaltoad/vim-pug.git')
call dein#add('thinca/vim-quickrun')
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
endif
call dein#end()
" -------------------------------------
" Unite settings
" -------------------------------------
let g:unite_enable_start_insert=0
au FileType unite nnoremap <silent> <buffer> <C-g> :q<CR>
au FileType unite inoremap <silent> <buffer> <C-g> <ESC>:q<CR>
let g:unite_source_file_mru_limit = 300
" バッファから検索
nnoremap <silent> <Leader>ub :<C-u>Unite buffer<CR>
" ディレクトリ以下のファイル名を検索
nnoremap <silent> <Leader>uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタを検索
nnoremap <silent> <Leader>ur :<C-u>Unite -buffer-name=register register<CR>
" 最近開いたファイルを検索
nnoremap <silent> <Leader>um :<C-u>Unite file_mru buffer<CR>
" 現在カーソルの単語をgrepを検索
nnoremap <silent> <Leader>ug :<C-u>Unite grep:. -buffer-name=search-buffer<CR><C-R><C-W>
"nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
  let g:unite_source_grep_max_candidates = 300
endif
" -------------------------------------
let g:airline_powerline_fonts = 1
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_python_checkers = ['flake8']
" for slimv
let g:lisp_rainbow = 1
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sbcl'
" let g:slimv_swank_cmd='!osascript -e "tell application \"iTerm\"" -e "tell the first terminal" -e "set mysession to current session" -e "launch session \"Default Session\"" -e "tell the last session" -e "exec command \"/bin/bash\"" -e "write text \"sbcl --load ~/.vim/dein/repos/github.com/kovisoft/slimv/slime/start-swank.lisp\"" -e "end tell" -e "select mysession" -e "end tell" -e "end tell"'
" 検索系
let g:netrw_nogx = 1
au BufRead,BufNewFile,BufReadPre *.jade   set filetype=pug

if dein#check_install(['vimproc'])
  call dein#install(['vimproc'])
endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif

" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on
filetype detect
syntax on
