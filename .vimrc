scriptencoding utf-8
set nocompatible
set encoding=utf-8
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
inoremap <C-J> <ESC>
inoremap {{ <ESC>
set history=1000
set title
set number
set hidden
set tabstop=2
set shiftwidth=2
set scrolloff=1000
set ignorecase
set smartcase
set wrapscan
set noswapfile
set nobackup
set smarttab
set expandtab
set autoindent
set smartindent
set hlsearch
set incsearch
set ambiwidth=double " □や○文字が崩れる問題を解決

set tabstop=4
set autoindent
set expandtab
set shiftwidth=4

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
set list
" 入力中のコマンドを表示する
set showcmd
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
nnoremap <RightMouse> :echo expand('%')<CR>
nnoremap <2-LeftMouse> :echo expand('%')<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>v :vs<CR>
nnoremap <Leader>g :grep <C-R>=expand("<cword>")<CR>
nnoremap <Leader>n :cn<CR>
nnoremap <Leader>p :cp<CR>
nnoremap <Leader>h :noh<CR>
nnoremap <Leader>c :clist<CR>
nnoremap <Leader>e :e<space>%:h<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>b :buffers<CR>:buffer<SPACE>
nnoremap <Leader>j :e <C-R>=expand('<cword>')<CR><CR>
"set tags=/mnt/ssd1/home/yasu/local/etc/tags
set tags=
nnoremap tj :tag<CR>
nnoremap tk :pop<CR>
" -------------------------------------------------------------
" Unite
" -------------------------------------------------------------
let g:unite_enable_start_insert=1
nnoremap <silent> <Leader>f :<C-u>Unite -start-insert file_rec/async:!<CR>
nnoremap <silent> <Leader>m :<C-u>Unite -no-empty file_mru buffer tab<CR>
nnoremap <silent> <Leader>l :<C-u>UniteWithCursorWord -no-empty line<CR>
nnoremap <silent> <Leader>k :<C-u>UniteWithCursorWord -no-empty file_rec file_mru buffer<CR>
nnoremap <silent> <Leader>i :<C-u>Unite -no-empty grep:.:.:file_rec line -buffer-name=files<CR>
" -------------------------------------------------------------
" suspend(fgで復帰する)
nnoremap <silent> <Leader>, <C-z>

" 強制書き込みコマンド
cabbr w!! w !sudo tee > /dev/null %

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
nnoremap <C-A> ^
nnoremap <C-E> $
nnoremap <C-H> ^
nnoremap <C-L> $
" jjでエスケープ
inoremap <silent> jj <ESC>
" ターミナルの操作と統一
inoremap <C-W> <C-O>b<C-O>cw
inoremap <C-U> <C-O>^<C-O>d$
inoremap <C-H> <BS>
" 割当
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;
inoremap <Up> k
inoremap <Down> j
inoremap <Right> l
inoremap <Left> h
nnoremap <Up> k
nnoremap <Down> j
nnoremap <Right> l
nnoremap <Left> h
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-a> <C-b>
cnoremap <C-e> <C-e>
cnoremap <C-u> <C-e><C-u>
"cnoremap <C-v> <C-f>a
" magic
" nnoremap / /\v
" 行末から次の行へ移動できる
set whichwrap=b,s,<,>,[,]

cnoremap <expr> / (getcmdtype() == '/') ? '\/' : '/'
cnoremap <expr> ? (getcmdtype() == '?') ? '\?' : '?'
cnoremap <C-g> <ESC>
" for speed-up replacing
nnoremap gr  :<C-u>%s///g<Left><Left>
vnoremap gr  :s///g<Left><Left>

nnoremap <Space>o  :e %:h<CR>
nnoremap <Space>t  :tabe %<CR>

" cursor
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

function! GetPHPCurrentClass()
  normal! 99[{
  if search('\<class\>', 'bW') == 0
    return ''
  endif
  normal! Wyiw
  normal! ``
  return @0
endfunction

inoremap ,p x<Left><C-r>=GetPHPCurrentClass()<Enter><Delete>

" ブラウザを開く
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
" Plug in
if has('vim_starting')
endif
" -------------------------------------
" Quickfix
" -------------------------------------
au FileType qf nnoremap <silent><buffer>q :quit<CR>
" -------------------------------------
" Quickrun
" -------------------------------------
nnoremap <silent> <Leader>r :<C-u>QuickRun<CR>
nnoremap <Leader>3 :e #<CR>
" -------------------------------------
" -------------------------------------
" Unite settings
" -------------------------------------
let g:unite_enable_start_insert=0
au FileType unite nnoremap <silent> <buffer> q :q<CR>
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
" -------------------------------------
" for slimv
" -------------------------------------
let g:lisp_rainbow = 1
let g:slimv_lisp = 'ros run'
let g:slimv_impl = 'sbcl'
" let g:slimv_swank_cmd='!osascript -e "tell application \"iTerm\"" -e "tell the first terminal" -e "set mysession to current session" -e "launch session \"Default Session\"" -e "tell the last session" -e "exec command \"/bin/bash\"" -e "write text \"sbcl --load ~/.vim/dein/repos/github.com/kovisoft/slimv/slime/start-swank.lisp\"" -e "end tell" -e "select mysession" -e "end tell" -e "end tell"'
" -------------------------------------
" 検索系
let g:netrw_nogx = 1

au BufRead,BufNewFile,BufReadPre *.jade   set filetype=pug

" -------------------------------------
" Yank Round
" -------------------------------------
let g:yankround_max_history = 100
"nmap p <Plug>(yankround-p)
"nmap P <Plug>(yankround-P)
"nmap <expr><C-p> yankround#is_active() ? "\<Plug>(yankround-prev)" : ":bp<CR>"
"nmap <expr><C-n> yankround#is_active() ? "\<Plug>(yankround-next)" : ":bn<CR>"


" -------------------------------------
" Cursor Word Highlight
" -------------------------------------
let g:enable_highlight_cursor_word = 1
augroup highlight-cursor-word
  autocmd!
  autocmd CursorMoved * call s:hl_cword()
  " カーソル移動が重くなったと感じるようであれば
  " CursorMoved ではなくて
  " CursorHold を使用する
  "     autocmd CursorHold * call s:hl_cword()
  " 単語のハイライト設定
  "autocmd ColorScheme * highlight CursorWord cbg=Red
  "hi CursorWord term=bold cterm=bold ctermfg=yellow ctermbg=Red
  "hi CursorWord term=bold cterm=bold ctermfg=red ctermbg=yellow
  hi CursorWord term=bold,underline cterm=bold,underline
  autocmd BufLeave * call s:hl_clear()
  autocmd WinLeave * call s:hl_clear()
  autocmd InsertEnter * call s:hl_clear()
augroup END

function! s:hl_clear()
  "if exists("b:highlight_cursor_word_id") && exists("b:highlight_cursor_word")
  "  silent! call matchdelete(b:highlight_cursor_word_id)
  "  unlet b:highlight_cursor_word_id
  "  unlet b:highlight_cursor_word
  "endif
  if exists("b:highlight_cursor_word_id") && exists("b:highlight_cursor_word")
    silent! call matchdelete(b:highlight_cursor_word_id)
    let b:highlight_cursor_word = ""
  endif
endfunction

function! s:hl_cword()
  let word = expand("<cword>")
  if word == ""
    return
  endif
  if get(b:, "highlight_cursor_word", "") ==# word
    return
  endif
  call s:hl_clear()
  if g:enable_highlight_cursor_word == 0
    return
  endif
  if !empty(filter(split(word, '\zs'), "strlen(v:val) > 1"))
    return
  endif
  let pattern = printf("\\<%s\\>", expand("<cword>"))
  silent! let b:highlight_cursor_word_id = matchadd("CursorWord", pattern)
  let b:highlight_cursor_word = word
endfunction
" -------------------------------------
" grep設定
" ag -> ack -> grep の順に優先して使用
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

set makeprg=~/pixiv/dev-script/pixiv-lint
set errorformat&
let &errorformat .= ",file:%f\tline:%l\tcol:%c-%*\\d\tlevel:%t%*\\S\tdesc:%m"

" -------------------------------------
" ファイルタイプ別のプラグイン/インデントを有効にする
filetype plugin indent on
filetype detect
syntax on
set synmaxcol=500
colorscheme desert

