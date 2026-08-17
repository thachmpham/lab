FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y build-essential kmod vim
RUN apt install -y linux-headers-`uname -r`

CMD ["tail", "-f", "/dev/null"]