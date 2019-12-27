#!/bin/bash
clear
status=/data/portal/run/cluster.txt
fip=$(curl -s ifconfig.me) 
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

cat /data/static/welcome.txt
echo "Status:R" > $status
echo "FIP:$fip" >> $status
echo "IP: $ip4" >> $status
echo "Name:$server" >> $status
echo
echo "Loading elasticluster docker image.... Please wait"

cd $HOME
wget -q https://raw.githubusercontent.com/gc3-uzh-ch/elasticluster/master/elasticluster.sh
chmod +x $HOME/elasticluster.sh
#$HOME/elasticluster.sh --version
sleep 1
echo "finished!"
echo
tput bel
