#!/bin/bash

echo "====================================================================================="
echo "NVIDIA Driver Status Checker"
echo "====================================================================================="
echo "Please select the nvidia driver status to check: "
echo "1. The current used devices"
echo "2. Installed driver"
echo "3. nvidia-smi"
read -p "Enter the answer: " OPT

driver() {
  ubuntu-drivers devices
}

intalled() {
  lsmod | grep nvidia
}

smi() {
  nvidia-smi
}

case "${OPT}" in
    1)  driver
        ;;
    2)  installed
        ;;
    3)  smi
        ;;
    *)  echo "Input invalid. Input out of range or not a number."
        echo "Operation aborted."
        exit
esac
