#!/bin/bash
#php version
#php path
function release()
{
    cat /etc/issue | head -1| awk '{print tolower($1)}'
}
function phpVerlist()
{
    echo '
    1.) php5.6;
    2.) php7.0;
    3.) php7.1;
    4.) php7.2;
    '
}
function phpPath()
{
    path='/opt/app/php/'
    if [ ! -d $path ]
    then
        sudo mkdir -p $path
    fi
}
function getSource()
{
    #if source does not exist,then download it
    if [ ! -f '/opt/source/php-src/README.md' ]
    then
        path='/opt/source'
        if [ ! -d $path ]
        then
            sudo mkdir -p $path
        fi
        #this may take several moments
        sudo git clone https://github.com/php/php-src.git "$path/php-src"
        cd "$path/php-src/"
        git branch
    else
        echo 'file is located'
    fi
}
function build()
{
    phpVer=7.0
    ./buildconf --force
    ./configure --prefix=/app/php/php/$phpVer --disable-short-tags --enable-xml --enable-cli --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib --enable-bcmath --with-bz2 --with-curl --enable-exif --with-gd --enable-intl --with-mysqli --enable-pcntl --with-pdo-mysql --enable-soap --enable-sockets --with-xmlrpc --enable-zip --with-webp-dir --with-jpeg-dir --with-png-dir --enable-json --enable-hash --enable-mbstring --with-mcrypt --enable-libxml --with-libxml-dir --enable-ctype --enable-calendar --enable-dom --enable-fileinfo --with-mhash --with-incov --enable-opcache --enable-phar --enable-simplexml --with-xsl --with-pear --enable-fpm
    make clean
    make
    make test
    make install
}
phpVerlist
phpPath
getSource

var=$(release)
echo $var
case $var in 
    ubuntu)
        echo $var
    ;;
    debain)
        echo $var
    ;;
    centos)
        echo $var
    ;;
    *)
    echo $var
    ;;
esac
