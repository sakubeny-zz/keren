#!/bin/bash
#hostname > /home/soft/webuzo/hostname.txt
ns=`hostname`
ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}' > /root/hostname.txt
echo "masukan username cpanel client"
read username
echo $username >> /root/hostname.txt
echo info@niagahoster.co.id >> /root/hostname.txt
echo "masukan password vps client"
read password
echo $password >> /root/hostname.txt
hostname >> /root/hostname.txt
echo ns1.$ns >> /root/hostname.txt
echo ns2.$ns >> /root/hostname.txt
