# -------------------------------------
# 環境変数
# -------------------------------------
# SSHで接続した先で日本語が使えるようにする
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
# VIM
if [ -f ~/mylib/vim/src/vim ]; then
  export MYVIM="VIMRUNTIME=~/mylib/vim/runtime ~/mylib/vim/src/vim"
else
  export MYVIM=/usr/local/bin/vim
fi
# エディタ
export EDITOR="${MYVIM}"
# ページャ
if [ -f /usr/local/bin/vimpager ]; then
  export PAGER=/usr/local/bin/vimpager
  export MANPAGER=/usr/local/bin/vimpager
else
  export PAGER=/usr/bin/less
  export MANPAGER=/usr/bin/less
fi

# -------------------------------------
# zshのオプション
# -------------------------------------
## 入力しているコマンド名が間違っている場合にもしかして：を出す。
setopt correct
# ビープを鳴らさない
setopt nobeep
## 色を使う
setopt prompt_subst
## ^Dでログアウトしない。
setopt ignoreeof
## バックグラウンドジョブが終了したらすぐに知らせる。
setopt no_tify
# 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
# 補完
## タブによるファイルの順番切り替えをしない
unsetopt auto_menu
# cd -[tab]で過去のディレクトリにひとっ飛びできるようにする
setopt auto_pushd
# ディレクトリ名を入力するだけでcdできるようにする
setopt auto_cd
# 色を使用出来るようにする
autoload -Uz colors
colors
# emacs 風キーバインドにする
bindkey -e

# -------------------------------------
# パス
# -------------------------------------
# 重複する要素を自動的に削除
typeset -U path cdpath fpath manpath
path=(
    $HOME/bin(N-/)
    /usr/local/bin(N-/)
    /usr/local/sbin(N-/)
    $path
)

# -------------------------------------
# プロンプト
# -------------------------------------
autoload -U promptinit; promptinit
autoload -Uz colors; colors
autoload -Uz vcs_info
autoload -Uz is-at-least

# begin VCS
zstyle ":vcs_info:*" enable git svn hg bzr
zstyle ":vcs_info:*" formats "(%s)-[%b]"
zstyle ":vcs_info:*" actionformats "(%s)-[%b|%a]"
zstyle ":vcs_info:(svn|bzr):*" branchformat "%b:r%r"
zstyle ":vcs_info:bzr:*" use-simple true

zstyle ":vcs_info:*" max-exports 6

if is-at-least 4.3.10; then
    zstyle ":vcs_info:git:*" check-for-changes true # commitしていないのをチェック
    zstyle ":vcs_info:git:*" stagedstr "<S>"
    zstyle ":vcs_info:git:*" unstagedstr "<U>"
    zstyle ":vcs_info:git:*" formats "(%b) %c%u"
    zstyle ":vcs_info:git:*" actionformats "(%s)-[%b|%a] %c%u"
fi

function vcs_prompt_info() {
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && echo -n " %{$fg[yellow]%}$vcs_info_msg_0_%f"
}
# end VCS

#OK="^_^ "
#NG=">_< "
OK=$'\U1F60C '
NG=$'\U1F525 '

PROMPT=""
PROMPT+="%(?.%F{green}$OK%f.%F{red}$NG%f) "
PROMPT+="%F{blue}%~%f"
PROMPT+="\$(vcs_prompt_info)"
PROMPT+="
"
PROMPT+="%% "

RPROMPT="[%*]"

# -------------------------------------
# 補完機能
# -------------------------------------
setopt   auto_list auto_param_slash list_packed rec_exact
unsetopt list_beep
# http://qiita.com/syui/items/ed2d36698a5cc314557d
# http://tarao.hatenablog.com/entry/20100531/1275322620
zstyle ':completion:*:default' menu select=2
zstyle ':completion:*' format '%F{yellow}%d%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.]=**'
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' keep-prefix
zstyle ':completion:*' completer _expand _oldlist _complete _match _prefix _approximate _list _history
setopt auto_list  # 補完候補が複数ある時に、一覧表示
setopt auto_menu  # 補完候補が複数あるときに自動的に一覧表示する
#bindkey '^i'  menu-expand-or-complete
bindkey '^i'  expand-or-complete
bindkey '^[^i'  reverse-menu-complete
bindkey '^[i' expand-or-complete
autoload -U compinit
compinit -u

