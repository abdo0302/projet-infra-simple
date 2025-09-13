#!/usr/bin/env bash
set -eux

sudo dnf -y update

sudo dnf -y install https://dev.mysql.com/get/mysql80-community-release-el9-1.noarch.rpm

sudo dnf config-manager --disable mysql57-community || true
sudo dnf config-manager --disable mysql80-community || true
sudo dnf config-manager --enable mysql80-community

sudo dnf -y install mysql-community-server --nogpgcheck

sudo systemctl enable --now mysqld

NEWPASS="Admin@12345"

if sudo grep 'temporary password' /var/log/mysqld.log; then
  PASS=$(sudo grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
  sudo mysql --connect-expired-password -uroot -p"$PASS" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$NEWPASS';" || true
fi

mysql -uroot -p"$NEWPASS" -e "CREATE DATABASE IF NOT EXISTS myapp;"

mysql -uroot -p"$NEWPASS" myapp < /vagrant_database/create-table.sql || true
mysql -uroot -p"$NEWPASS" myapp < /vagrant_database/insert-demo-data.sql || true

echo "MySQL installation + Database 'myapp' with tables and demo data ready."
