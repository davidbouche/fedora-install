#!/bin/bash


if [ -n "$1" ]; then
    DB="$1"
else
    DB=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(10/63) )),1,10);")
fi

USER=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(10/63) )),1,10);")
PASSWORD=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(20/63) )),1,20);")

read -s -p "Enter MySQL password: " MYSQLROOTPW
echo "\n"

mysqladmin -uroot -p$MYSQLROOTPW create "$DB" && mysql -uroot -p$MYSQLROOTPW -e "GRANT ALL ON $DB.* TO $USER IDENTIFIED BY '$PASSWORD';" && cat << EndOfMessage
MYSQL_ADDON_DB="$DB"
MYSQL_ADDON_HOST="localhost"
MYSQL_ADDON_USER="$USER"
MYSQL_ADDON_PASSWORD="$PASSWORD"
MYSQL_ADDON_PORT="3306"

EndOfMessage
