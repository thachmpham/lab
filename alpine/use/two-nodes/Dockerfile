FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y qemu-system iproute2 wget
RUN apt install -y vim openssh-client

RUN mkdir -p /etc/qemu
RUN touch /etc/qemu/bridge.conf
RUN chmod 0640 /etc/qemu/bridge.conf
RUN echo "allow br0" >> /etc/qemu/bridge.conf
RUN chmod u+s /usr/lib/qemu/qemu-bridge-helper

RUN mkdir ws
WORKDIR /ws

COPY *.sh /ws

CMD ["/ws/entrypoint.sh"]
