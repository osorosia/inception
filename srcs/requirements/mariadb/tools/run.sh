#!/bin/sh
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo X ENV
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo $MYSQL_DATABASE
echo $MYSQL_USER
echo $MYSQL_PASSWORD
echo $MYSQL_ROOT_PASSWORD

if [ ! -d "/run/mysqld" ]; then
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo X /run/mysqld
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	mkdir -p /run/mysqld
fi
chown -R mysql:mysql /run/mysqld

chown -R mysql:mysql /var/lib/mysql
if [ ! -d /var/lib/mysql/mysql ]; then
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	echo X /var/lib/mysql/mysql
	echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
	mysql_install_db --user=mysql --ldata=/var/lib/mysql >/dev/null

	tfile=$(mktemp)
	if [ ! -f "$tfile" ]; then
		return 1
	fi

	echo $MYSQL_ROOT_PASSWORD

	cat <<EOF >$tfile
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
GRANT ALL ON *.* TO 'root'@'localhost' identified by '$MYSQL_ROOT_PASSWORD' WITH GRANT OPTION;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$MYSQL_ROOT_PASSWORD');
DROP DATABASE IF EXISTS test;

CREATE DATABASE $MYSQL_DATABASE CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED by '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';

FLUSH PRIVILEGES;
EOF

	/usr/bin/mysqld --user=mysql --bootstrap --skip-networking=0 < $tfile
	rm -f $tfile
fi

exec /usr/bin/mysqld --user=mysql --console --skip-networking=0
