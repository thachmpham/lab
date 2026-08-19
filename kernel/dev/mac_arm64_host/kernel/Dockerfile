FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y libncurses-dev make git exuberant-ctags bc libssl-dev
RUN apt install -y flex bison libelf-dev build-essential
RUN apt install -y cpio unzip rsync vim wget file xz-utils
RUN apt install -y qemu-system qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

RUN mkdir -p /space
COPY ./run.sh /space

WORKDIR /
RUN wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.186.tar.xz
RUN tar xf linux-5.15.186.tar.xz
RUN rm -f linux-5.15.186.tar.xz
RUN mv linux-5.15.186 linux

WORKDIR /linux
COPY ./build.sh /linux

CMD ["tail", "-f", "/dev/null"]