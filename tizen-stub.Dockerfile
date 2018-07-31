FROM ubuntu:16.04

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get full-upgrade -y && \
    apt-get install -y \
        --no-install-recommends \
        expect \
        ruby \
        acl \
        bridge-utils \
        cpio \
        gettext \
        libcanberra-gtk-module \
        libcurl3-gnutls \
        libsdl1.2debian \
        libwebkitgtk-1.0-0 \
        libv4l-0 \
        libvirt-bin \
        libxcb-render-util0 \
        libxcb-randr0 \
        libxcb-shape0 \
        libxcb-icccm4 \
        libxcb-image0 \
        libxtst6 \
        make \
        openvpn \
        pciutils \
        python2.7 \
        qemu-kvm \
        rpm2cpio \
        sudo \
        zenity \
        zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m -G sudo,kvm,libvirtd tizen && \
    passwd -d tizen

RUN echo 'tizen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER tizen
WORKDIR /home/tizen
ENV BASH_ENV /home/tizen/.profile
SHELL ["/bin/bash", "-c"]

COPY --chown=tizen _deps/jdk-8u181-linux-x64.tar.gz .
RUN tar zxf jdk-8u181-linux-x64.tar.gz -C ~/ && \
    echo 'export JAVA_HOME=$HOME/jdk1.8.0_181' >> ~/.profile && \
    echo 'export PATH=$PATH:$JAVA_HOME/bin' >> ~/.profile && \
    rm jdk-8u181-linux-x64.tar.gz

COPY --chown=tizen _deps/web-cli_Tizen_Studio_2.4_ubuntu-64.bin .

RUN echo 'export PATH=$PATH:$HOME/tizen-studio/tools' >> ~/.profile && \
    echo 'export PATH=$PATH:$HOME/tizen-studio/ide' >> ~/.profile && \
    echo 'export PATH=$PATH:$HOME/tizen-studio/tools/ide/bin' >> ~/.profile

RUN echo 'TIZEN_SDK_INSTALLED_PATH=/home/tizen/tizen-studio' >> ~/.sdk.info && \
    echo 'TIZEN_SDK_DATA_PATH=/home/tizen/tizen-studio-data' >> ~/.sdk.info

VOLUME ["/home/tizen/tizen-studio", "/home/tizen/tizen-studio-data", "/home/tizen/workspace", "/home/tizen/.package-manager"]

CMD ["/bin/bash", "--login"]
