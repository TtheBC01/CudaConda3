# CUDA Enabled Jupyter Lab Environment with Miniconda3

This repository creates a docker image for serving the Jupyter Lab application from a container behind a reverse proxy. See 
[Cloud-in-a-Box](https://github.com/TtheBC01/Cloud-in-a-Box) for a complete deployment stack with authentication and resource monitoring. 

## Pre-built Docker Image

```shell
docker pull tthebc01/cudaconda3
```

## Building Locally

First check the version CUDA installed on the host machine:

```shell
nvidia-smi
```

Then update the Dockerfile to point to a base image from `nvidia/cuda` that is compatible with your host machine. Then 
build a local image:

```shell
git clone https://github.com/TtheBC01/nvidia-miniconda.git
cd nvidia-miniconda
docker build -t cudaconda3 .
docker run --name cudaconda --rm -p 8888:8888 -d --gpus all cudaconda3
```

## Adding PyTorch to Your Lab Environment

Depending on the version of CUDA you are using, the installation command will look like:

```shell
conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
```