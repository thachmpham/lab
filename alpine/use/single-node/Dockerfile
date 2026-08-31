FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y qemu-system iproute2 vim wget

RUN mkdir ws
WORKDIR /ws

CMD ["tail", "-f", "/dev/null"]