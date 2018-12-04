#!/bin/bash

[[ -z $BASH_SOURCE ]] && echo "请下载脚本运行" && exit

#CENTOS_VERSION=$(rpm -qa|grep -E  "centos-release-[567]"|cut -d'-' -f3)
CENTOS_VERSION_FULL=$(awk -F'release' '{print $2}' /etc/redhat-release | awk '{print $1}' )
CENTOS_VERSION=$(echo ${CENTOS_VERSION_FULL} | awk -F'.' '{print $1}')

WORK_DIR='/opt/src/'
NAME='mysql'
VERSION='5.7.24'
INSTALL_DIR="/opt/app/mysql57"
FILE_NAME="${NAME}-boost-${VERSION}"
LOG_FILE="/tmp/`basename ${0} .sh`.log"
wget_cmd='wget -t 3 -w 5 -T 10 -nv'

_check_installed_version() {
    echo "-------------------------------------------------"
    if [[ ! -d ${INSTALL_DIR} ]]; then 
        echo "Check Installed Version [${INSTALL_DIR}]: Not Found"
        return
    fi

    OLD_VERSION=$(${INSTALL_DIR}/bin/mysqld -V 2>/dev/null |grep Ver|awk '{print $3}')
    if [[ -z "${OLD_VERSION}" ]]; then
        echo "Check Installed Version [${INSTALL_DIR}]: Not Found"
        return
    else
        echo "Check Installed Version [${INSTALL_DIR}]: ${NAME} ${OLD_VERSION}"
        while true; do
            read -r -p "Do you want overwrite install ${NAME} ${VERSION} (Y/n): " input
            case $input in 
                [yY][eE][sS]|[yY]|"")
                    break
                    ;;
                [nN][oO]|[nN])
                    exit
                    ;;
                *)
                    echo "Invalid input..."
                    ;;
            esac
        done
    fi
}

_is_download_conf() {
    while true; do
        echo "-------------------------------------------------"
        echo "Do you want install default configuration files"
        read -r -p "The file path is ${INSTALL_DIR}/etc/my.cnf (y/N): " input
        case $input in
            [yY][eE][sS]|[yY])
                FLAG_CONFIG=1
                break
                ;;
            [nN][oO]|[nN]|"")
                FLAG_CONFIG=0
                break
                ;;
            *)
                echo "Invalid input..."
                ;;
        esac
    done
}

