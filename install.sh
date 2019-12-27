#!/bin/sh

#fetch basic data
fip=$(curl -s ifconfig.me)
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

#set installation path
INSTALL_PATH=/data




#
#Install Basic Packages
sudo apt update
sudo apt install -y docker.io dialog jq


#setup group for HPC usage
sudo addgroup --gid 2000 hpc

#setup hpc_admin user
sudo adduser --home /home/hpc-user --shell /bin/sh --gid 2000 --disabled-password --add_extra_groups sudo hpc-user
