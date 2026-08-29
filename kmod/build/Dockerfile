FROM ubuntu:22.04

RUN apt update
RUN apt install -y wget build-essential zlib1g-dev liblzma-dev

RUN wget https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-29.tar.gz
RUN tar xf kmod-29.tar.gz
RUN rm -f kmod-29.tar.gz
RUN mv kmod-29 kmod

WORKDIR /kmod
RUN ./configure CFLAGS='-g' --enable-debug
RUN make
RUN make install

CMD ["tail", "-f", "/dev/null"]
