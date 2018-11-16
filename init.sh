#!/bin/bash
# the script will set the linux dev environment 
src=./linux

function copyShell() {
    bashrc=./linux/.bashrc
    bashalias=./linux/.bashalias
    if [ -f $bashrc ] 
    then  cat $bashrc >> ~/.bashrc 
    fi
    if [ -f $bashalias ] 
    then  cat $bashalias >> ~/.bashalias 
    fi
}
function installVim() {
    #todo install vim vundle global
    vimfile=$src/vim/.vim
    vimrc=$src/vim/.vimrc
    vimpath=/usr/local/share/vim/
    if [ ! -d $vimpath ] 
    then sudo mkdir $vimpath 
    fi
    sudo mv $vimfile $vimrc $vimpath
    if [ -f $vimfile ] 
    then  mv $vimfile $vimpath/ 
    fi
    echo "launch vim and install plugin with the command :PluginInstall"
}
function installSS() {
    #centos
    yum install epel-release -y
    yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y

    echo 'todo'
}

function installPrivoxy() {
    echo 'todo'
}

function gitInstalled() {
    git --version | awk '{print tolower($1)}'
}
gitInstalled
if [ $(gitInstalled) -eq 0 ]
then
    echo 'git required:';
    exit;
fi

#installVim

