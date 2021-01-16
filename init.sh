#!/usr/bin/env bash

# add packman repositories
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

sudo zypper dup --from packman --allow-vendor-change

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

./src/add-repositories.sh

./src/software.sh

chsh -s /usr/bin/zsh

sudo zypper up

mkdir $HOME/www

# run get-config script
git clone https://github.com/fhek789/get-config.git $HOME/www/shell/get-config
cd $HOME/www/shell/get-config
./init.sh
