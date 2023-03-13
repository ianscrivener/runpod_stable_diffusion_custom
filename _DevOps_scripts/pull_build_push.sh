#!/bin/bash

cd /root/runpod_stable_diffusion_custom
git restore .
git pull origin main
docker rmi -f $(docker images -aq)
docker build -t ianscrivener/runpod_stable_diffusion_custom .
docker image ls
docker push ianscrivener/runpod_stable_diffusion_custom