#!/bin/bash
# the script will set the linux dev environment 

function copyShell() {
    bashrc=./linux/.bashrc
    bashalias=./linux/.bashalias
    if [ -f $bashrc ] then  cat $bashrc >> ~/.bashrc fi
    if [ -f $bashalias ] then  cat $bashalias >> ~/.bashalias fi
}
function installVim() {
    #todo install vim vundle global
    #install vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/tmptest/bundle/Vundle.vim
    cp ./linux/.vimrc ~/tmptest/.vimrc
    echo "launch vim and install plugin with the command :PluginInstall"
}
function installSS() {

}

function installPrivoxy() {

}

function gitInstalled() {
    #git --version;
    echo 0;
}
if [ $(gitInstalled) -eq 0 ]
then
    echo 'git required:';
    exit;
fi

