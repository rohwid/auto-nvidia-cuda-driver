#!/bin/bash

echo "[AUTO-CUDA] Removing driver.."
sudo apt purge nvidia*
sudo apt autoremove
sudo apt autoclean

echo "[AUTO-CUDA] Removing cuda.."
sudo rm -rf /usr/local/cuda*

echo "[AUTO-CUDA] Restoring linux enviroment before cuda enviroment added.."
if [[ -f ~/.bashrc.backup.cuda ]]; then
	cp ~/.bashrc.backup.cuda ~/.bashrc
else
	echo "[AUTO-CUDA] There's no bashrc backup found.."
if
