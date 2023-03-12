# derived from Runpod containers https://github.com/runpod/containers.. thanks!

    # FROM runpod/stable-diffusion-models:2.1 as build
    # COPY --from=build /models/v2-1_768-ema-pruned.ckpt /workspace/v2-1_768-ema-pruned.ckpt
    # COPY --from=build /models/v2-1_768-ema-pruned.yaml /workspace/v2-1_768-ema-pruned.yaml
    # COPY --from=build /root/.cache/huggingface /root/.cache/huggingface

FROM ubuntu:22.04 AS runtime

RUN rm -rf /workspace && mkdir /workspace && mkdir -p /root/.cache/huggingface

ENV DEBIAN_FRONTEND noninteractive

RUN apt update && \
apt install -y  --no-install-recommends \
software-properties-common \
git \
openssh-server \
libglib2.0-0 \
libsm6 \
libxrender1 \
libxext6 \
ffmpeg \
wget \
curl \
nano \
zip \
s3cmd \
python3-pip python3 python3.10-venv \
apt-transport-https ca-certificates && \
update-ca-certificates

WORKDIR /workspace

RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

WORKDIR /workspace/stable-diffusion-webui

RUN python3 -m venv /workspace/stable-diffusion-webui/venv
ENV PATH="/workspace/stable-diffusion-webui/venv/bin:$PATH"

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python get-pip.py
RUN pip install -U jupyterlab ipywidgets jupyter-archive
RUN jupyter nbextension enable --py widgetsnbextension

ADD install.py .
RUN python -m install --skip-torch-cuda-test

RUN apt clean && rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

ADD ui-config.json /workspace/stable-diffusion-webui/ui-config.json
ADD relauncher.py .
ADD webui-user.sh .
ADD start.sh /start.sh
RUN chmod a+x /start.sh

# config sd models directory
RUN mkdir /workspace/SD-CKPT && rm -rf /workspace/stable-diffusion-webui/models/Stable-diffusion/ && ln -s /workspace/SD-CKPT/ /workspace/stable-diffusion-webui/models/Stable-diffusion && ls /workspace/stable-diffusion-webui/models/Stable-diffusion/

# config lora
RUN mkdir /workspace/SD-Lora && rm -rf  /workspace/stable-diffusion-webui/models/Lora && ln -s /workspace/SD-Lora  /workspace/stable-diffusion-webui/models/Lora && ls /workspace/stable-diffusion-webui/models/Lora


# Downlaod SD models
WORKDIR /workspace/SD-CKPT
RUN wget https://civitai.com/api/download/models/9901 -O refined-WRAP8.safetensors
RUN wget https://civitai.com/api/download/models/15236 -O Deliberate_v2.safetensors
RUN wget https://huggingface.co/SG161222/Realistic_Vision_V1.4/resolve/main/Realistic_Vision_V1.4.ckpt
RUN wget https://huggingface.co/SG161222/Realistic_Vision_V1.4/resolve/main/Realistic_Vision_V1.4-inpainting.ckpt
RUN wget https://civitai.com/api/download/models/6514 -O GrapeLikeDreamFruit.safetensors
RUN wget https://civitai.com/api/download/models/96 -O Openjourney.safetensors
RUN wget https://civitai.com/api/download/models/2483 -O Portait_Plus_.safetensors
RUN wget https://civitai.com/api/download/models/1344 -O Analog_Diffusion.safetensors

# Downlaod SD Lora models
WORKDIR /workspace/Lora
RUN wget https://civitai.com/api/download/models/8746 -O OpenJourneyLora.safetensors
RUN wget https://civitai.com/api/download/models/21213 -O EdenSherLorA..safetensors
RUN wget https://civitai.com/api/download/models/21126 -O BreastHelperBetaLora.safetensors

WORKDIR /workspace

SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
