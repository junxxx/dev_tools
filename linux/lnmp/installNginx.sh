#!/bin/bash
app=nginx
#check group nginx exist 
if ! grep -E $app /etc/passwd
then
    useradd -r nginx -s /bin/false
fi
if ! grep -E $app /etc/group
then
    groupadd nginx 
fi
usermod -a -G nginx nginx

sourceDir=/opt/source
appDir=/opt/app
if [ ! -d $sourceDir ]; then
    mkdir -p $sourceDir
fi
if [ ! -d $appDir ]; then
    mkdir -p $appDir
fi
cd $sourceDir
wget -O nginx.tar.gz http://nginx.org/download/nginx-1.14.1.tar.gz
tar xvf nginx.tar.gz
cd nginx-1.14.1 
./configure --prefix=/opt/app/nginx --user=nginx --group=nginx --with-http_v2_module --with-http_gunzip_module 
make
make install
