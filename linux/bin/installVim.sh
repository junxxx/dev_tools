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
python2Config="/usr/lib/python2.7/config-i386-linux-gnu/"
python3Config="/usr/lib/python3.5/config-3.5m-i386-linux-gnu/"

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
if [[ ! -d $appPath/$vim ]]; then
    sudo mkdir -p $appPath/$vim
fi
if [[ -f "v$ver" ]]; then
    tar xzf "v$ver"
    cd $vim
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=$python2Config \ # pay attention here check directory correct
        # prefix does not work
        #--prefix=$appPath/$vim
    sudo make && make install
else
    echo "file $vim does not exists"
fi
