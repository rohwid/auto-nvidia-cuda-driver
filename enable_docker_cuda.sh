read -n1 -r -p "Add NVIDIA docker repository. press ENTER to continue!" ENTER
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
  && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
  && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

read -n1 -r -p "Update packages. press ENTER to continue!" ENTER
sudo apt update

read -n1 -r -p "Install NVIDIA docker. press ENTER to continue!" ENTER
sudo apt install -y nvidia-docker2

read -n1 -r -p "Restart Docker. press ENTER to continue!" ENTER
sudo systemctl restart docker

read -n1 -r -p "Test the CUDA were running well under Docker. press ENTER to continue!" ENTER
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi