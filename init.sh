#!/usr/bin/env bash

# add packman repositories
sudo zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/Essentials packman-essentials

sudo zypper dup --from packman-essentials --allow-vendor-change

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

./src/add-repositories.sh

./src/software.sh

chsh -s /usr/bin/zsh

sudo zypper dup
