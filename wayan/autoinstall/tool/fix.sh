#!/bin/bash
echo "creating malware directory"
mkdir /home/malware
yum install -y epel-release && yum -y install clamav
echo "add securiteinfo signature"
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.hdb" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.ign2" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/javascript.ndb" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/spam_marketing.ndb" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfohtml.hdb" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoascii.hdb" >> /etc/freshclam.conf
echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoandroid.hdb" >> /etc/freshclam.conf
freshclam
clamscan -ir /home/*/public_html --move=/home/malware > /home/malware/scan.log &
clear
echo -e "hasil scanning malware dapat dilihat pada \n/home/malware/scan.log"
exit
