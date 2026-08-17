FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y iproute2 iptables
RUN apt install -y iputils-ping traceroute tshark

CMD ["tail", "-f", "/dev/null"]
