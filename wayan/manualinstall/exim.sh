#!/bin/bash
#Webuzo Optimize conf by wayan
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
wget http://93.188.163.197/wayan/exim.tar.gz
tar -xvf exim.tar.gz && cp sshd_config /etc/ssh/
mv /etc/exim/exim.conf /etc/exim/exim.conf.bak
cp exim.conf /etc/exim/
chown root.root /etc/ssh/sshd_config
chown root.mail /etc/exim/exim.conf
service exim restart
service sshd restart
