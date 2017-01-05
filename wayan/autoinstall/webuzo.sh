#!/bin/bash
#Webuzo Optimize conf by wayan
echo "Remove basic auth protection"
	sed -i 's/auth_basic Administrator_Login/#auth_basic Administrator_Login/' /usr/local/emps/etc/nginx/nginx.conf
	sed -i 's/auth_basic_user_file/#auth_basic_user_file/' /usr/local/emps/etc/nginx/nginx.conf
echo "Use ID timezone"
	rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
	/etc/init.d/webuzo restart
echo "Download installation config and extract"
	wget http://srv14.niagahoster.com/setup/autoinstall/conf.tar.gz && tar -xvf conf.tar.gz
echo "Skip webuzo initial setup"
	/root/data.sh && /usr/local/emps/bin/php configure.php
echo "change ssh port to 65001"
	mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak && cp sshd_config /etc/ssh
	service sshd restart
echo "Fix restore mysql transfer shared ke vps"
	mv /usr/local/apps/mysql/etc/my.cnf /usr/local/apps/mysql/etc/my.cnf.bak && mv /root/my.cnf /usr/local/apps/mysql/etc/
	service mysqld restart
echo "Installing webuzo apache apps and set as default..."
echo "Webuzo Apache web server installed"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=3
echo "install all php version"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=124
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=45
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=129
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=2
echo "Memcache module"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=75
echo "install memcached"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=88
echo "Remove crazy awstat"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_remove --soft=38_1
echo "Add htaccess conf to disable xmlrpc.php for DDOS"
	cp htaccess.conf /usr/local/apps/apache/etc/conf.d/ && chown root.root /usr/local/apps/apache/etc/conf.d/htaccess.conf
	cp htaccess.conf /usr/local/apps/apache/etc/conf.d/ && chown root.root /usr/local/apps/apache2/etc/conf.d/htaccess.conf
echo "Installing CSF from webuzo Apps.."
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=62
echo "Update csf rules"
	mv /etc/csf/csf.conf /etc/csf/csf.conf.bak && cp csf.conf /etc/csf/
	csf -r
echo "installing exim as maill server from apps ..."
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=35
echo "Installing dovecot as mailbox"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --app_install --soft=36
echo "fix ipv6 issue in exim"
	mv /etc/exim/exim.conf /etc/exim/exim.conf.bak && cp exim.conf /etc/exim/
echo "fix exim permission"
	chown root.mail /etc/exim/exim.conf && chmod 644 /etc/exim/exim.conf
	service exim restart
echo "enable mod_deflate in apache..."
	echo LoadModule deflate_module modules/mod_deflate.so >> /usr/local/apps/apache/etc/httpd.conf
	cat deflate >> /usr/local/apps/apache/etc/httpd.conf
	service httpd restart
echo "fix httpd on boot"
	mv httpd /etc/init.d/ && ln -sf /usr/local/apps/apache/bin/apachectl /etc/init.d/httpd && chmod +x /etc/init.d/httpd
	chkconfig httpd on
echo "fixing pure-ftpd"
	mv /usr/local/apps/pureftpd/etc/pure-ftpd.conf /usr/local/apps/pureftpd/etc/pure-ftpd.conf.bak
	mv pure-ftpd.conf /usr/local/apps/pureftpd/etc/
echo "disable webuzo ACL for managed user"
	/usr/local/emps/bin/php /usr/local/webuzo/cli.php --webuzo_acl --disable_sysapps=1
echo "restarting services"
	/etc/init.d/sshd restart
	csf -r
	/usr/local/apps/apache/bin/apachectl restart
	/etc/init.d/httpd restart
	/etc/init.d/dovecot restart
	/etc/init.d/pure-ftpd restart
	service httpd restart
	echo "Webuzo is ready to use :)"
echo "clear screen"
	clear
echo "Detil instalasi webuzo"
	/root/detil.sh
exit
