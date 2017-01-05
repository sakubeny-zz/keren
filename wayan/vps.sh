#!/bin/bash

# Clear
trap '' 2 
while true
do
  clear

# Set Color
RED='\033[0;31m' 	# Red Color
GREEN='\033[0;32m'	# Green Color
BLUE='\033[0;34m'	# Blue Color
NC='\033[0m'		# No Color

# Display Title
echo "============================================================"
echo "          NIAGA VPS TOOLS v1.0"
echo "============================================================"

# Display Uptime
echo -e "${GREEN}$(uptime)${NC}"
# Display user
echo -e "${GREEN} Login as: $(whoami)${NC}"
# Display Memory usage
free -m | awk 'NR==2{printf " Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }'
# Display Disk Usage
df -h | awk '$NF=="/"{printf " Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
# Display CPU Load
#top -bn1 | grep load | awk '{printf " CPU Load: %.2f\n", $(NF-2)}'

echo "------------------------------------------------------------"
#check webuzo
if (( $(ps aux | grep -v grep | grep emps | wc -l) > 0 ))
then
  echo -e "${GREEN} Webuzo Sudah Terinstall${NC}"
else
 echo -e "${RED} Webuzo Belum Terinstal${NC}"
fi
# Check httpd service
if (( $(ps -ef | grep -v grep | grep httpd | wc -l) > 0 ))
then
  echo -e "${GREEN} Httpd is running${NC}"
else
  echo -e "${RED} Httpd is not running${NC}"
fi

# Check mysql service
if (( $(ps -ef | grep -v grep | grep mysql | wc -l) > 0 ))
then
  echo -e "${GREEN} MySQL is running${NC}"
else
  echo -e "${RED} MySQL is not running${NC}"
fi

# Check BIND service
if (( $(ps -ef | grep -v grep | grep named | wc -l) > 0 ))
then
  echo -e "${GREEN} Named is running${NC}"
else
  echo -e "${RED} Named is not running${NC}"
fi

# Check Exim service
if (( $(ps -ef | grep -v grep | grep exim | wc -l) > 0 ))
then
  echo -e "${GREEN} Exim is running${NC}"
else
  echo -e "${RED} Exim is not running${NC}"
fi

# Check Dovecot service
if (( $(ps -ef | grep -v grep | grep dovecot | wc -l) > 0 ))
then
  echo -e "${GREEN} Dovecot is running${NC}"
else
  echo -e "${RED} Dovecot is not running${NC}"
fi

# Check Pure-FTPd service
if (( $(ps -ef | grep -v grep | grep pure-ftpd | wc -l) > 0 ))
then
  echo -e "${GREEN} Pure-FTPd is running${NC}"
else
  echo -e "${RED} Pure-FTPd is not running${NC}"
fi

  echo "------------------------------------------------------------"
  echo " [1] Automatic Install webuzo"
  echo " [2] Manual untuk migrasi cpanel"
  echo " [3] Install Tools pack Malware + spam"
  echo " [0] Quit"
  echo -e "Masukan pilihan lalu tekan Enter"
  read answer
  case "$answer" in

# Automatic Install Webuzo
   1) wget -N http://files.webuzo.com/install.sh && chmod +x install.sh && ./install.sh && wget http://srv14.niagahoster.com/setup/autoinstall/webuzo.sh && chmod +x webuzo.sh && ./webuzo.sh

# if (( $(ps aux | grep -v grep | grep emps | wc -l) > 0 ))
#then
#  wget 93.188.163.197/wayan/webuzo.sh && chmod +x webuzo.sh && ./webuzo.sh
#else
 # wget -N http://files.webuzo.com/install.sh && chmod +x install.sh && ./install.sh && wget 93.188.163.197/wayan/webuzo.sh && chmod +x webuzo.sh && ./webuzo.sh
