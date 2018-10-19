#!/bin/bash
function gitInstalled()
{
    #git --version;
    echo 0;
}
if [ $(gitInstalled) -eq 0 ]
then
    echo 'git required:';
    exit;
fi
#install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/tmptest/bundle/Vundle.vim
cp ./linux/.vimrc ~/tmptest/.vimrc
echo "launch vim and install plugin with the command :PluginInstall"

