## [Install](https://docs.docker.com/install/#supported-platforms)
    uninstall old version
    yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
    SET UP THE REPOSITORY
    yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
    yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
    install docker CE
    yum install docker-ce

## Pull ima
    docker pull registry.docker-cn.com/library/ubuntu:16.04 (国内仓库)
