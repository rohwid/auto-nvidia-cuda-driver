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

echo "[CUDA-TSFLOW] Installing Bezel.."
sudo apt install bazel
sudo apt upgrade bazel

echo "[CUDA-TSFLOW] Bezel Installation done."

read -n1 -r -p "Install TensorFlow dependencies. press ENTER to continue!" ENTER
pip install -U --user pip six numpy wheel mock
pip3 install -U --user pip six numpy wheel mock
sudo pip install -U --user keras_applications==1.0.5 --no-deps
sudo pip3 install -U --user keras_applications==1.0.5 --no-deps
sudo pip install -U --user keras_preprocessing==1.0.3 --no-deps
sudo pip3 install -U --user keras_preprocessing==1.0.3 --no-deps

read -n1 -r -p "Clone TensorFlow from GitHub. press ENTER to continue!" ENTER
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow
git checkout r1.12

echo "====================================================================================="
echo "IMPORATANT Note to configure TensorFlow for GPU"
echo "====================================================================================="
echo "Here is the RECOMENDATION answer to configure tensorflow for GPU: "
echo " "
echo "Please specify the location of python. [Default is /usr/bin/python]: /usr/bin/python3"
echo "Do you wish to build TensorFlow with Apache Ignite support? [Y/n]: Y"
echo "Do you wish to build TensorFlow with XLA JIT support? [Y/n]: Y"
echo "Do you wish to build TensorFlow with OpenCL SYCL support? [y/N]: N"
echo "Do you wish to build TensorFlow with ROCm support? [y/N]: N"
echo "Do you wish to build TensorFlow with CUDA support? [y/N]: Y"
echo "Please specify the CUDA SDK version you want to use. [Leave empty to default to CUDA 9.0]: 10.0"
echo "Please specify the location where CUDA 10.0 toolkit is installed. Refer to README.md for more details. [Default is /usr/local/cuda]: /usr/local/cuda-10.0"
echo "Please specify the cuDNN version you want to use. [Leave empty to default to cuDNN 7]: 7.3.1"
echo "Please specify the location where cuDNN 7 library is installed. Refer to README.md for more details. [Default is /usr/local/cuda-10.0]: /usr/local/cuda/targets/x86_64-linux"
echo "Do you wish to build TensorFlow with TensorRT support? [y/N]: N"
echo "Please specify the NCCL version you want to use. If NCCL 2.2 is not installed, then you can use version 1.3 that can be fetched automatically but it may have worse performance with multiple GPUs. [Default is 2.2]: 2.3.5"
echo "Please note that each additional compute capability significantly increases your build time and binary size. [Default is: 5.0] 5.0"
echo "Do you want to use clang as CUDA compiler? [y/N]: N"
echo "Please specify which gcc should be used by nvcc as the host compiler. [Default is /usr/bin/gcc]: /usr/bin/gcc"
echo "Do you wish to build TensorFlow with MPI support? [y/N]: N"
echo 'Please specify optimization flags to use during compilation when bazel option "--config=opt" is specified [Default is -march=native]: -march=native'
echo "Would you like to interactively configure ./WORKSPACE for Android builds? [y/N]:N"
echo " "
echo "====================================================================================="

./configure

read -n1 -r -p "Build TensorFlow installer package with bazel. press ENTER to continue!" ENTER
bazel-bin/tensorflow/tools/pip_package/build_pip_package tensorflow_pkg

read -n1 -r -p "Install TensorFlow. press ENTER to continue!" ENTER

PYVER="3"

read -p "Please specify python version to install TensorFlow [2 or 3]:" PYVER

cd tensorflow_pkg

if [[ PYVER -eq 3 ]]; then
  echo "[CUDA-TSFLOW] Installing TensorFlow in python2.."
  sudo pip3 install tensorflow*.whl
elif [[ PYVER -eq 2 ]]; then
  echo "[CUDA-TSFLOW] Installing TensorFlow in python3.."
  sudo pip3 install tensorflow*.whl
else
  echo "[CUDA-TSFLOW] Python version invalid."
  echo "[CUDA-TSFLOW] Installation failed"
  exit
fi
