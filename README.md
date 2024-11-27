# CUDA Enabled Jupyter Lab Environment with Miniconda3

This repository creates a docker image for serving python notebooks from a container hosted on a GPU-accelerated machine (which 
is itself behind a reverse proxy). See [Cloud-in-a-Box](https://github.com/TtheBC01/Cloud-in-a-Box) for a complete deployment stack with authentication and resource monitoring. 

Out-of-the box notebook support:
- [Jupyter Lab](https://jupyter.org/)
- [Marimo](https://marimo.io/)

**WARNING**: The [`entrypoint.sh`](/entrypoint.sh) script disables the native token-based authentication in the Jupyter Lab application since the resulting base image
is intended to be hosted behind a reverse proxy application with its own authentication and authorization flow. 

## Pre-built Docker Image

A version of [`cudaconda3`](https://hub.docker.com/r/tthebc01/cudaconda3) is available on docker hub pre-built for CUDA 12.2.0 and Python 3.10:

```shell
docker pull tthebc01/cudaconda3
```

## Building Locally

To build a local image and run with a local directory mounted in the container, do this:

```shell
git clone https://github.com/TtheBC01/CudaConda3.git
cd CudaConda3
docker build -t cudaconda3 .
docker run --name cudaconda --rm -p 8888:8888 -d --gpus all -v ~/path/to/project:/root/project cudaconda3
```

You should be able to access the Jupyter Lab application from your browser now by going to http://localhost:8888/jupyter/lab.

### Changing Conda or Cuda versions

For proper operation, the cudaconda3 base image must match the CUDA version on the host machine. First, check the version of CUDA installed on 
the host machine you will be running the container on:

```shell
nvidia-smi
```

Next, the [`Dockerfile`](/Dockerfile) is configured with two optional build arguments:

- `MINCONDA`: Default is `Miniconda3-py39_4.12.0-Linux-x86_64.sh`, see the [Miniconda installer](https://docs.conda.io/en/latest/miniconda.html) page for more options (you'll need to use a Linux installer though)
- `CUDATAG`: Default is [`11.4.0-base-ubuntu20.04` ](https://hub.docker.com/layers/cuda/nvidia/cuda/11.4.0-runtime-ubuntu20.04/images/sha256-5411ed37888d37eb7567f218fd46495e6967f7a389109ba65a4db83e9e9fd8b1?context=explore), see the [`nvidia/cuda`](https://hub.docker.com/r/nvidia/cuda/tags) Docker Hub repository for more options (stick to Debian based tags)

Therefore, you can customize the build for your needs with a command like the following:

```shell
docker build --build-arg MINICONDA=Miniconda3-py37_4.12.0-Linux-x86_64.sh --build-arg CUDATAG=11.7.0-runtime-ubuntu20.04 -t cudaconda .
```

## Adding PyTorch to Your Lab Environment

See the [PyTorch installation](https://pytorch.org/get-started/locally/) guide for commands to install your target version of the package. 

For example, installation with CUDA 12.4 will look something like this: 

```sh
python -m pip install torch torchvision torchaudio
```