#!/bin/bash

cd /workspace
git restore .
git pull origin main
docker image rm *
docker build -t ianscrivener/runpod_stable_diffusion_custom .
docker image ls
docker push ianscrivener/runpod_stable_diffusion_custom