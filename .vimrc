scriptencoding utf-8
set ambiwidth=double " □や○文字が崩れる問題を解決
set autoindent
set cursorline
set display=lastline
set encoding=utf-8
set expandtab
set hidden
set history=100000
set hlsearch
set ignorecase
set incsearch
set list
set listchars=tab:>-,extends:<,trail:-
set matchtime=1
set nobackup
set nocompatible
set nospell
set noswapfile
set number
set scrolloff=1000
set shiftwidth=4
set showcmd " 入力中のコマンドを表示する
set showmatch
set smartcase
set smartindent
set smarttab
set tabstop=4
set title
set whichwrap=b,s,<,>,[,] " 行末から次の行へ移動できる
set wildmenu wildmode=list:full
set wrapscan

" http://www.atmarkit.co.jp/ait/articles/1107/21/news115_3.html
if has('mouse')
  set mouse=a
  if has('mouse_sgr')
  set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632')
  set ttymouse=sgr
  else
  set ttymouse=xterm
  endif
endif
hi CursorLineNr term=bold cterm=bold ctermfg=228 ctermbg=8
if has('gui') || has('xterm_clipboard')
  set clipboard=unnamed
endif
if has('persistent_undo') " need to prepare Directory(ex. mkdir -p ~/.vim/undo)
  set undodir=~/.vim/undo
  set undofile
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
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>g :grep <C-R>=expand("<cword>")<CR>
nnoremap <Leader>n :cn<CR>
nnoremap <Leader>p :cp<CR>
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>c :clist<CR>
nnoremap <Leader>e :e<space>%:h<CR>
nnoremap <Leader>b :buffers<CR>:buffer<SPACE>
nnoremap <Leader>j :e <C-R>=expand('<cword>')<CR><CR>
nnoremap tj :tag<CR>
nnoremap tk :pop<CR>
nnoremap <silent> <Leader>, <C-z>
" can use arrows
inoremap <Up> k
inoremap <Down> j
inoremap <Right> l
inoremap <Left> h
nnoremap <Up> k
nnoremap <Down> j
nnoremap <Right> l
nnoremap <Left> h
" cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
" Buffer
nnoremap <C-n> :bp<CR>
nnoremap <C-p> :bn<CR>
" Tabpage
nnoremap <C-k> :<C-u>tabp<CR>
nnoremap <C-j> :<C-u>tabn<CR>
nnoremap <C-H> ^
nnoremap <C-L> $
inoremap <silent> jj <ESC> " jjでエスケープ
" use change command mode easier
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
nnoremap <Enter> :
vnoremap <Enter> :
" for speed-up replacing
nnoremap gr  :<C-u>%s///g<Left><Left>
vnoremap gr  :s///g<Left><Left>

nnoremap <Leader>o  :e %:h<CR>
nnoremap <Leader>3  :e #<CR>
nnoremap <Leader>t  :tabe %<CR>

" 入力支援
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
vnoremap " "zdi"<C-R>z"<ESC>

" 選択範囲を検索
vnoremap / "zy<ESC>/<C-R>z<CR>

" ターミナルの操作と統一
inoremap <C-W> <C-O>b<C-O>cw
inoremap <C-U> <C-O>^<C-O>d$
inoremap <C-H> <BS>

cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'
cnoremap <expr> ? (getcmdtype() == '?') ? '\?' : '?'

nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>

if has("autocmd")
" Keep Cursor Position(Last Position) When Open File
" @see also: https://wiki.archlinuxjp.org/index.php/Vim#Vim_.E3.81.AB.E3.83.95.E3.82.A1.E3.82.A4.E3.83.AB.E3.81.AE.E3.82.AB.E3.83.BC.E3.82.BD.E3.83.AB.E4.BD.8D.E7.BD.AE.E3.82.92.E8.A8.98.E6.86.B6.E3.81.95.E3.81.9B.E3.82.8B
" @see also: http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
au FileType qf nnoremap <silent><buffer>q :quit<CR>
endif

" grep設定: ag -> ack -> grep の順に優先して使用
if executable('ag')
  set grepprg=ag\ --nogroup\ -iS
  set grepformat=%f:%l:%m
elseif executable('ack')
  set grepprg=ack\ --nogroup
  set grepformat=%f:%l:%m
else
  set grepprg=grep\ -Hnd\ skip\ -r
  set grepformat=%f:%l:%m,%f:%l%m,%f\ \ %l%m
endif
let &grepprg = 'git grep -n -i'

" バッファーを開く
function! OpenBufferList()
  redir => buffer_selector
  execute "silent ls"
  redir END
  vnew
  setlocal modifiable noreadonly
  setlocal bufhidden=unload
  setlocal noswapfile
  setlocal filetype=bufferselector
  silent put =buffer_selector
  execute "1,2delete _"
  setlocal nomodifiable readonly
endfunction
function! SelectThisBuffer()
  let line = getline(".")
  let line = substitute(line, '^\s\+\|\s\+$', "", "g")
  let line = substitute(line, '\s\+', " ", "g")
  let repl = split(line, " ")
  execute repl[0]."buffer!"
endfunction
autocmd FileType bufferselector nnoremap <buffer> q :close!<CR>
autocmd FileType bufferselector nnoremap <buffer> <CR> :call SelectThisBuffer()<CR>

filetype plugin indent on
filetype detect
syntax on
colorscheme desert
