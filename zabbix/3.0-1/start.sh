#!/bin/bash
find /var/lib/mysql -type f -exec touch {} \; && /usr/sbin/service mysql start
/usr/sbin/service apache2 start
/usr/sbin/service zabbix-server start
/usr/bin/tail -f /dev/null