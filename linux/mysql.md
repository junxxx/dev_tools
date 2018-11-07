### Install mysql from source
1、add usergroup groupadd mysql useradd -r -g mysql mysql
2、get source file wget https://codeload.github.com/mysql/mysql-server/tar.gz/mysql-5.7.21

### database and talbe information 
    use information_schema;
    show tables;
    database->information_schema 

### 问题出错排查
    看error.log
