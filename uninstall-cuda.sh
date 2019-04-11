#!/bin/bash

echo "[CUDA-TSFLOW] Removing cuda.."
sudo rm -rf /usr/local/cuda*

echo "[CUDA-TSFLOW] Restoring linux enviroment before cuda enviroment added.."
cp ~/.bashrc.backup.cuda ~/.bashrc
