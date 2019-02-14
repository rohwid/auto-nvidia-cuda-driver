#!/bin/bash

echo "==============================================================================================="
echo "PREPARE BAZEL AND PYTHON ENVIROMENT FOR TENSORFLOW MANUAL COMPILATION"
echo "==============================================================================================="
echo "WARNING! Please run this script as user not root."
echo " "
read -n1 -r -p "Install Bezel in ubuntu. press ENTER to continue!" ENTER
echo "[CUDA-TSFLOW] Installing Bezel dependencies.."
sudo apt-get install gcc-4.8 g++-4.8
sudo apt install curl

echo "[CUDA-TSFLOW] Updating package.."
sudo apt update

echo "[CUDA-TSFLOW] Checking Bezel.."
if [ ! -d ~/Bazel ]; then
  echo "[CUDA-TSFLOW] Installing Bezel (bazel-0.17.2). This version is recomended .."
  wget https://github.com/bazelbuild/bazel/releases/download/0.17.2/bazel-0.17.2-installer-linux-x86_64.sh -P installer

  chmod +x installer/bazel-0.17.2-installer-linux-x86_64.sh

  mkdir $HOME/Bazel
  ./installer/bazel-0.17.2-installer-linux-x86_64.sh --prefix=$HOME/Bazel

  echo "[CUDA-TSFLOW] Bezel Installation done."
fi

echo "[CUDA-TSFLOW] Upgrading pip version.."
sudo -H pip install --upgrade pip
sudo -H pip3 install --upgrade pip

echo "[CUDA-TSFLOW] Installing python enviroment for tensorflow.."
sudo apt install python3-numpy python3-scipy
sudo apt install --no-install-recommends python2.7-minimal python2.7 # this line is only necessary for Ubuntu 17.10 and later
sudo apt install python-numpy python-scipy
sudo pip install -U pip six numpy wheel mock
sudo pip3 install -U pip six numpy wheel mock
sudo pip install -U keras_applications==1.0.5 --no-deps
sudo pip3 install -U keras_applications==1.0.5 --no-deps
sudo pip install -U keras_preprocessing==1.0.3 --no-deps
sudo pip3 install -U keras_preprocessing==1.0.3 --no-deps
