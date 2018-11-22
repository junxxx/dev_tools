# Develop tools
development tools
## Cross the great wall [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)
## [Privoxy](http://www.privoxy.org/)
(mac) proxifier

proxy in terminal 
centos 
```
sudo yum install privoxy -y
```
debian(ubuntu)
```
sudo apt-get install privoxy
```
edit the config file
```
sudo vim /etc/privoxy/config
# 转发地址
forward-socks5   /               127.0.0.1:1086 .
# local network do not use proxy
forward         192.168.*.*/     .
forward            10.*.*.*/     .
forward           127.*.*.*/     .
export http_proxy=http://127.0.0.1:8118 https_proxy=http://127.0.0.1:8118
```
## [Vim](https://github.com/vim/vim)
```
download the source file 
cd to source file
(centos 7)./configure --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config
(ubuntu) ./configure --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/config-x86_64-linux-gnu/
make && make install
```
## Cumstome vim edit
manager vim plugin with [Vundle](https://github.com/VundleVim/Vundle.vim)
install Ycm    python ~/.vim/bundle/YouCompleteMe/install.py
use fugitive to manage git in vim edit
install ctags  sudo apt-get install ctags

## node
`npm i npm ` to upgrade

## LNMP 
### nginx
### mysql
### php
### redis
![installRedis](linux/bin/installRedis)
### composer
### golang

## curl git proxy
    check the curl proxy `env |grep -i all_proxy`

    问题：curl 没有反应，也不报错。curl -v 发现走的127.0.0.1的socket代理。
    echo $http_proxy无果,echo $all_proxy(罪在此)。
    其实有更方便快捷的方法定位问题所在。`env`查看所有的shell variable，并查看是否含有proxy关键字。 
    本着打破砂锅问到底的原则，想知道all_proxy这个变量是哪里定义的。
    找了所有引用的文件，没有发现定义这个变量的文件。
    先解决问题: 
    编辑~/.bashrc   unset all_proxy unset ALL_PROXY source ~/.bashrc
    shell加载dotFile顺序 /etc/profile ~/.bash_profile ~/.bash_login ~/.profile
