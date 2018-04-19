FROM ubuntu:14.04
ADD http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_3.0-1%2Btrusty_all.deb /tmp/zabbix-release.deb
ADD http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix/zabbix-server-mysql_3.0.1-1%2Btrusty_amd64.deb /tmp/zabbix-server-mysql.deb
ADD http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix/zabbix-frontend-php_3.0.1-1%2Btrusty_all.deb /tmp/zabbix-frontend-php.deb

RUN set -x \
    && dpkg -i /tmp/zabbix-release.deb \
    && sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y wget snmpd snmptt libcurl3 libiksemel3 libldap-2.4-2 libodbc1 unixodbc libopenipmi0 libssh2-1 libxml2 fping apache2 php5 php5-mysql php5-gd php5-ldap ttf-dejavu-core ttf-japanese-gothic

# install mysql
RUN echo "mysql-server-5.5 mysql-server/root_password password zabbix" | debconf-set-selections \
    && echo "mysql-server-5.5 mysql-server/root_password_again password zabbix" | debconf-set-selections \
    && apt-get -y install mysql-server-5.5

# install zabbix-server-mysql
RUN echo "zabbix-server-mysql zabbix-server-mysql/dbconfig-install boolean true" | debconf-set-selections \
    && echo "zabbix-server-mysql zabbix-server-mysql/mysql/admin-pass password zabbix" | debconf-set-selections \
    && echo "zabbix-server-mysql zabbix-server-mysql/mysql/app-pass password zabbix" | debconf-set-selections \
    && echo "zabbix-server-mysql zabbix-server-mysql/password-confirm password zabbix" | debconf-set-selections \
    && /usr/bin/mysqld_safe & \
    dpkg -i /tmp/zabbix-server-mysql.deb

# install zabbix-frontend-php
RUN dpkg -i /tmp/zabbix-frontend-php.deb

# PHP time zone set
COPY php.ini /etc/php5/apache2/php.ini

# install language-pack-zh-hans
RUN apt-get -y install language-pack-zh-hans

COPY zabbix.conf /etc/apache2/conf-available/zabbix.conf
RUN mkdir -p /etc/zabbix/web
COPY zabbix.conf.php /etc/zabbix/web/zabbix.conf.php
RUN sed -i '/DocumentRoot/c\\tDocumentRoot /usr/share/zabbix' /etc/apache2/sites-enabled/000-default.conf

RUN find /var/lib/mysql -type f -exec touch {} \; && /etc/init.d/mysql start \
    && mysql -uroot -pzabbix -e "create database zabbix character set utf8 collate utf8_bin;" \
	&& zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uroot -pzabbix zabbix \
    && mysql -uroot -pzabbix -e "use zabbix;INSERT INTO ids VALUES ('profiles','profileid',2);INSERT INTO profiles VALUES (1,2,'web.menu.login.last',0,0,0,'index.php','',3),(2,2,'web.paging.lastpage',0,0,0,'index.php','',3);INSERT INTO sessions VALUES ('4f4ddfdc198bd46ade9c6af250af80d1',2,1471503201,0),('666cdcba136beefe3adb309ad8b686f7',2,1471503201,0);"

# Expose the Ports
EXPOSE 10050 10051 80

# set start script
COPY start.sh /start.sh
RUN chmod 755 /start.sh
CMD ["/bin/bash","/start.sh"]