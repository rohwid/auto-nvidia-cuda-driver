# Auto Install NVIDIA, CUDA and Docker CUDA

Here are the references to manage NVIDIA Driver and CUDA.

## Here's some reference's about CUDA and CUDNN support

+ [cuDNN Support Matrix](https://docs.nvidia.com/deeplearning/sdk/cudnn-support-matrix/index.html)
+ [CUDA Compute Capability Support](https://developer.nvidia.com/cuda-gpus)

## Download all installer file

Here's the link to downloads all requirement installer file:

+ [CUDA](https://developer.nvidia.com/cuda-downloads), make sure you download the `runfile (local)` installer type.
+ [cuDNN](https://developer.nvidia.com/cudnn), this site need to login first with nvidia developer account. After that, make sure you have downloaded the `cuDNN Library for Linux`. It will be give you a cuDNN installer package with `.tgz` extension.
+ [NCCL](https://developer.nvidia.com/nccl/nccl-download), same as CUDNN this step need to login with nvidia developer account. After that, make sure you have downloaded the `O/S agnostic local installer`. It will be give you a NCCL installer package with `.txz` extension.

## Put it all together

Put the three installer file that you've downloaded in `installer` directory.

## Execute order

Read and execute carefully, and do what you need. Make sure you've connected with internet and can use https connection. Here the execute order:

+ `install_driver.sh`
+ `driver_status.sh`
+ `install_cuda.sh` or `enable_docker_cuda.sh`
