alias la='ls -CFal'
alias g='git'
alias gco="g checkout"
alias gst="g status"
alias gdf="g diff"
alias gbr="g branch"
alias glg="g log --graph --oneline --color"

if [ -e ~/git-completion.bash]; then
  source ~/git-completion.bash
else
  if type wget > /dev/null 2>&1; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -O ~/git-completion.bash
  elif type curl > /dev/null 2>&1; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash -o ~/git-completion.bash
  else
    echo "cannot download" 1>&2
  fi
fi
if [ -e ~/git-prompt.sh]; then
  source ~/git-prompt.bash
else
  if type wget > /dev/null 2>&1; then
    wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/git-prompt.sh
  elif type curl > /dev/null 2>&1; then
    curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -o ~/git-prompt.sh
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
