#!/bin/bash 
if [ "$SERVICE" = "jupyter" ]; then
    /root/miniconda/bin/jupyter lab --allow-root --ip=0.0.0.0 --ServerApp.allow_remote_access='True' --ServerApp.allow_origin='*' --ServerApp.base_url='/jupyter' --ServerApp.token='' --collaborative --no-browser
elif [ "$SERVICE" = "marimo" ]; then
    /root/miniconda/bin/marimo edit --headless --no-token --host 0.0.0.0 --port 8888
else
    echo "Error: Unknown service '$SERVICE'" >&2
    exit 1
fi