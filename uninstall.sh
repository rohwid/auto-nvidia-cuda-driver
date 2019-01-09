#!/bin/bash

sudo apt purge nvidia*
sudo apt autoremove
sudo apt autoclean
sudo rm -rf /usr/local/cuda*
