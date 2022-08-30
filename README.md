# CUDA Enabled Jupyter Lab Environment with Miniconda3

This repository creates a docker image for serving the Jupyter Lab application from a container behind a reverse proxy. See 
[Cloud-in-a-Box](https://github.com/TtheBC01/Cloud-in-a-Box) for a complete deployment stack with authentication and resource monitoring. 

**WARNING**: The `entrypoint.sh` script disables the native token-based authentication in the Jupyter Lab application since the resulting base image
is intended to be hosted behind a reverse proxy application with its own authentication and authorization flow. 

## Pre-built Docker Image

A version of cudaconda3 is available on docker hub pre-built for CUDA 11.4:

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

You should be able to access the Jupyter Lab application from your browser now by going to http://localhost:8888/jupyter/lab.

### Chainging Conda or Cuda versions

The [`Dockerfile`](/Dockerfile) is configured with to build arguments:

- `MINCONDA`: Default is `Miniconda3-py39_4.12.0-Linux-x86_64.sh`, see the [Miniconda installer](https://docs.conda.io/en/latest/miniconda.html) page for more options (you'll need to use a Linux installer though)
- `CUDATAG`: Default is [`11.4.0-base-ubuntu20.04` ](https://hub.docker.com/layers/cuda/nvidia/cuda/11.4.0-runtime-ubuntu20.04/images/sha256-5411ed37888d37eb7567f218fd46495e6967f7a389109ba65a4db83e9e9fd8b1?context=explore), see the [`nvidia/cuda`](https://hub.docker.com/r/nvidia/cuda/tags) Docker Hub repository for more options (stick to Debian based tags)

Therefor, you can customize the build for your needs with a command like the following:

```shell
docker build --build-arg MINICONDA=Miniconda3-py37_4.12.0-Linux-x86_64.sh --build-arg CUDATAG=11.7.0-runtime-ubuntu20.04 -t cudaconda .
```

## Adding PyTorch to Your Lab Environment

Depending on the version of CUDA you are using, the installation command will look like:

```shell
conda install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch
```