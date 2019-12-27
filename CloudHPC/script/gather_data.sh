#!/bin/bash

status=/data/portal/run/cluster.txt
fip=$(curl -s ifconfig.me) 
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

echo "Status:R" > $status
echo "FIP:$fip" >> $status
echo "IP: $ip4" >> $status
echo "Name:$server" >> $status
