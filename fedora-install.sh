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

EOT

sudo cat <<EOT >> ~/.bashrc

# Powerline-shell
function _update_ps1() {
    PS1="$(powerline-shell.py --colorize-hostname --cwd-max-depth 4  $? 2> /dev/null)"
}

if [ "xterm-256color" != "linux" ]; then
    PROMPT_COMMAND="_update_ps1; __vte_prompt_command"
fi

EOT

# Navigateur
sudo dnf install chromium

# Apache PHP
sudo dnf install httpd php php-cli php-xml php-mcrypt php-gd

# Mysql phpmyadmin
sudo dnf install mariadb phpMyAdmin

# PostgreSQL
sudo dns install php-pgsql postgresql
