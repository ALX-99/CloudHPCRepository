#!/bin/sh

#fetch basic data
fip=$(curl -s ifconfig.me)
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

#set installation path
INSTALL_PATH=/data
INSTALLER_PATH=$(pwd)



#
#Install Basic Packages
sudo apt update
sudo apt install -y docker.io dialog jq wget pdmenu

#download elasticluster
cd $INSTALLER_PATH/CloudHPC/skel
wget https://raw.githubusercontent.com/gc3-uzh-ch/elasticluster/master/elasticluster.sh
chmod +x elasticluster.sh

#setup group for HPC usage
sudo addgroup --gid 2000 hpc

#create data directory
mkdir $INSTALL_PATH
chmod 755 $INSTALL_PATH
chown root:hpc $INSTALL_PATH
cp -r $INSTALLER_PATH/CloudHPC/script $INSTALL_PATH
cp -r $INSTALLER_PATH/CloudHPC/menu $INSTALL_PATH
mkdir $INSTALL_PATH/tmp


#generate keys and add authorized_key to the skel directory
mkdir /data/keys
chmod 755 /data/keys
ssh-keygen  -b4096 -C hpc_master_key -N MyHPC -f /data/keys/hpc_master

#copy systemwide skel directory
yes | cp -rf $INSTALLER_PATH/CloudHPC/skel /etc
cp -f $INSTALLER_PATH/static/banner.txt $INSTALL_PATH:/static
cp $INSTALL_PATH/keys/hpc_master.pub /etc/skel/.ssh/authorized_keys
cat $INSTALLER_PATH/keys/hpc_initial_1.5.pub >> /etc/skel/.ssh/authorized_keys

#setup hpc_admin user
sudo adduser  --shell /bin/sh --ingroup hpc --disabled-password  --gecos hpc-user
cd /home/hpc-user
mkdir .ssh
chmod 700 .ssh
ssh-keygen  -b4096 -C hpc-user -f /home/hpc-user/.ssh/hpc-user
cp /home/hpc-user/.ssh/hpc-user.pub /home/hpc-user/.ssh/authorized_keys
chmod 700 /home/hpc-user/.ssh/authorized_keys


