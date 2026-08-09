FROM ubuntu:24.04

RUN apt -y update
RUN apt install -y iproute2 tcpdump wget vim rsyslog autoconf libtool make
RUN apt install -y build-essential autoconf automake libtool pkg-config git
RUN apt install -y libnl-3-dev libnl-genl-3-dev libdaemon-dev libmnl-dev

RUN wget https://sourceforge.net/projects/tipc/files/tipcutils-3.0.6.tgz
RUN tar xf tipcutils-3.0.6.tgz
RUN rm -f tipcutils-3.0.6.tgz
RUN mv tipcutils-3.0.6 tipcutils

WORKDIR /tipcutils

RUN ./bootstrap
RUN ./configure
RUN make
RUN make install

COPY entrypoint.sh entrypoint.sh
CMD ["./entrypoint.sh"]