# -------------------------------------
# エイリアス
# -------------------------------------
# -n 行数表示, -I バイナリファイル無視, svn関係のファイルを無視
alias grep="grep --color -n -I --exclude='*.svn-*' --exclude='entries' --exclude='*/cache/*'"
alias e="emacs"
alias vim="${MYVIM}"
alias vi="${MYVIM}"
alias v="${MYVIM}"
alias google="w3c"

# ls
alias ls="ls -G" # color for darwin
alias l="ls -la"
alias la="ls -la"
alias l1="ls -1"

# tree
alias tree="tree -NC" # N: 文字化け対策, C:色をつける

# -------------------------------------
# git alias
# -------------------------------------
alias g="git"
alias gg="git grep"
alias g="git"
alias gs="git status"
alias gco="git checkout"
alias gcm="git commit"
alias glg="git log --graph --date=short --decorate=short --pretty=format:'%Cgreen%h %Creset%cd %Cblue%cn %Cred%d %Creset%s"
alias gb="git for-each-ref --sort='-*committerdate' --format='%(refname:short)' refs/heads/"
alias -g B='`gb | peco | sed -e "s/^\* //g" | awk "{print $1}"`'
alias pd="popd"
# -------------------------------------
# キーバインド
# -------------------------------------
function cdup() {
   echo
   cd ..
   zle reset-prompt
}
zle -N cdup
#bindkey '^K' cdup

# -------------------------------------
# その他
# -------------------------------------

# cdしたあとで、自動的に ls する
function chpwd() { ls }

# iTerm2のタブ名を変更する
function title {
    echo -ne "\033]0;"$*"\007"
}

function ptvim(){
  local file
  file=$(pt $@ | peco | awk -F: '{printf  $1 " -c" $2}'| sed -e 's/\-c$//')
  if [ ${#file} -gt 0 ]; then
    eval '${MYVIM} ${=file}'
  fi
}

function peco-dir-open-app () {
    find . | peco -b 100 | xargs sh -c '${MYVIM} "$0" < /dev/tty'
    zle clear-screen
}
zle -N peco-dir-open-app
bindkey '^xo' peco-dir-open-app     # C-x t

# git directory
function peco-git-dir-open-app () {
    git ls-files | peco | xargs sh -c '${MYVIM} "$0" < /dev/tty'
    zle clear-screen
}
zle -N peco-git-dir-open-app
bindkey '^o' peco-git-dir-open-app     # C-o

# ヒストリー
function peco-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(\history -n 1 | \
        eval $tac | \
        peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^R' peco-select-history

# -------------------------------------
# zplug
# -------------------------------------
source ~/.zplug/zplug
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting"
zplug "b4b4r07/enhancd", of:enhancd.sh
zplug "hchbaw/auto-fu.zsh"
zplug "stedolan/jq", from:gh-r, as:command \
    | zplug "b4b4r07/emoji-cli", if:"which jq"
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
zplug load --verbose

# -------------------------------------
# auto-fu
# -------------------------------------
function zle-line-init () {
  auto-fu-init
}
zle -N zle-line-init
function () {
  local code
  code=${functions[auto-fu-init]/'\n-azfu-'/''}
  eval "function auto-fu-init () { $code }"
  code=${functions[auto-fu]/fg=black,bold/fg=white}
  eval "function auto-fu () { $code }"
}
function afu+cancel () {
  afu-clearing-maybe
  ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
}
function bindkey-advice-before () {
  local key="$1"
  local advice="$2"
  local widget="$3"
  [[ -z "$widget" ]] && {
    local -a bind
    bind=(`bindkey -M main "$key"`)
    widget=$bind[2]
  }
  local fun="$advice"
  if [[ "$widget" != "undefined-key" ]]; then
    local code=${"$(<=(cat <<"EOT"
      function $advice-$widget () {
        zle $advice
        zle $widget
      }
      fun="$advice-$widget"
EOT
    ))"}
    eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
  fi
  zle -N "$fun"
  bindkey -M afu "$key" "$fun"
}
bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-l
