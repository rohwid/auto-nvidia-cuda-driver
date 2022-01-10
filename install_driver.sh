#!/bin/bash

echo "==============================================================================================="
echo "Welcome to NVIDIA Driver Installer"
echo "==============================================================================================="
echo "WARNING! Please run this script as user not root."
echo " "
read -n1 -r -p "Install the dependencies. press ENTER to continue!" ENTER
sudo apt update
sudo apt install openjdk-8-jdk git python3-dev python3-tk cmake unzip zip \
  python3-numpy python3-six build-essential python3-pip \
  swig python3-wheel libcurl3-dev libcupti-dev -y

read -n1 -r -p "Add nvidia driver repository. press ENTER to continue!" ENTER
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
sudo apt dist-upgrade -y

read -n1 -r -p "Check nvidia driver to be install. press ENTER to continue!" ENTER
ubuntu-drivers devices

read -p "Do you want to install NVIDIA driver automatically? [Y/n]: " AUTO
AUTO="${AUTO:=Y}"

if [[ $AUTO = "Y" ]] || [[ $AUTO = "y" ]]; then
  sudo ubuntu-drivers autoinstall
elif [[ $AUTO = "N" ]] || [[ $AUTO = "n" ]]; then
  read -p "Please enter the NVIDIA driver version: " VER
  sudo apt install nvidia-driver-$VER -y
else
  echo "[AUTO-DRIVER] Input invalid."
  echo "[AUTO-DRIVER] Installation aborted."
  exit
fi

read -n1 -r -p "Reboot to load the changes. press ENTER to continue!" ENTER
sudo reboot
