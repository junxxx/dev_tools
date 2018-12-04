#!/bin/bash
app=nginx
appVer=1.14.1
#check group user nginx exist or not
if [ -z `grep -E "$app:" /etc/passwd` ]
then
    useradd -r nginx -s /bin/false
fi
if [ -z `grep -E "$app:" /etc/group` ]
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
if [ ! -f $sourceDir/nginx.tar.gz ]; then
    wget -O $sourceDir/nginx.tar.gz http://nginx.org/download/nginx-$appVer.tar.gz
fi
cd $sourceDir
if [ -d /opt/app/$app ]; then
    echo "app /opt/app/$app already exist, install quit."
    exit
fi
tar xvf nginx.tar.gz
cd nginx-$appVer 
./configure --prefix=/opt/app/$app --user=nginx --group=nginx --with-http_v2_module --with-http_gunzip_module 
make
make install
rm -rf $sourceDir/nginx.tar.gz $sourceDir/nginx-$appVer
