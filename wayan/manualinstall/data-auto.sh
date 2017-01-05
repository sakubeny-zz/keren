#!/bin/bash
#hostname > /home/soft/webuzo/hostname.txt
ns=`hostname`
ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' > /root/hostname.txt
echo admin >> /root/hostname.txt
echo info@niagahoster.co.id >> /root/hostname.txt
tr -dc A-Za-z0-9 < /dev/urandom | head -c 8 | xargs >> /root/hostname.txt
hostname >> /root/hostname.txt
echo ns1.$ns >> /root/hostname.txt
echo ns2.$ns >> /root/hostname.txt
#echo admin >> /home/soft/webuzo/hostname.txt