#!/bin/bash

## Installation de mon environnement pour Fedora 25

# Powerline-shell (a besoin de Python, déjà installé ?)
sudo git clone https://github.com/powerline/fonts.git /usr/local/share/powerline-fonts
cd /usr/local/share/powerline-fonts
sudo ./install.sh
./install.sh

sudo git clone https://github.com/banga/powerline-shell.git /usr/local/share/powerline-shell
cd /usr/local/share/powerline-shell
sudo ./install.py
sudo chmod a+x /usr/local/share/powerline-shell/powerline-shell.py
sudo pip install argparse

cat <<EOT >> ~/.bashrc

# Powerline-shell
function _update_ps1() {
    PS1="$(powerline-shell.py --colorize-hostname --cwd-max-depth 4  $? 2> /dev/null)"
}

if [ "xterm-256color" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; __vte_prompt_command"
fi

# Alias
alias l='ls -lh'
alias ll='ls -lah'

EOT

sudo cat <<EOT >> ~/.bashrc

# Powerline-shell
function _update_ps1() {
    PS1="$(powerli
    # Atom
    apm install  minimap minimap-autohide minimap-highlight-selected atom-beautify color-picker
    apm install linter linter-csslint linter-htmlhint linter-jshint linter-markdownlint linter-php linter-scss-lint linter-twig linter-js-yaml file-icons git-plus
    apm install less-than-slash docblockr pigments
    apm install autocomplete-modules emmetne-shell.py --colorize-hostname --cwd-max-depth 4  $? 2> /dev/null)"
}

if [ "xterm-256color" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; __vte_prompt_command"
fi

# Alias
alias l='ls -lh'
alias ll='ls -lah'

EOT

# Navigateur
sudo dnf install -y chromium

# Apache PHP
sudo dnf install -y httpd php php-cli php-xml php-mcrypt php-gd php-pdo
sudo systemctl enable httpd
sudo systemctl  httpd start

# Mysql phpmyadmin
sudo dnf install -y mariadb-server phpMyAdmin
sudo systemctl enable mariadb
sudo systemctl start mariadb
sudo mysql_secure_installation

# PostgreSQL
sudo dnf install -y php-pgsql postgresql-server  postgresql-contrib
sudo systemctl enable postgresql
sudo systemctl start postgresql
sudo postgresql-setup --initdb --unit postgresql
sudo dnf install phpPgAdmin

# Composer
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '669656bab3166a7aff8a7506b8cb2d1c292f042046c5a994c43155c0be6190fa0355160742ab2e1c88d40d5be660b410') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
sudo php composer-setup.php --install-dir=/usr/local/bin  --filename=composer
php -r "unlink('composer-setup.php');"
