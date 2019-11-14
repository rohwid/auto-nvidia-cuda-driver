#!/bin/bash

cuda() {
  read -n1 -r -p "Install CUDA. press ENTER to continue!" ENTER
  if [[ -f installers/${CUDA} ]]; then
    echo "[CUDA-TSFLOW] Installing ${CUDA}.."
    sudo sh installers/${CUDA} --override --silent --toolkit
    echo "[CUDA-TSFLOW] CUDA Installation done."
    echo " "

    read -p "Do you have CUDA update patch? [y/N]: " UPDATE
    UPDATE="${UPDATE:=N}"

    if [[ $UPDATE = "N" ]] || [[ $UPDATE = "n" ]]; then
      cudnn
    elif [[ $UPDATE = "Y" ]] || [[ $UPDATE = "y" ]]; then
      read -p "How many CUDA update patch do you have? " NO_PATCH
      COUNTER=1

      while [ $COUNTER -le $NO_PATCH ]; do
        echo 'Here the content of "installers" directory:'
        ls installers/
        read -p "Please specify CUDA update patch no. $COUNTER: " CUPDATE
        sudo sh installers/${CUPDATE}
        let COUNTER=COUNTER+1
      done

      cudnn
    else
      echo "[CUDA-TSFLOW] Input invalid."
      echo "[CUDA-TSFLOW] Installation aborted."
      exit
    fi
  else
    echo "[CUDA-TSFLOW] CUDA installers not found."
    echo "[CUDA-TSFLOW] Installation aborted"
    exit
  fi
}

cudnn() {
  read -n1 -r -p "Install CUDNN. press ENTER to continue!" ENTER
  if [[ -f installers/${CUDNN} ]]; then
    echo "[CUDA-TSFLOW] Installing ${CUDNN}.."

    mkdir installers/cudnn
    tar -xzvf installers/${CUDNN} -C installers/cudnn --strip-components=1
    sudo cp installers/cudnn/include/cudnn.h /usr/local/cuda/include
    sudo cp installers/cudnn/lib64/libcudnn* /usr/local/cuda/lib64
    sudo chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*

    echo "[CUDA-TSFLOW] Cofiguring cuda in linux enviroment.."
    read -p "Have you set the cuda in ~./bashrc? [y/N]: " UPDATE_ENV
    UPDATE_ENV="${UPDATE_ENV:=N}"
    if [[ $UPDATE_ENV = "N" ]] || [[ $UPDATE_ENV = "n" ]]; then
      echo "[CUDA-TSFLOW] Backup linux enviroment before add cuda enviroment.."
      cp ~/.bashrc ~/.bashrc.orig.cuda

      echo " " >> ~/.bashrc
      echo '# CUDA Enviroment' >> ~/.bashrc
      echo 'export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}$' >> ~/.bashrc
      echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
      echo 'export CUDA_HOME="/usr/local/cuda"' >> ~/.bashrc

      nccl
    elif [[ $UPDATE_ENV = "Y" ]] || [[ $UPDATE_ENV = "y" ]]; then
      nccl
      
    else
      echo "[CUDA-TSFLOW] Input invalid."
      echo "[CUDA-TSFLOW] Installation aborted."
      exit
    fi
  else
    echo "[CUDA-TSFLOW] CUDNN installers not found."
    echo "[CUDA-TSFLOW] CUDNN installation failed"
    exit
  fi
}

nccl() {
  read -n1 -r -p "Install NCCL. press ENTER to continue!" ENTER
  if [[ -f installers/${NCCL} ]]; then
    echo "[CUDA-TSFLOW] Installing ${NCCL}.."
    mkdir installers/nccl
    tar Jxvf installers/${NCCL} -C installers/nccl/ --strip-components=1
    sudo cp installers/nccl/lib/libnccl* /usr/local/cuda/lib64/
    sudo cp installers/nccl/include/nccl.h /usr/local/cuda/include/

    clear_pkg
  else
    echo "[CUDA-TSFLOW] NCCL installers not found."
    echo "[CUDA-TSFLOW] NCCL installation failed"
    exit
  fi
}

clear_pkg(){
  read -n1 -r -p "Clear installation packages. press ENTER to continue!" ENTER
  if [[ -d installers/nccl ]] && [[ -d installers/cudnn ]]; then
    echo "[CUDA-TSFLOW] Deleting installation packages.."
    sudo rm -r installers/cudnn
    sudo rm -r installers/nccl
  else
    echo "[CUDA-TSFLOW] NCCL installers not found."
    echo "[CUDA-TSFLOW] NCCL installation failed"
    exit
  fi
}


