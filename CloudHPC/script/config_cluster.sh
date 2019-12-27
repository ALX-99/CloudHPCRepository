#!/bin/bash
status_update=/data/log/update.txt
status=/data/portal/run/cluster.txt
id_file=/data/portal/run/identify.txt
fip=$(curl -s ifconfig.me)
server=$(hostname)
ip4=$(/sbin/ip -o -4 addr list ens3 | awk '{print $4}' | cut -d/ -f1)
dt=$(date '+%d/%m/%Y_%H:%M:%S');


stat /home/ubuntu/.elasticluster/config > /tmp/new
DIFF=$(diff /tmp/new /data/config/cluster-conf/last)
if [ "$DIFF" != "" ]
then
# /data/script/build_config.sh
/home/ubuntu/elasticluster -v setup vhpc01 2>&1 | tee /data/log_$dt
stat /home/ubuntu/.elasticluster/config > /data/config/cluster-conf/last
echo "$dt: ClusterConfig has been updated and Setup!" > $status_update
else
echo "$dt: ClusterConfig has not been changed!" > $status_update
fi
