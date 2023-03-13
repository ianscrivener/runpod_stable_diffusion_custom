#!/bin/bash

cd /mnt/vol*


# Downlaod SD models
mkdir -p sd_models
cd sd_models
wget https://civitai.com/api/download/models/9901 -O refined-WRAP8.safetensors
wget https://civitai.com/api/download/models/15236 -O Deliberate_v2.safetensors
wget https://huggingface.co/SG161222/Realistic_Vision_V1.4_Fantasy.ai/resolve/main/Realistic_Vision_V1.4.ckpt
wget https://huggingface.co/SG161222/Realistic_Vision_V1.4_Fantasy.ai/resolve/main/Realistic_Vision_V1.4-inpainting.ckpt
wget https://civitai.com/api/download/models/6514 -O GrapeLikeDreamFruit.safetensors
#wget https://civitai.com/api/download/models/96 -O Openjourney.safetensors
#wget https://civitai.com/api/download/models/2483 -O Portait_Plus_.safetensors
#wget https://civitai.com/api/download/models/1344 -O Analog_Diffusion.safetensors
cd ../

# Downlaod SD Lora models
mkdir -p sd_lora_models
cd sd_lora_models
wget https://civitai.com/api/download/models/8746 -O OpenJourneyLora.safetensors
wget https://civitai.com/api/download/models/21213 -O EdenSherLorA..safetensors
wget https://civitai.com/api/download/models/21126 -O BreastHelperBetaLora.safetensors
cd ../



cd sd_models
wget https://civitai.com/api/download/models/9901 -O refined-WRAP8.safetensors
wget https://civitai.com/api/download/models/15236 -O Deliberate_v2.safetensors
wget https://huggingface.co/SG161222/Realistic_Vision_V1.4_Fantasy.ai/resolve/main/Realistic_Vision_V1.4.ckpt
wget https://huggingface.co/SG161222/Realistic_Vision_V1.4_Fantasy.ai/resolve/main/Realistic_Vision_V1.4-inpainting.ckpt
wget https://civitai.com/api/download/models/6514 -O GrapeLikeDreamFruit.safetensors
#wget https://civitai.com/api/download/models/96 -O Openjourney.safetensors
#wget https://civitai.com/api/download/models/2483 -O Portait_Plus_.safetensors
#wget https://civitai.com/api/download/models/1344 -O Analog_Diffusion.safetensors
cd ../
