#!/bin/bash
set -e
## Installation de mon environnement pour Ubuntu 16.10 Gnome

sudo apt update -y
sudo apt dist-upgrade -y


# pip pour Powerline-shell
sudo easy_install pip

# Powerline-shell (a besoin de Python, déjà installé ?)
sudo git clone https://github.com/powerline/fonts.git /usr/local/share/powerline-fonts
cd /usr/local/share/powerline-fonts
sudo ./install.sh

sudo git clone https://github.com/banga/powerline-shell.git /usr/local/share/powerline-shell
cd /usr/local/share/powerline-shell
sudo ./install.py
sudo chmod a+x /usr/local/share/powerline-shell/powerline-shell.py
sudo ln -s /usr/local/share/powerline-shell/powerline-shell.py /usr/local/bin/powerline-shell.py
sudo pip install argparse

cat <<EOT >> ~/.bashrc

# Powerline-shell
function _update_ps1() {
    PS1="\$(powerline-shell.py \$? 2> /dev/null)"
}

if [ "\$TERM" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; \$PROMPT_COMMAND"
fi

# Alias
alias l='ls -lh'
alias ll='ls -lah'

EOT

sudo apt-get upgrade -y

# Outils
sudo apt install -y mc
sudo apt install -y chromium-browser
sudo apt install -y filezilla

# Apache PHP
sudo apt install -y apache2 php php-cli php-xml php-mcrypt php-gd php-pdo php-curl
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

# MongoDB
#sudo apt install -y mongodb-server
#sudo systemctl enable mongod
#sudo systemctl start mongod

# Composer
cd /tmp
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin  --filename=composer
php -r "unlink('composer-setup.php');"

# Configuration Git
git config --global user.email "david@clicproxy.com"
git config --global user.name "David BOUCHÉ"

# Docker
curl -sSL https://get.docker.com/ | sh
curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` > /tmp/docker-compose
sudo mv /tmp/docker-compose /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
