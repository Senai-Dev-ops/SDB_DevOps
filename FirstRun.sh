#!/bin/bash

# VARIABLES #######################################################
# Packages to install
PACKAGES_TO_INSTALL=(
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

# Installing Docker
# First check if there is a snap package
sudo snap remove docker
# From: https://docs.docker.com/engine/install/ubuntu/ :
sudo apt-get remove docker docker-engine docker.io containerd runc
sudo apt-get update
 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

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
