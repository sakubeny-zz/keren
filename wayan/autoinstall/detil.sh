#!/bin/bash
ip=`cat hostname.txt | head -1 | tail -1`
pass=`cat hostname.txt | head -4 | tail -1`
host=`cat hostname.txt | head -5 | tail -1`
echo "change hostname"
hostname srv.$host
echo -e "$pass\n$pass" | passwd "root"
#echo "$pass:root" | chpasswd
echo "clear screen"
clear
echo -e "Kami telah menerima order VPS dengan Webuzo dan kami telah menginstal panel webuzo Anda sehingga VPS Anda siap untuk digunakan. \nBerikut detil login panel Webuzo Anda:\n"
echo -e "Detail Instalasi Webuzo\n"
echo "Url login Webuzo:" $ip:2002
echo "username: admin"
echo "Password:" $pass
echo -e "\nDetil Login FTP\n"
echo "Host atau IP FTP:" $ip
echo "User FTP: admin"
echo "Pass FTP:" $pass

echo -e "\nnote:"
echo -e "\n*Saat ini vps Anda dalam status managed. Silakan cek perbedaan manage dan unmanaged vps di: https://www.niagahoster.co.id/kb/free-managed-vps-niagahoster"
echo -e "\n*Tips mempercepat akses website wordpress di VPS Niagahoster https://www.niagahoster.co.id/kb/menggunakan-memcache-dan-memcached-wordpress-di-vps"
echo -e "\nSemoga bermanfaat!"
