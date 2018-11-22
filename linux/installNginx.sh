#!/bin/bash

useradd nginx
goupadd nginx 
usermod -a -G nginx nginx

cd /opt/source
wget -O nginx.tar.gz http://nginx.org/download/nginx-1.14.1.tar.gz
tar xvf nginx.tar.gz
cd nginx-1.14.1 
./configure --prefix=/opt/app/nginx --user=nginx --group=nginx --with-http_v2_module --with-http_gunzip_module 
make
make install
