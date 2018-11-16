#!/bin/bash
app='vim'
if [[ $# -lt 1 ]]; then
    echo "usage :  $0 version"
    exit
fi
ver=$1
sourcePath='/opt/source'
appPath='/opt/app'
vim="$app-$ver"
if [[ -d $appPath/$vim ]]; then 
    echo "file $appPath/$vim exists, quit"
    exit
fi
if [[ ! -d $sourcePath ]]; then 
    sudo mkdir -p $sourcePath
fi

cd $sourcePath
if [[ ! -f "$sourcePath/v$ver" ]]; then 
    wget  "https://codeload.github.com/vim/vim/tar.gz/v$ver" 
fi
if [[ -f "v$ver" ]]; then
    tar xzf "v$ver"
    cd $vim
else
    echo "file $vim does not exists"
fi
