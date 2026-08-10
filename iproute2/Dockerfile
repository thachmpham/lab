FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
RUN apt update -y
RUN apt install -y vim wget sudo git
RUN apt install -y inetutils-ping socat tshark
RUN apt install -y build-essential pkg-config make
RUN apt install -y bison flex libelf-dev libmnl-dev libcap-dev

RUN wget https://www.kernel.org/pub/linux/utils/net/iproute2/iproute2-6.1.0.tar.gz
RUN tar xf iproute2-6.1.0.tar.gz
RUN rm -f iproute2-6.1.0.tar.gz
RUN mv iproute2-6.1.0 iproute2

WORKDIR /iproute2
RUN ./configure
RUN make -j `nproc`
RUN make install

CMD ["tail", "-f", "/dev/null"]