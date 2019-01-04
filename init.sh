#!/bin/bash
# the script will set the linux dev environment 
src=./linux

copyShell() {
    bashrc=./linux/.bashrc
    bashalias=./linux/.bashalias
    if [ -f $bashrc ] 
    then  cat $bashrc >> ~/.bashrc 
    fi
    if [ -f $bashalias ] 
    then  cat $bashalias >> ~/.bashalias 
    fi
}
installVim() {
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
installSS() {
    #centos
    yum install epel-release -y
    yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto c-ares-devel libev-devel libsodium-devel mbedtls-devel -y

    echo 'todo'
}

installPrivoxy() {
    #centos
    sudo yum install privoxy
    #debian
    sudo apt-get install privoxy
}

gitInstalled() {
    git --version | awk '{print tolower($1)}'
}

#get api doc for linux
getZeal() {
    #debain or ubuntu 
    sudo apt-get install zeal
}

installVbox() {
    echo 'todo install virtual box' 
}

if [ $(gitInstalled) -eq 0 ]
then
    echo 'git required:';
    exit;
fi

#install custom shell git,ss-local,privoxy,vim,
#install nginx,php,mysql,
#installVim
_main() {
    echo 'installVbox';
    echo 'installPhp';
    echo 'installNginx';
    echo 'installMysql';
    echo 'installRedis';
}

_main
