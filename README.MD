## Download all installer file

Here's the link to downloads all requirement installer file:

+ [CUDA](https://developer.nvidia.com/cuda-downloads), make sure you download the `runfile (local)` installer type.
+ [cuDNN](https://developer.nvidia.com/cudnn), this site need to login first with nvidia developer account. After that, make sure you have downloaded the `cuDNN Library for Linux`. It will be give you a cuDNN installer package with `.tgz` extension.
+ [NCCL](https://developer.nvidia.com/nccl/nccl-download), same as CUDNN this step need to login with nvidia developer account. After that, make sure you have downloaded the `O/S agnostic local installer`. It will be give you a NCCL installer package with `.txz` extension.

## Put it all together

Put the three installer file that you've downloaded in `installer` directory.

## Execute order

Read and execute carefully, and do what you need. Make sure you've connected with internet and can use https connection. Here the execute order:

+ 1_install_driver.sh
+ 2_driver_status.sh
+ 3_install_cuda.sh
+ 4_setup_env.sh
+ 5_compile_tf.sh
