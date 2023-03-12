#!/bin/bash

# docker system prune -a
# docker volumes prune


docker image ls 

docker commit -m "init" -a "Ian Scrivener" ianscrivener/runpod_stable_diffusion_custom


docker push ianscrivener/runpod_stable_diffusion_custom

