FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y
RUN apt install -y iproute2 iptables iputils-ping traceroute
RUN apt install -y tshark rsyslog

RUN mkdir /ws
COPY *.sh /ws

WORKDIR /ws