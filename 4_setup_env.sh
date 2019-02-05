#!/bin/bash

echo "==============================================================================================="
echo "PREPARE BAZEL AND PYTHON ENVIROMENT FOR TENSORFLOW MANUAL COMPILATION"
echo "==============================================================================================="
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

pip install -U pip six numpy wheel mock
pip3 install -U pip six numpy wheel mock
pip install -U keras_applications==1.0.5 --no-deps
pip3 install -U keras_applications==1.0.5 --no-deps
pip install -U keras_preprocessing==1.0.3 --no-deps
pip3 install -U keras_preprocessing==1.0.3 --no-deps
