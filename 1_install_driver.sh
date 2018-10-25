#!/bin/bash

echo "====================================================================================="
echo "Welcome to NVIDIA Driver Installer"
echo "====================================================================================="
read -n1 -r -p "Install the dependencies. press ENTER to continue!" ENTER
sudo apt update
sudo apt install openjdk-8-jdk git python-dev python3-dev python-numpy cmake unzip zip \
 python3-numpy python-six python3-six build-essential python-pip python3-pip python-virtualenv \
 swig python-wheel python3-wheel libcurl3-dev libcupti-dev -y

read -n1 -r -p "Add nvidia driver repository. press ENTER to continue!" ENTER
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt dist-upgrade -y

read -n1 -r -p "Check nvidia driver to be install. press ENTER to continue!" ENTER
ubuntu-drivers devices

read -n1 -r -p "Install nvidia driver. press ENTER to continue!" ENTER
sudo ubuntu-drivers autoinstall

read -n1 -r -p "Reboot to load the changes. press ENTER to continue!" ENTER
sudo reboot
