#!/bin/bash

echo "[CUDA-TSFLOW] Removing driver.."
sudo apt purge nvidia*
sudo apt autoremove
sudo apt autoclean
