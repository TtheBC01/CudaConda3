# default Cuda version is 12.2 with Ubuntu 20.04 as the OS
ARG CUDATAG=12.2.0-devel-ubuntu20.04

# adjust the base image for your target version of cuda
FROM nvidia/cuda:${CUDATAG}

# default Miniconda version is 4.12 with Python 3.10 
ARG MINICONDA=Miniconda3-py310_23.3.1-0-Linux-x86_64.sh

# set the working directory to be /root
WORKDIR /root

# grab the installer for Miniconda3
ADD https://repo.anaconda.com/miniconda/${MINICONDA} .

# run the install, initialize conda, and install jupyter lab
RUN DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y vim && \
    bash ${MINICONDA} -b -p $HOME/miniconda && \
    $HOME/miniconda/bin/conda init && \
    $HOME/miniconda/bin/python -m pip install jupyterlab jupyter-collaboration marimo && \
    rm ${MINICONDA}

# add the entrypoint script to the working directory
COPY entrypoint.sh .

# options are 'jupyter' or 'marimo'
ENV SERVICE='jupyter'

ENTRYPOINT ["bash","entrypoint.sh"]