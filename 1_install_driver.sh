#!/bin/bash

echo "==============================================================================================="
echo "Welcome to NVIDIA Driver Installer"
echo "==============================================================================================="
read -n1 -r -p "Install the dependencies. press ENTER to continue!" ENTER
sudo apt update
sudo apt install openjdk-8-jdk git python-dev python3-dev python-numpy python3-tk cmake unzip zip \
 python3-numpy python-six python3-six build-essential python-pip python3-pip python-virtualenv \
 swig python-wheel python3-wheel libcurl3-dev libcupti-dev -y

read -n1 -r -p "Add nvidia driver repository. press ENTER to continue!" ENTER
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt dist-upgrade -y

read -n1 -r -p "Check nvidia driver to be install. press ENTER to continue!" ENTER
ubuntu-drivers devices

read -p "Do you want to install NVIDIA driver automatically? [Y/n]: " ENTER

if [[ MAN -eq "Y" ]] || [[ MAN -eq "y" ]]; then
  sudo ubuntu-drivers autoinstall
else
  read -p "Please enter the NVIDIA driver version: " version
  sudo apt install nvidia-driver-$VER -y
fi


read -n1 -r -p "Reboot to load the changes. press ENTER to continue!" ENTER
sudo reboot
