#!/bin/bash 
/root/miniconda/bin/jupyter lab --allow-root --ip=0.0.0.0 --ServerApp.allow_remote_access='True' --ServerApp.allow_origin='*' --ServerApp.base_url='/jupyter' --ServerApp.token='' --collaborative --no-browser
