FROM ubuntu:22.04

ARG TARGETPLATFORM BUILDPLATFORM
ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get -y update && apt-get -y upgrade && \
    apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable && \
    add-apt-repository universe && \
    add-apt-repository multiverse && \
    add-apt-repository restricted && \
    apt-get -y update && \
    apt-get install -y python3 python3-pip python3-lxml aria2 \
    qbittorrent-nox tzdata p7zip-full p7zip-rar xz-utils curl wget pv jq \
    ffmpeg locales neofetch git make g++ gcc automake unzip \
    autoconf libtool libsodium-dev libcurl4-openssl-dev libc-ares-dev swig \
    libssl-dev libcrypto++-dev zlib1g-dev libsqlite3-dev libfreeimage-dev  

# Installing Mega SDK Python Binding
ENV PYTHONWARNINGS=ignore
ENV MEGA_SDK_VERSION="4.8.0"
RUN git clone https://github.com/meganz/sdk.git --depth=1 -b v$MEGA_SDK_VERSION /home/sdk \
    && cd /home/sdk && rm -rf .git \
    && autoupdate -fIv && ./autogen.sh \
    && ./configure --disable-silent-rules --enable-python --with-sodium --disable-examples \
    && make -j$(nproc --all) \
    && cd bindings/python/ && python3 setup.py bdist_wheel \
    && cd dist && ls && pip3 install --no-cache-dir megasdk-*.whl 

RUN apt-get -y autoremove && apt-get -y autoclean

# Install Rclone
RUN curl https://rclone.org/install.sh | bash 

# Setup Language Environments
RUN locale-gen en_US.UTF-8
ENV LANG="en_US.UTF-8" LANGUAGE="en_US:en" LC_ALL="en_US.UTF-8"


