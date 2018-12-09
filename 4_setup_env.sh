#!/bin/bash

echo "====================================================================================="
echo "Welcome to Tensorflow Manual Installer"
echo "====================================================================================="
read -n1 -r -p "Install Bezel in ubuntu. press ENTER to continue!" ENTER
echo "[CUDA-TSFLOW] Installing Bezel dependencies.."
sudo apt-get install gcc-4.8 g++-4.8
sudo apt install curl

echo "[CUDA-TSFLOW] Adding Bezel repositories.."
echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | sudo tee /etc/apt/sources.list.d/bazel.list
curl https://bazel.build/bazel-release.pub.gpg | sudo apt-key add -

echo "[CUDA-TSFLOW] Updating package.."
sudo apt update

echo "[CUDA-TSFLOW] Installing Bezel (bazel-0.17.2). This version is recomended .."
wget https://github.com/bazelbuild/bazel/releases/download/0.17.2/bazel-0.17.2-installer-linux-x86_64.sh -P installer

chmod +x installer/bazel-0.17.2-installer-linux-x86_64.sh

mkdir $HOME/Bazel

./installer/bazel-0.17.2-installer-linux-x86_64.sh --prefix=$HOME/Bazel

echo 'export PATH="$PATH:$HOME/Bazel/bin"' >> ~/.bashrc

echo "[CUDA-TSFLOW] Bezel Installation done."

read -n1 -r -p "Setup python virtual environment. press ENTER to continue!" ENTER
pip3 install virtualenv

read -p "Enter the name of your virtual environment [Default: tensorflow-gpu]: " VENV
VENV="${VENV:=tensorflow-gpu}"

mkdir $HOME/PyEnvironment
virtualenv -p /usr/bin/python3 $HOME/PyEnvironment/$VENV

echo "[CUDA-TSFLOW] Setup Environment done."
echo " "
echo "====================================================================================="
echo "Post Setup Environment Notes"
echo "====================================================================================="
echo "Run the environment: "
echo " $ source ~/PyEnvironment/$VENV/bin/activate"
echo " "
echo "====================================================================================="
echo " "
