FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

# install packages
RUN apt update
RUN apt install -y qemu-system iproute2 wget
RUN apt install -y vim openssh-client

# setup qemu
RUN mkdir -p /etc/qemu
RUN touch /etc/qemu/bridge.conf
RUN chmod 0640 /etc/qemu/bridge.conf
RUN echo "allow br0" >> /etc/qemu/bridge.conf
RUN chmod u+s /usr/lib/qemu/qemu-bridge-helper

# setup ssh
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config

# setup workspace
RUN mkdir ws
WORKDIR /ws
COPY *.sh /ws/

# entry point
CMD ["/ws/entrypoint.sh"]
