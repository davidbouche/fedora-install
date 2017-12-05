#!/bin/bash
set -e
## Installation de mon environnement pour Ubuntu 16.10 Gnome

sudo apt update -y
sudo apt dist-upgrade -y


# pip pour Powerline-shell
sudo apt-get install -y python-setuptools
sudo easy_install pip

# Powerline-shell (a besoin de Python, déjà installé ?)
sudo git clone https://github.com/powerline/fonts.git /usr/local/share/powerline-fonts
cd /usr/local/share/powerline-fonts
sudo ./install.sh

sudo pip install --user powerline-shell
sudo pip install argparse

cat <<EOT >> ~/.bashrc

# Powerline-shell
function _update_ps1() {
    PS1="$(powerline-shell $?)"
}

if [ "$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

# Alias
alias l='ls -lh'
alias ll='ls -lah'

EOT

sudo apt-get upgrade -y

# Outils
sudo apt install -y mc curl pwgen
sudo apt install -y chromium-browser
sudo apt install -y filezilla

# Chrome
sudo apt-get install -y libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome*.deb
sudo apt-get install -f

# Gnome
sudo apt install -y gnome-shell
sudo apt install -y gnome-tweak-tool

# Apache PHP
sudo apt install -y apache2 php php-cli php-xml php-mcrypt php-gd php-pdo php-curl php-soap
sudo systemctl enable apache2
sudo a2enmod rewrite
sudo systemctl restart apache2

# Mysql phpmyadmin
sudo apt install -y mysql-server
sudo apt install -y phpmyadmin
sudo systemctl enable mysql
sudo systemctl restart mysql

# PostgreSQL
sudo apt install -y postgresql
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo apt install -y phppgadmin

# Ruby environnement (projets Redmine)
sudo apt install -y ruby
gem install bundler

# MongoDB
#sudo apt install -y mongodb-server
#sudo systemctl enable mongod
#sudo systemctl start mongod

# Composer
cd /tmp
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

# Configuration Git
git config --global user.email "david@clicproxy.com"
git config --global user.name "David BOUCHÉ"

# Docker
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
