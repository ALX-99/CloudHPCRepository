#!/bin/bash

status=$DATA/run/cluster.txt
fip=$(curl -s ifconfig.me) 
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

clear
cat $DATA/static/welcome.txt
echo "Maschine: $server"
echo "PublicIP: $fip"
echo
who
echo
