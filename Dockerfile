# adjust the base image for your target version of cuda
FROM nvidia/cuda:11.0.3-base-ubuntu20.04

# grap the installer for Miniconda3
ADD https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh .

# run the install, initialize conda, and install jupyter lab
RUN bash Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p $HOME/miniconda && \
    $HOME/miniconda/bin/conda init && \
    $HOME/miniconda/bin/conda install -c conda-forge jupyterlab -y

ENTRYPOINT ["/root/miniconda/bin/jupyter", "lab", "--allow-root"]
