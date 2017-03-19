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

EOT

# Navigateur
sudo dnf install -y chromium

# Apache PHP
sudo dnf install -y httpd php php-cli php-xml php-mcrypt php-gd php-pdo
sudo systemctl  httpd start

# Mysql phpmyadmin
sudo dnf install -y mariadb-server phpMyAdmin
sudo systemctl start mariadb
sudo mysql_secure_installation


# PostgreSQL
sudo dnf install -y php-pgsql postgresql-server
