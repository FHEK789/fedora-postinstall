#!/usr/bin/env bash

RESTORE=$(echo -en '\033[0m')
RED=$(echo -en '\033[00;31m')
GREEN=$(echo -en '\033[00;32m')

mapfile -t INSTALL_LIST < install-list.txt
mapfile -t REMOVE_LIST < remove-list.txt
mapfile -t FLATPAK_LIST < flatpak-list.txt

echo "${RED}--- REMOVING PACKAGES ---${RESTORE}"
echo

for package_name in ${REMOVE_LIST[@]}; do
	if ! sudo zypper packages --installed-only | grep -q "^\<$package_name\>"; then
		echo "${RED}[UNINSTALLED]${RESTORE} - $package_name"
	else
		echo "removing $package_name..."
		sleep 0.25
		sudo zypper -q remove -y "$package_name"
		echo "${RED}[UNINSTALLED]${RESTORE} - $package_name"
	fi
done

echo
echo "${GREEN}--- INSTALLING PACKAGES ---${RESTORE}"
echo

for package_name in ${INSTALL_LIST[@]}; do
	if ! sudo zypper packages --installed-only | grep -q "^\<$package_name\>"; then
		echo "installing $package_name..."
		sleep 0.25
		sudo zypper -q install -y "$package_name"
		echo "${GREEN}[INSTALLED]${RESTORE} - $package_name"
	else
		echo "${GREEN}[INSTALLED]${RESTORE} - $package_name"
	fi
done

echo
echo "${GREEN}--- INSTALLING FLATPAKS ---${RESTORE}"
echo

for flatpak_name in ${FLATPAK_LIST[@]}; do
	if ! flatpak list | grep -q $flatpak_name; then
		echo "installing $flatpak_name..."
		sleep 0.25
		flatpak install "$flatpak_name" -y --noninteractive
		echo "${GREEN}[INSTALLED]${RESTORE} - $flatpak_name"
	else
		echo "${GREEN}[INSTALLED]${RESTORE} - $flatpak_name"
	fi
done
