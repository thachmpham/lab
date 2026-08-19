FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y libncurses-dev make git exuberant-ctags bc libssl-dev
RUN apt install -y flex bison libelf-dev build-essential
RUN apt install -y cpio unzip rsync vim wget file xz-utils

RUN wget https://buildroot.org/downloads/buildroot-2025.05.tar.gz
RUN tar xf buildroot-2025.05.tar.gz
RUN rm -f xf buildroot-2025.05.tar.gz
RUN mv buildroot-2025.05 buildroot

WORKDIR /buildroot
COPY ./config /buildroot/.config
COPY ./build.sh /buildroot

RUN mkdir -p /space
# RUN ./build.sh

CMD ["tail", "-f", "/dev/null"]