#!/bin/bash


if [ -n "$1" ]; then
    DB="$1"
else
    DB=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(10/63) )),1,10);")
fi

USER=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(10/63) )),1,10);")
PASSWORD=$(php -r "echo substr(str_shuffle(str_repeat('0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil(20/63) )),1,20);")

sudo su - -c "psql -c \"CREATE USER $USER WITH PASSWORD '$PASSWORD';\"" postgres &&
sudo su - -c "psql -c \"CREATE DATABASE $DB;\"" postgres &&
sudo su - -c "psql -c \"GRANT ALL PRIVILEGES ON DATABASE $DB to $USER;\"" postgres &&
cat << EndOfMessage
POSTGRESQL_ADDON_DB="$DB"
POSTGRESQL_ADDON_HOST="localhost"
POSTGRESQL_ADDON_PASSWORD="$PASSWORD"
POSTGRESQL_ADDON_PORT="5432"
POSTGRESQL_ADDON_USER="$USER"

EndOfMessage
