export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=/usr/local/bin/git:$PATH
#export PYENV_ROOT="${HOME}/.pyenv"
#if [ -d "${PYENV_ROOT}" ]; then
#  export PATH=${PYENV_ROOT}/bin:${PYENV_ROOT}/shims:${PATH}
#  eval "$(pyenv init -)"
#fi

export PYTHONPATH=/usr/local/lib/python2.7/site-packages/$PYTHONPATH

##
# Your previous /Users/Kohki/.bash_profile file was backed up as /Users/Kohki/.bash_profile.macports-saved_2014-12-10_at_02:16:51
##

# MacPorts Installer addition on 2014-12-10_at_02:16:51: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


##
# Your previous /Users/Kohki/.bash_profile file was backed up as /Users/Kohki/.bash_profile.macports-saved_2015-06-26_at_18:41:15
##

# MacPorts Installer addition on 2015-06-26_at_18:41:15: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# gls
alias ls='/usr/local/bin/gls --color=auto'
eval $(/usr/local/bin/gdircolors/ /Users/Kohki/settings/dircolors.ansi-universal)

HISTSIZE=5000       # 現在使用中のbashが保持する履歴数
HISTFILESIZE=5000   # 履歴ファイルに保存される履歴数
# HISTCONTROL=ignoredups  # 同じコマンドが連続する場合は1回だけ記録する
HISTCONTROL=ignorespace # コマンドの頭にスペースを付けて実行すると記録しない
# HISTCONTROL=ignoreboth    # ignoredupsとignorespaceどちらも設定する
HISTIGNORE=history     # historyは記録しない。

# added by Anaconda 2.3.0 installer
export PATH="/Users/Kohki/anaconda/bin:$PATH"
source ~/.bashrc
