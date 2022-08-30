# adjust the base image for your target version of cuda
FROM nvidia/cuda:11.4.0-base-ubuntu20.04

ARG MINICONDA=Miniconda3-py39_4.12.0-Linux-x86_64.sh

# set the working directory to be /root
WORKDIR /root

# grab the installer for Miniconda3
ADD https://repo.anaconda.com/miniconda/${MINICONDA} .

# run the install, initialize conda, and install jupyter lab
RUN apt-get update && \
    apt-get install -y vim && \
    bash ${MINICONDA} -b -p $HOME/miniconda && \
    $HOME/miniconda/bin/conda init && \
    $HOME/miniconda/bin/conda install -c conda-forge jupyterlab -y && \
    rm ${MINICONDA}

# add the entrypoint script to the working directory
COPY entrypoint.sh .

ENTRYPOINT ["bash","entrypoint.sh"]