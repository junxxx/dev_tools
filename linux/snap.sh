#!/bin/bash
# https://snapcraft.io/docs/installing-snap-on-centos
sudo yum install epel-release
sudo yum install snapd
sudo systemctl enable --now snapd.socket
sudo semodule -i /usr/share/selinux/packages/snappy.pp.bz2 