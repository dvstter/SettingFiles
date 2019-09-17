#!/bin/bash

# check root permission
if [$(id -u)!="0"]; then
    echo "Error: This script should be ran as root!"
    exit 1
fi

# install all packages needed
echo "This script is running, you need to execute -- service serverSpeeder start -- after this script ran over."
yes | yum install wget curl curl-devel zlib-devel openssl-devel perl perl-devel cpio expat-devel gettext-devel autoconf libtool gcc swig python-devel vim lsof epel-release python python-pip
pip install --upgrade pip
pip install shadowsocks M2Crypto

# check directory and place setting files
if [ ! -d "SettingFiles" ]; then
    echo "Error: This script's current directory should contain SettinfFiles directory!"
    exit 1
fi

mv SettingFiles/vimrc-linux ~/.vimrc
mv SettingFiles/shadowsocks.json /etc/
mv SettingFiles/ssserver.service /etc/systemd/system
systemctl enable ssserver
systemctl start ssserver

# modify firewall setting
firewall-cmd --zone=public --add-port=7777/tcp --permanent
firewall-cmd --zone=public --add-port=8888/tcp --permanent
firewall-cmd --zone=public --add-port=9999/tcp --permanent
firewall-cmd --reload

# install ruisu
wget --no-check-certificate https://blog.asuhu.com/sh/ruisu.sh
bash ruisu.sh

# some other commands, you should use
#lsof -i:7777
#service serverSpeeder start
#service status ssserver -l
#wget -N --no-check-certificate https://raw.githubusercontent.com/91yun/serverspeeder/master/serverspeeder-all.sh && bash serverspeeder-all.sh
