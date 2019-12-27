#!/bin/bash
fip=$(curl -s ifconfig.me)
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)
echo 
echo "successful logout from $fip $server($ip4)"
echo
