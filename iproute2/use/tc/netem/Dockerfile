FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y iproute2 iputils-ping netsniff-ng socat tshark

CMD ["tail", "-f", "/dev/null"]