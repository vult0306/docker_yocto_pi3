# Use Ubuntu 16.04 LTS as the basis for the Docker image.
FROM ubuntu:16.04

# docker build -t pi3:latest .
# docker run -it -v /mnt/work/yocto:/work pi3:latest /bin/bash
# bitbake core-image-base

# Install all Linux packages required for Yocto builds as given in section "Build Host Packages"
# on https://www.yoctoproject.org/docs/3.0.2/brief-yoctoprojectqs/brief-yoctoprojectqs.html.
# Without DEBIAN_FRONTEND=noninteractive, the image build hangs indefinitely
# at "Configuring tzdata". Even if you answer the question about the time zone, it will
# not proceed.
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get autoremove -y --purge && \
    apt-get install -y gawk wget git-core diffstat unzip texinfo gcc-multilib \
    build-essential chrpath socat cpio python3 python3-pip python3-pexpect \
    xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
    pylint3 xterm vim locales

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

WORKDIR /work
RUN mkdir /work/pi3 && \
    cd /work/pi3 && \
git clone git://git.yoctoproject.org/poky -b dunfell
git clone git://git.yoctoproject.org/meta-raspberrypi -b dunfell
git clone https://git.openembedded.org/meta-openembedded -b dunfell
cd poky
source oe-init-build-env