# Develop tools
development tools
## Cross the great wall [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)
## [Privoxy](http://www.privoxy.org/)
(mac) proxifier

[ShadowsocksX](https://github.com/shadowsocks/ShadowsocksX-NG/releases)
mac下更好。内部已经集成privoxy，全局代理和http代理简单易用。

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
启动

```bash
/etc/init.d/privoxy start 
```

设置开机启动 

```
/etc/rc.local
文件中加入自定义脚本，如果/etc/rc.local文件不存在，则新建并给可执行权限
```



## [Vim](https://github.com/vim/vim)

```
install vim on mac 
brew install macvim --override-system-vim
download the source file 
cd to source file
(centos 7)./configure --enable-pythoninterp=yes --with-python-config-dir=/usr/lib64/python2.7/config
(ubuntu) ./configure --enable-pythoninterp=yes --with-python-config-dir=/usr/lib/config-x86_64-linux-gnu/
make && make install
```
## Cumstome vim edit
manager vim plugin with [Vundle](https://github.com/VundleVim/Vundle.vim)

install [Ycm](https://github.com/Valloric/YouCompleteMe#linux-64-bit)
```
apt-get install python3-dev clang
python3 ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --system-libclang
add below to .vimrc
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
:YcmCompleter GoTo     #goto the definition of variable 
use fugitive to manage git in vim edit
install ctags  sudo apt-get install ctags
```
## tmux
like vim, tmux have conf file name .tmux.conf located in ~/.tmux.conf
tmux shortcut key may have conflict with rime, so suggest to use
the system default input method
split the window to left and right C-b %, up and down C-b "
change the pane C-b then release and press the arrow key


## node
`npm i npm ` to upgrade

## LNMP 
### nginx
### mysql
### php
### redis
[installRedis](linux/bin/installRedis)
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

## centos service 自动补全命令
yum install -y bash-completion
## centos 查看系统是否已安装某软件
yum 安装的--- yum list installed |grep softname

todo ssh setting
## gdb
    gcc -g source.c
    gdb ./a.out
    b line|func_name
    run
    n next line
[ctags](https://blog.csdn.net/wangeen/article/details/22874063)

### Docker

Docker一次构建，多处运行，开发、测试、生产环境保持一致。已经是不二之选。

### K8S

[官方文档](https://kubernetes.io/docs/tasks/tools/install-kubectl/)