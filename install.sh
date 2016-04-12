#!/bin/sh

DOTPATH=./dotfiles
USER=tamanobi

# git が使えるなら git
if hash "git"; then
    git clone --recursive "$GITHUB_URL" "$DOTPATH"

# 使えない場合は curl か wget を使用する
elif type "curl" 2>&1 || type "wget" 2>&1; then
    tarball="https://github.com/$USER/dotfiles/archive/master.tar.gz"
    
    # どっちかでダウンロードして，tar に流す
    if type "curl" 2>&1; then
        curl -L "$tarball"

    elif type "wget" 2>&1; then
        wget -O - "$tarball"

    fi | tar xv -
    
    # 解凍したら，DOTPATH に置く
    mv -f dotfiles-master "$DOTPATH"

else
    echo  "curl or wget required" >&2
    exit 48
fi

cd $HOME/$DOTPATH
if [ $? -ne 0 ]; then
    echo "not found: $DOTPATH" >&2
    exit 2
fi

# 移動できたらリンクを実行する
for f in .??*
do
    [ "$f" = ".git" ] && continue
    [ "$f" = ".DS_Store" ] && continue
    # 上書きするときは確認する
    # ln -sniv "$DOTPATH/$f" "$HOME/$f"
    echo "$f"
done
