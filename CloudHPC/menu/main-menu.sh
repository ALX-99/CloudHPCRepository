#!/bin/bash

status=/data/portal/run/cluster.txt
id_file=/data/portal/run/identify.txt
fip=$(curl -s ifconfig.me) 
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)

 if [ -z $DISPLAY ]
 then
 DIALOG=dialog
  else
   DIALOG=Xdialog
  fi

# use $DIALOG for the commands



