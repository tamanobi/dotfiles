scriptencoding utf-8
set ambiwidth=double " □や○文字が崩れる問題を解決
set autoindent
set cursorline
set display=lastline
set encoding=utf-8
set expandtab
set hidden
set history=10000
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

" 拡張子指定grep
command! -bang -nargs=+ -complete=file Grep call s:Grep(<bang>0, <f-args>)
function! s:Grep(bang, pattern, directory, ...)
    let grepcmd = []
    call add(grepcmd, 'grep' . (a:bang ? '!' : ''))
    if executable('ag')
        if a:0 && a:1 != ''
            call add(grepcmd, '-G "\.' . a:1 . '$"')
        else
            call add(grepcmd, '-a')
        endif
    elseif executable('ack')
        if a:0 && a:1 != ''
            call add(grepcmd, '--' . a:1)
        else
            call add(grepcmd, '--all')
        endif
    else
        if a:0 && a:1 != ''
            call add(grepcmd, '--include="*.' . a:1 . '"')
        endif
    endif
    call add(grepcmd, a:pattern)
    call add(grepcmd, a:directory)
    execute join(grepcmd, ' ')
endfunction

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
"inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" -------------------------------------
" dein
" -------------------------------------
" dein settings {{{
" dein自体の自動インストール
if &compatible
   set nocompatible
endif
" set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
" let s:cache_home = expand('~/.vim')
" let s:dein_dir = s:cache_home . '/dein'
" let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
" if !isdirectory(s:dein_repo_dir)
"   call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
" endif
" let &runtimepath = s:dein_repo_dir .",". &runtimepath
" " プラグイン読み込み＆キャッシュ作成
" let s:toml_file = fnamemodify(expand('<sfile>'), ':h').'/dein.toml'
" if dein#load_state(s:dein_dir)
"   call dein#begin(s:dein_dir, [$MYVIMRC, s:toml_file])
"   call dein#add('Shougo/dein.vim')
"   call dein#add('jiangmiao/auto-pairs')
"   call dein#add('scrooloose/nerdtree')
"   call dein#add('vim-airline/vim-airline-themes')
"   call dein#add('vim-airline/vim-airline')
"   call dein#add('LeafCage/yankround.vim')
"   call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
"   call dein#add('Shougo/neocomplete.vim')
"   call dein#add('Shougo/neomru.vim')
"   call dein#add('editorconfig/editorconfig-vim')
"   call dein#add('Shougo/unite.vim')
"   call dein#add('Shougo/vimfiler')
"   call dein#add('scrooloose/syntastic')
"   call dein#add('editorconfig/editorconfig-vim')
"   call dein#add('tyru/open-browser.vim')
"   call dein#add('kovisoft/slimv.git')
"   call dein#add('digitaltoad/vim-pug.git')
"   call dein#add('thinca/vim-quickrun')
"   call dein#add('tpope/vim-surround')
"   call dein#add('tpope/vim-fugitive')
"   if has('nvim')
"     call dein#add('Shougo/deoplete.nvim')
"     let g:deoplete#enable_at_startup = 1
"   endif
"   call dein#end()
"   call dein#save_state()
" endif
" if dein#check_install(['vimproc'])
"   call dein#install(['vimproc'])
" endif
" 
" " 不足プラグインの自動インストール
" if has('vim_starting') && dein#check_install()
"   call dein#install()
" endif

" }}}

function! Test()
	let lines = [
		\ "回答を選択してください。",
		\ "1 : A answer",
		\ "2 : B answer",
		\ "3 : C answer",
		\ "4 : D answer"
		\ ]
	let choice = inputlist(lines)
	if choice == 1
		echo "user select 'A answer'"
	elseif choice == 2
		echo "user select 'B answer'"
	elseif choice == 3
		echo "user select 'C answer'"
	elseif choice == 4
		echo "user select 'D answer'"
	else
		echo "1から4までのどれかを選択してください"
	endif
endfunction

function! Gitadd()
  let f = expand("%")
  call system('git add '.f)
endfunction
nnoremap <Leader>a :call Gitadd()<CR>

function! Gitcommit()
  call system('git commit -v')
endfunction
nnoremap <Leader>m :call Gitcommit()<CR>

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
