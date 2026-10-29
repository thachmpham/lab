FROM fedora:44

RUN dnf install -y qemu iproute ssh procps-ng
RUN dnf install -y which file wget ping screen

# setup qemu
RUN echo "allow br1" >> /etc/qemu/bridge.conf
RUN echo "allow br2" >> /etc/qemu/bridge.conf
RUN echo "allow br3" >> /etc/qemu/bridge.conf

# setup ssh
RUN mkdir -p /root/.ssh
RUN chmod 700 /root/.ssh
COPY ssh_config /root/.ssh/config
RUN chmod 600 /root/.ssh/config

# setup workspace
RUN mkdir /ws
WORKDIR /ws
COPY *.sh /ws/

CMD ["/ws/entrypoint.sh"]
