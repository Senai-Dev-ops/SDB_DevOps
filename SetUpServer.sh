#!/bin/bash

# VARIABLES #######################################################
# Packages to install
PACKAGES_TO_INSTALL=(
        docker.io
	virtualbox
	openssh-server
	htop
	epiphany-browser
	neovim
        nodejs
        npm
)

# Users
USERS=(
	kelvinra
	ozorio
	diogo
	rondon
	severiano
	james
)
###################################################################

# HANDLING WITH THE SYSTEM ########################################
# Upgrade
sudo apt update
sudo apt upgrade -y

# Installing packages
for package in ${PACKAGES_TO_INSTALL[@]}; do
	if ! dpkg -l | grep -q $package; then # Only install if the package isn't on the system
		sudo apt install $package -y
	else
		echo "$package ALREADY INSTALLED"
	fi
done

# Creating users
for user in ${USERS[@]}; do
	sudo adduser $user
	sudo usermod -aG sudo $user
done

# Updating NodeJS and npm
sudo npm install -g n
sudo n stable
###################################################################

# FINISHING #######################################################
sudo apt update
sudo apt autoclean
sudo apt autoremove -y
echo "If possible, reboot the server!"
echo "All done! Now configure the static IP."
###################################################################
