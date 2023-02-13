FROM nvidia/cuda:11.2.0-runtime-ubuntu18.04
ARG APTLIST=/etc/apt/sources.list
ENV LANG=zh_CN.utf8 LANGUAGE=zh_CN.utf8 LC_ALL=zh_CN.utf8
COPY requirements.txt ./
COPY shared_memory.py ./
#COPY ttf/Arial.ttf /root/.config/Ultralytics/
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y python3.8 python3-pip libsm6 libgl1 libzbar-dev &&\
    python3.8 -m pip install --upgrade pip -ihttps://pypi.tuna.tsinghua.edu.cn/simple--trusted-host pypi.tuna.tsinghua.edu.cn
RUN python3.8 -m pip install torch==1.10.0+cu113 torchvision==0.11.1+cu113 torchaudio==0.10.0+cu113 -fhttps://download.pytorch.org/whl/cu113/torch_stable.html
RUN python3.8 -m pip install -r requirements.txt 
RUN mv shared_memory.py /usr/lib/python3.8/multiprocessing/shared_memory.py
