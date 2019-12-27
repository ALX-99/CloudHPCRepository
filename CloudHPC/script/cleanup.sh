#!/bin/bash

status=/data/portal/run/cluster.txt
id_file=/data/portal/run/identify.txt
fip=$(curl -s ifconfig.me) 
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

clear
cat /data/static/welcome.txt
echo "Maschine: $server"
echo "PublicIP: $fip"
echo
echo "Cleaning up user settings ......"
rm -f /home/ubuntu/.ssh/id_rsa*
rm -f /home/ubuntu/.elasticluster/*
rm -rf /home/ubuntu/.elasticluster/storage
rm -r /home/ubuntu/.bash_history
rm -rf /tmp/*
cp /data/config/hosts /etc/hosts
chmod 644 /etc/hosts
rm -f /data/log