echo "==============================================================================================="
echo "Welcome to Cuda Installers"
echo "==============================================================================================="
echo "WARNING! Please run this script as user not root."
echo " "
echo "This process will be install the latest cuda and tensorflow."
echo 'It require "installers file" and put it in "installers directory". Here is the installers list: '
echo " + Latest CUDA installers [ex: cuda_10.0.130_410.48_linux.run]."
echo " + Latest CUDNN library [ex: cudnn-10.0-linux-x64-v7.3.1.20.tgz]."
echo " + Latest NCCL installer [ex: nccl_2.3.5-2+cuda10.0_x86_64.txz]."
echo " "
echo 'If you have the "cuda toolkit update patch" put in "installers" directory too!'
echo " "

echo 'Have you put it all in "installers" and "installers/update-toolkit-patch" directory?'
read -n1 -r -p "Press ENTER to continue or CTRL + C to cancel!" ENTER
echo " "

echo 'Here the content of "installers" directory:'
ls installers/
echo " "

read -n1 -r -p "Check nvidia driver is installed correctly. press ENTER to continue!" ENTER
ubuntu-drivers devices
lsmod | grep nvidia

echo "[CUDA-TSFLOW] Checking CUDA in your computer.."
if [[ -L /usr/local/cuda ]]; then
  echo "[CUDA-TSFLOW] CUDA has installed in your system."

  read -p "Still want to continue the process or add more cuda version? [y/N]: " FORCE
  FORCE="${FORCE:=N}"

  if [[ $FORCE = "N" ]] || [[ $FORCE = "n" ]]; then
    echo "[CUDA-TSFLOW] Clean previous CUDA Installation if you want to re-install!"
    echo "[CUDA-TSFLOW] CUDA installation canceled."
    echo " "
    echo "==============================================================================================="
    echo "CUDA Post Installation Notes"
    echo "==============================================================================================="
    echo "Run this command to delete exisisting CUDA version."
    echo "$ sudo rm -r /usr/local/cuda*"
    echo " "
    echo "==============================================================================================="
    echo " "

    exit
  elif [[ $FORCE = "Y" ]] || [[ $FORCE = "y" ]]; then
    read -p "Please specify CUDA installers file. [Defaut: cuda_10.0.130_410.48_linux.run]:" CUDA
    CUDA="${CUDA:=cuda_10.0.130_410.48_linux.run}"
    read -p "Please specify CDNN installers file. [Defaut: cudnn-10.0-linux-x64-v7.3.1.20.tgz]:" CUDNN
    CUDNN="${CUDNN:=cudnn-10.0-linux-x64-v7.3.1.20.tgz}"
    read -p "Please specify NCCL installers file. [Defaut: nccl_2.3.5-2+cuda10.0_x86_64.txz]:" NCCL
    NCCL="${NCCL:=nccl_2.3.5-2+cuda10.0_x86_64.txz}"
    echo " "

    cuda
  else
    echo "[CUDA-TSFLOW] Input invalid."
    echo "[CUDA-TSFLOW] Installation aborted."
    exit
  fi
else
  read -p "Please specify CUDA installers file. [Defaut: cuda_10.0.130_410.48_linux.run]:" CUDA
  CUDA="${CUDA:=cuda_10.0.130_410.48_linux.run}"
  read -p "Please specify CDNN installers file. [Defaut: cudnn-10.0-linux-x64-v7.3.1.20.tgz]:" CUDNN
  CUDNN="${CUDNN:=cudnn-10.0-linux-x64-v7.3.1.20.tgz}"
  read -p "Please specify NCCL installers file. [Defaut: nccl_2.3.5-2+cuda10.0_x86_64.txz]:" NCCL
  NCCL="${NCCL:=nccl_2.3.5-2+cuda10.0_x86_64.txz}"
  echo " "

  cuda
fi

sudo ldconfig

echo "[CUDA-TSFLOW] CUDA Installation done."
echo " "
echo "==============================================================================================="
echo "CUDA Post Installation Notes"
echo "==============================================================================================="
echo "Load bash profile or bashrc configuration: "
echo " $ source ~/.bashrc"
echo " $ sudo ldconfig"
echo " "
echo "Verify CUDA in linux enviroment: "
echo ' $ echo $CUDA_HOME'
echo "==============================================================================================="
echo " "
