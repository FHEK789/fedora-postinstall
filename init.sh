#!/usr/bin/env bash

# enable rpmfusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

sudo dnf groupupdate core -y

# install multimedia packages
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y

sudo dnf groupupdate sound-and-video -y

# fedora better fonts
sudo dnf copr enable dawid/better_fonts -y
sudo dnf install fontconfig-enhanced-defaults fontconfig-font-replacements -y

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

./src/add-repositories.sh

./src/software.sh

chsh -s /usr/bin/zsh

sudo systemctl disable NetworkManager-wait-online.service
sudo systemctl disable lvm2-monitor.service
sudo systemctl disable ModemManager.service

sudo dnf upgrade -y
sudo dnf autoremove -y

mkdir $HOME/www

# run get-config script
git clone https://github.com/fhek789/get-config.git $HOME/www/shell/get-config
cd $HOME/www/shell/get-config
./init.sh