#fi
#wget 93.188.163.197/wayan/webuzo.sh && chmod +x webuzo.sh && ./webuzo.sh 
     #malware + spam tools pack
      echo -e "${BLUE}Install Clamav + Maldet ${NC}"
      mkdir /home/malware
      yum install -y epel-release && yum -y install clamav clamd
      echo "add securiteinfo signature"
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.ign2" >> /etc/freshclam.conf
      echo "#DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/javascript.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/spam_marketing.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfohtml.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoascii.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoandroid.hdb" >> /etc/freshclam.conf
      wget http://www.rfxn.com/downloads/maldetect-current.tar.gz
      tar -xvf maldetect-current.tar.gz
      cd maldetect-*
      ./install.sh
      echo -e "${BLUE}Update Database${NC}"
      #freshclam
      maldet --update-ver
      cd /root
      #set cron per jam 12 malam untuk clamav scanner dan per satu menit untuk clean frozen
      echo -e "${BLUE}set cron Automatic update dan scan ${NC}"
      wget http://srv14.niagahoster.com/setup/clamscan
      echo "0 0 * * 1,3,5 /root/clamscan" >> /var/spool/cron/root
      #echo -e "${BLUE}set cron clean frozenmail per menit ${NC}"
      #wget http://srv14.niagahoster.com/setup/frozenmail
      echo "* * * * * /root/frozenmail >/dev/null 2>&1" >> /var/spool/cron/root
      chmod +x /root/frozenmail && chmod +x /root/clamscan && csf -r
      ./detil.sh
      ;;

# Manual Install untuk migrasi cpanel
   2) wget -N http://files.webuzo.com/install.sh && chmod +x install.sh && ./install.sh && wget http://srv14.niagahoster.com/setup/manualinstall/webuzo.sh && chmod +x webuzo.sh && ./webuzo.sh
      echo -e "${BLUE}Install Clamav + Maldet ${NC}"
      mkdir /home/malware
      yum install -y epel-release && yum -y install clamav clamd
      echo "add securiteinfo signature"
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.ign2" >> /etc/freshclam.conf
      echo "#DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/javascript.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/spam_marketing.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfohtml.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoascii.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoandroid.hdb" >> /etc/freshclam.conf
      wget http://www.rfxn.com/downloads/maldetect-current.tar.gz
      tar -xvf maldetect-current.tar.gz
      cd maldetect-*
      ./install.sh
      echo -e "${BLUE}Update Database${NC}"
      #freshclam
      maldet --update-ver
      cd /root
      echo -e "${BLUE}set cron Automatic update dan scan ${NC}"
      wget http://srv14.niagahoster.com/setup/clamscan
      echo "0 0 * * 1,3,5 /root/clamscan" >> /var/spool/cron/root
      echo -e "${BLUE}set cron clean frozenmail per menit ${NC}"
      wget http://srv14.niagahoster.com/setup/frozenmail
      echo "* * * * * /root/frozenmail >/dev/null 2>&1" >> /var/spool/cron/root
      chmod +x /root/frozenmail && chmod +x /root/clamscan && csf -r
      csf -r
      ./detil.sh
      ;;

# Install dan Check Malware di /home
   3) service=clamd
      if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
      then
      echo ">service status"
      echo -e "${RED} $service is running${NC}\n"
      echo "installasi batal clamav sudah terinstall tekan q untuk keluar"
      else
      echo -e "${BLUE}Install Clamav + Maldet ${NC}"
      mkdir /home/malware
      echo "Install Clamav"
      yum install -y epel-release && yum -y install clamav clamd
      echo "add securiteinfo signature"
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfo.ign2" >> /etc/freshclam.conf
      echo "#DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/javascript.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/spam_marketing.ndb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfohtml.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoascii.hdb" >> /etc/freshclam.conf
      echo "DatabaseCustomURL http://www.securiteinfo.com/get/signatures/fe80d6b5100699cea4113ea9499eae8c0e8c6a05ce25a8d190b710f559e0bb5d4b0a3695717ac5cd3a3f282599e70b973f141ac6d250a77419b8c54754fe79bf/securiteinfoandroid.hdb" >> /etc/freshclam.conf
      wget http://www.rfxn.com/downloads/maldetect-current.tar.gz
      tar -xvf maldetect-current.tar.gz
      cd maldetect-*
      ./install.sh
      echo -e "${BLUE}Update Database${NC}"
      freshclam
      maldet --update-ver
      cd /root
      echo -e "${BLUE}set cron Automatic update dan scan ${NC}"
      wget http://srv14.niagahoster.com/setup/clamscan
      echo "0 0 * * 1,3,5 /root/clamscan" >> /var/spool/cron/root
      echo -e "${BLUE}set cron clean frozenmail per menit ${NC}"
      wget http://srv14.niagahoster.com/setup/frozenmail
      echo "* * * * * /root/frozenmail >/dev/null 2>&1" >> /var/spool/cron/root
      chmod +x /root/frozenmail && chmod +x /root/clamscan && csf -r
      fi;;

# Exit
   0) exit ;;
  esac
  echo -e "tekan Enter untuk continue"
  read input
done
