FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y qemu-system iproute2
RUN apt install -y openssh-client vim wget

# setup qemu
RUN mkdir -p /etc/qemu
RUN touch /etc/qemu/bridge.conf
RUN chmod 0640 /etc/qemu/bridge.conf
RUN echo "allow br0" >> /etc/qemu/bridge.conf
RUN chmod u+s /usr/lib/qemu/qemu-bridge-helper

# setup ssh
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY ssh_config /root/.ssh/config/
RUN chmod 600 /root/.ssh/config

RUN mkdir ws
WORKDIR /ws

COPY *.sh /ws/

CMD ["/ws/entrypoint.sh"]
