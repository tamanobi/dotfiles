# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# use zsh
if [ -f /usr/bin/zsh  ];then
    exec /usr/bin/zsh
fi
# VIM
if [ -f ~/mylib/vim/src/vim ]; then
  export VIMRUNTIME=~/mylib/vim/runtime
  export MYVIM=~/mylib/vim/src/vim
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

alias vim="${MYVIM}"
alias vi="${MYVIM}"
alias v="${MYVIM}"
alias la='ls -CFal'
alias g='git'
alias gco="git checkout"
alias gst="git status"
alias gdf="git diff"
alias gg="git grep -n"
alias gb="git branch"
alias glg="git log --graph --oneline --color"
# dstat
alias dstat-full='dstat -Tclmdrn'
alias dstat-mem='dstat -Tclm'
alias dstat-cpu='dstat -Tclr'
alias dstat-net='dstat -Tclnd'
alias dstat-disk='dstat -Tcldr'

if [ -e ~/git-completion.bash ]; then
  source ~/git-completion.bash
else
  if type wget > /dev/null 2>&1; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/git-completion.bash
    source ~/git-completion.bash
  elif type curl > /dev/null 2>&1; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/git-completion.bash
    source ~/git-completion.bash
  else
    echo "cannot download" 1>&2
  fi
fi
if [ -e ~/git-prompt.sh ]; then
  source ~/git-prompt.sh
else
  if type wget > /dev/null 2>&1; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/git-prompt.sh
    source ~/git-prompt.sh
  elif type curl > /dev/null 2>&1; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/git-prompt.sh
    source ~/git-prompt.sh
  else
    echo "cannot download" 1>&2
  fi
fi

GIT_PS1_SHOWDIRTYSTATE=true
# add されていない変更の存在を「＊」で示す
# commit されていない変更の存在を「＋」で示す
GIT_PS1_SHOWUNTRACKEDFILES=true
# add されていない新規ファイルの存在を「％」で示す
GIT_PS1_SHOWSTASHSTATE=true
# stash がある場合は「＄」で示す
export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[34m\]\w\[\033[31m\]$(__git_ps1)\[\033[00m\]\n\$ '
agent="$HOME/.ssh/agent"

if [ -S "$SSH_AUTH_SOCK" ]; then
    case $SSH_AUTH_SOCK in
    /tmp/*/agent.[0-9]*)
        ln -snf "$SSH_AUTH_SOCK" $agent && export SSH_AUTH_SOCK=$agent
    esac
elif [ -S $agent ]; then
    export SSH_AUTH_SOCK=$agent
else
    echo "no ssh-agent"
fi
