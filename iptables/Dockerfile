FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y iptables iproute2
RUN apt install -y iputils-ping traceroute tshark
RUN apt install -y vim socat

CMD ["tail", "-f", "/dev/null"]
