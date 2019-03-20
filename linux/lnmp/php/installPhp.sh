#!/bin/bash
#php version
#php path
verList=("php5.6" "php7.0" "php7.1" "php7.2" "php7.3")
stable=("5.6.40" "7.0.33" "7.1.27" "7.2.16" "7.3.3")
green="\e[32m"

function phpVerlist()
{
    ## get length of $verList array
    len=${#verList[@]}
     
    ## Use bash for loop 
    for (( i=0; i<$len; i++ )); 
    do
        echo $i".) ${verList[$i]}" ; 
    done
}
function getSource()
{
    if [ ! -f $sourcePath/$app$version.tar.gz ]; then
        wget -O $sourcePath/$app$version.tar.gz http://am1.php.net/distributions/php-$version.tar.gz
        #todo get another source
        #https://codeload.github.com/php/php-src/tar.gz/php-$version
    fi
}
function build()
{
    #make sure the required lib was installed
    sudo yum -y install gcc-c++ autoconf automake libtool re2c flex bison libxml2-devel  bzip2-devel curl-devel libwebp-devel libjpeg-turbo-devel \libpng-devel libicu-devel libxslt-devel libzip-devel
    ./buildconf --force
    ./configure --prefix=$appPath --disable-short-tags --enable-xml --enable-cli --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib --enable-bcmath --with-bz2 --with-curl --enable-exif --with-gd --enable-intl --with-mysqli --enable-pcntl --with-pdo-mysql --enable-soap --enable-sockets --with-xmlrpc --enable-zip --without-libzip --with-webp-dir --with-jpeg-dir --with-png-dir     --enable-json --enable-hash --enable-mbstring --with-mcrypt --enable-libxml --with-libxml-dir --enable-ctype --enable-calendar --enable-dom --enable-fileinfo --with-mhash --with-incov --enable-opcache --enable-phar --enable-simplexml --with-xsl --with-pear --enable-fpm 
    make clean
    make
    make install
}
phpVerlist
read choice
while [ -z ${stable[$choice]} ]
do
    echo 'Opps,choose wrong '
    phpVerlist
    read choice
done
app='php'
version=${stable[$choice]}
sourcePath='/opt/source'
if [ ! -d $sourcePath ]; then
    sudo mkdir -p $sourcePath
fi

appPath="/opt/app/$app/$version"
if [ ! -d $appPath ]; then
    sudo mkdir -p $appPath
fi

echo -e "This scripts will install $green$app$version\e[0m to the path  $green$appPath\e[0m"
cnt=5;
promt='.'
echo "The scripts will be execute in $cnt s"
while ((cnt--));
do
    echo -n $cnt $promt
    sleep 1
done

if [ -x /opt/app/$app/$version/bin/php ]; then
    echo "app /opt/app/$app/$version already exist, install quit."
    exit
fi

getSource

cd $sourcePath
tar xvf $app$version.tar.gz
cd php-$version 

build

