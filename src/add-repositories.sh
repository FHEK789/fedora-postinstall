#!/usr/bin/env bash

# add packman repositories
zypper ar -cfp 90 https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

# switch system packages to packman
sudo zypper dup --from packman --allow-vendor-change

# add NVIDIA repo
sudo zypper addrepo --refresh https://download.nvidia.com/opensuse/tumbleweed NVIDIA

# add flathub repo
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