_install_mysql57() {
    [[ -d ${WORK_DIR} ]] || mkdir -p ${WORK_DIR}
    SECONDS_LEFT=5
    echo "-------------------------------------------------"
    echo "Start install ${NAME} ${VERSION} to ${INSTALL_DIR} in ${SECONDS_LEFT} seconds"
    while [ ${SECONDS_LEFT}  -gt 0 ];do
        echo -n ${SECONDS_LEFT}
        sleep 1
        SECONDS_LEFT=$((${SECONDS_LEFT} - 1))
        echo -ne "\r   \r"
    done
    {
    cd ${WORK_DIR}
    yum -y install zlib-devel openssl-devel libaio-devel ncurses-devel cmake gcc-c++ 
    ${wget_cmd} -O ${NAME}-${VERSION}.tar.gz http://183.136.203.103:889/app_install/source/${FILE_NAME}.tar.gz
    tar xf ${NAME}-${VERSION}.tar.gz && cd ${NAME}-${VERSION}
    [[ -d build ]] && rm -r build
    mkdir -p build && cd build
    cmake .. \
        -DBUILD_CONFIG=mysql_release \
        -DFEATURE_SET="community" \
        -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
        -DWITH_EMBEDDED_SERVER=off \
        -DINSTALL_SBINDIR=bin \
        -DINSTALL_SCRIPTDIR=bin \
        -DINSTALL_LIBDIR=lib/mysql \
        -DINSTALL_PLUGINDIR=lib/plugin \
        -DINSTALL_INCLUDEDIR=include \
        -DINSTALL_INFODIR=share/info \
        -DINSTALL_MANDIR=share/man \
        -DINSTALL_MYSQLSHAREDIR=share/mysql \
        -DINSTALL_SUPPORTFILESDIR=share/mysql \
        -DINSTALL_MYSQLTESTDIR=mysql-test \
        -DDEFAULT_CHARSET=utf8 \
        -DDEFAULT_COLLATION=utf8_general_ci \
        -DEXTRA_CHARSETS=all \
        -DENABLED_LOCAL_INFILE=ON \
        -DWITH_LIBEVENT=bundled \
        -DWITH_SSL=bundled \
        -DWITH_ZLIB=bundled \
        -DWITH_INNODB_MEMCACHED=on \
        -DWITH_BOOST=../boost \
        -DWITH_UNIT_TESTS=on \
        -DWITH_DEBUG=off
    make -j4 && make install
    } >> ${LOG_FILE} 2>&1

    if [[ $? == 0 ]]; then
        echo "Install ${NAME} ${VERSION} successfully !!!"
        {
        mkdir -p ${INSTALL_DIR}/data/{binlog,data,logs,redolog,relaylog,tmp,undolog}
        mkdir -p ${INSTALL_DIR}/etc/
        ${wget_cmd} -O ${INSTALL_DIR}/etc/my.cnf http://183.136.203.103:889/app_install/source/mysql-5.7.cnf
        [[ -f /etc/my.cnf ]] && mv /etc/my.cnf /etc/my.cnf.old
        grep "^mysql:"  /etc/group || groupadd -g 27 -o -r mysql
        id mysql || useradd -M -g mysql -o -r -d /dev/null -s /sbin/nologin -u 27 mysql 
        chown -R mysql. ${INSTALL_DIR}/data/* 
        } >> ${LOG_FILE} 2>&1
        echo "-------------------------------------------------"
        echo "如果需要初始化，请使用以下命令"
        echo "cd ${INSTALL_DIR}"
        echo "./bin/mysqld --initialize-insecure  #空密码"
        echo "./bin/mysqld --initialize  #随机密码，看error_log"
    else
        echo "Install ${NAME} ${VERSION} failure !!!"
    fi 
}

_install_mysql57_el5() {
    [[ -d ${WORK_DIR} ]] || mkdir -p ${WORK_DIR}
    SECONDS_LEFT=5
    echo "-------------------------------------------------"
    echo "Start install ${NAME} ${VERSION} to ${INSTALL_DIR} in ${SECONDS_LEFT} seconds"
    while [ ${SECONDS_LEFT}  -gt 0 ];do
        echo -n ${SECONDS_LEFT}
        sleep 1
        SECONDS_LEFT=$((${SECONDS_LEFT} - 1))
        echo -ne "\r   \r"
    done
    {
    cd ${WORK_DIR}
    yum -y install epel-release
    yum -y install zlib-devel openssl-devel libaio-devel ncurses-devel cmake gcc-c++
    yum -y install gcc44-c++ cmake28
    ${wget_cmd} -O ${NAME}-${VERSION}.tar.gz http://183.136.203.103:889/app_install/source/${FILE_NAME}.tar.gz
    tar xf ${NAME}-${VERSION}.tar.gz && cd ${NAME}-${VERSION}
    [[ -d build ]] && rm -r build
    mkdir -p build && cd build
    CC='gcc44' CXX='g++44' cmake28 .. \
        -DBUILD_CONFIG=mysql_release \
        -DFEATURE_SET="community" \
        -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}" \
        -DWITH_EMBEDDED_SERVER=off \
        -DINSTALL_SBINDIR=bin \
        -DINSTALL_SCRIPTDIR=bin \
        -DINSTALL_LIBDIR=lib/mysql \
        -DINSTALL_PLUGINDIR=lib/plugin \
        -DINSTALL_INCLUDEDIR=include \
        -DINSTALL_INFODIR=share/info \
        -DINSTALL_MANDIR=share/man \
        -DINSTALL_MYSQLSHAREDIR=share/mysql \
        -DINSTALL_SUPPORTFILESDIR=share/mysql \
        -DINSTALL_MYSQLTESTDIR=mysql-test \
        -DDEFAULT_CHARSET=utf8 \
        -DDEFAULT_COLLATION=utf8_general_ci \
        -DEXTRA_CHARSETS=all \
        -DENABLED_LOCAL_INFILE=ON \
        -DWITH_LIBEVENT=bundled \
        -DWITH_SSL=bundled \
        -DWITH_ZLIB=bundled \
        -DWITH_INNODB_MEMCACHED=on \
        -DWITH_BOOST=../boost \
        -DWITH_UNIT_TESTS=on \
        -DWITH_DEBUG=off
    make -j4 && make install
    } >> ${LOG_FILE} 2>&1

    if [[ $? == 0 ]]; then
        echo "Install ${NAME} ${VERSION} successfully !!!"
        {
        mkdir -p ${INSTALL_DIR}/data/{binlog,data,logs,redolog,relaylog,tmp,undolog}
        mkdir -p ${INSTALL_DIR}/etc/
        if [[ ${FLAG_CONFIG} -eq 1 ]];then
            ${wget_cmd} -O ${INSTALL_DIR}/etc/my.cnf http://183.136.203.103:889/app_install/source/mysql-5.7.cnf
            [[ -f /etc/my.cnf ]] && mv /etc/my.cnf /etc/my.cnf.old
        fi
        grep "^mysql:" /etc/group || groupadd -g 27 -o -r mysql
        id mysql || useradd -M -g mysql -o -r -d /dev/null -s /sbin/nologin -u 27 mysql 
        chown -R mysql. ${INSTALL_DIR}/data/*
        } >> ${LOG_FILE} 2>&1
        echo "-------------------------------------------------"
        echo "如果需要初始化，请使用以下命令"
        echo "cd ${INSTALL_DIR}"
        echo "./bin/mysqld --initialize-insecure  #空密码"
        echo "./bin/mysqld --initialize  #随机密码，看error_log"
    else
        echo "Install ${NAME} ${VERSION} failure !!!"
    fi 
}

_main() {
    echo "-------------------------------------------------"
    echo "CentOS Version: ${CENTOS_VERSION_FULL}"
    echo "Service Info: ${NAME} ${VERSION}"
    echo "Service Path: ${INSTALL_DIR}"
    :> ${LOG_FILE}
    _check_installed_version
    _is_download_conf
    [[ ${CENTOS_VERSION} -eq 5 ]] &&  _install_mysql57_el5
    [[ ${CENTOS_VERSION} -gt 5 ]] &&  _install_mysql57
    echo "-------------------------------------------------"
    echo "The install log file is ${LOG_FILE}"
    echo "-------------------------------------------------"
    exit
}


_main
