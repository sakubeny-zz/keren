#!/bin/bash
#Webuzo Optimize conf by wayan
cd /home
read -p "masukkan domain:" domain
echo "$domain" >> /var/log/orderspamexpert && chown mail.mail /var/log/orderspamexpert
wget http://93.188.163.197/wayan/spamexpert/exim.tar.gz
tar -xvf exim.tar.gz && rm -f /etc/exim/exim.conf.bak && mv /etc/exim/exim.conf /etc/exim/exim.conf.bak
mv exim.conf /etc/exim/
chown root.mail /etc/exim/exim.conf
service exim restart

