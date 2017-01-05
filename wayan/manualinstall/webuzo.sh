#!/bin/bash
#Webuzo Optimize conf by wayan
echo "Download and extract installation config"
	wget http://srv14.niagahoster.com/setup/manualinstall/conf.tar.gz && tar -xvf conf.tar.gz
echo "Skip webuzo initial setup"
	/root/data.sh && /usr/local/emps/bin/php configure.php
echo "Change ssh port to 65001"
	mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && cp sshd_config /etc/ssh
	service sshd restart
echo "Installing webuzo apache apps and set as default..."
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=3
echo "Install all php version"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=124
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=45
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=129
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=2
echo "Install memcache module and memcached"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=75
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=88
echo "Disable xmlrpc.php for protecting DDOS"
	cp htaccess.conf /usr/local/apps/apache/etc/conf.d/ && chown root.root /usr/local/apps/apache/etc/conf.d/htaccess.conf
	cp htaccess.conf /usr/local/apps/apache/etc/conf.d/ && chown root.root /usr/local/apps/apache2/etc/conf.d/htaccess.conf
echo "Installing CSF from webuzo Apps.."
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=62
echo "reconfig csf configuration"
	mv /etc/csf/csf.conf /etc/csf/csf.conf.bak && cp csf.conf /etc/csf/
	csf -r
echo "installing exim as maill server from apps ..."
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=35
echo "Installing dovecot as mailbox"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=36
echo "Remove crazy awstat"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_remove --soft=38_1
echo "fix ipv6 issue in exim"
	mv /etc/exim/exim.conf /etc/exim/exim.conf.bak 
	cp exim.conf /etc/exim/
echo "fix exim permission"
	chown root.mail /etc/exim/exim.conf && chmod 644 /etc/exim/exim.conf
echo "enable mod_deflate in apache..."
	echo LoadModule deflate_module modules/mod_deflate.so >> /usr/local/apps/apache/etc/httpd.conf
cat deflate >> /usr/local/apps/apache/etc/httpd.conf
	echo "fix httpd on boot"
	mv httpd /etc/init.d/ && ln -sf /usr/local/apps/apache/bin/apachectl /etc/init.d/httpd && chmod +x /etc/init.d/httpd
	chkconfig httpd on
echo "fixing pure-ftpd"
	mv /usr/local/apps/pureftpd/etc/pure-ftpd.conf /usr/local/apps/pureftpd/etc/pure-ftpd.conf.bak
	mv pure-ftpd.conf /usr/local/apps/pureftpd/etc/
echo "fix restore mysql failed"
	mv /usr/local/apps/mysql/etc/my.cnf /usr/local/apps/mysql/etc/my.cnf.bak && mv /root/my.cnf /usr/local/apps/mysql/etc/
	service mysqld restart
echo "disable ACL for managed VPS"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --webuzo_acl --disable_sysapps=1
echo "restarting csf"
	csf -r
echo "restart web server"
	/usr/local/apps/apache/bin/apachectl restart
	/etc/init.d/httpd restart
	/etc/init.d/dovecot restart
	/etc/init.d/pure-ftpd restart
exit
