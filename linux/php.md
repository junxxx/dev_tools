### install php from source

yum install epel-release -y
yum install autoconf libtool re2c bison libxml2-devel bzip2-devel libcurl-devel libpng-devel libicu-devel gcc-c++ libmcrypt-devel libwebp-devel libjpeg-devel openssl-devel libxslt-devel -y

mkdir /source
cd /source
wget https://codeload.github.com/php/php-src/tar.gz/php-7.0.32
tar xvf php-7.0.32.tar.gz
cd php-7.0.32
./buildconf --force
./configure --prefix=/app/php/php7.0 --with-apxs2=/usr/local/apache2/bin/apxs --with-freetype-dir=/usr/include/freetype2 --disable-short-tags --enable-xml --enable-cli --with-openssl --with-pcre-regex --with-pcre-jit --with-zlib --enable-bcmath --with-bz2 --with-curl --enable-exif --with-gd --enable-intl --with-mysqli --enable-pcntl --with-pdo-mysql --enable-soap --enable-sockets --with-xmlrpc --enable-zip --with-webp-dir --with-jpeg-dir --with-png-dir --enable-json --enable-hash --enable-mbstring --with-mcrypt --enable-libxml --with-libxml-dir --enable-ctype --enable-calendar --enable-dom --enable-fileinfo --with-mhash --with-incov --enable-opcache --enable-phar --enable-simplexml --with-xsl --with-pear --enable-fpm
make clean
make
make test
make install

