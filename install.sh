#!/bin/sh

DOTPATH=~/dotfiles
USER=tamanobi

function has () {
  type "$1" > /dev/null 2>&1
}

# git が使えるなら git
if has "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif has "curl" || has "wget"; then
    tarball="https://github.com/$USER/dotfiles/archive/master.tar.gz"
    
    # どっちかでダウンロードして，tar に流す
    if has "curl"; then
        curl -L "$tarball"

    elif has "wget"; then
        wget -O - "$tarball"

    fi | tar xv -
    
    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"
else
    echo  "curl or wget required" >&2
    exit 48
fi

cd $DOTPATH
if [ $? -ne 0 ]; then
    echo "not found: $DOTPATH" >&2
    exit 2
fi

# 移動できたらシンボリックリンクを貼る
for f in .??*;
do
  if [ $f == .CFUserTextEncoding ]; then continue
  fi
  if [ $f == .git ]; then continue
  fi
  if [ $f == .DS_Store ]; then continue
  fi
  # 上書きする
  echo $DOTPATH/$f "---" $HOME/$f;
  ln -snfv "$DOTPATH/$f" "$HOME/$f"
done
