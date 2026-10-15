#!/usr/bin/bash

ip link add br1 type bridge
ip link set br1 up
ip addr add 191.0.0.254/24 dev br1

ip link add br2 type bridge
ip link set br2 up
ip addr add 192.0.0.254/24 dev br2

ip link add br3 type bridge
ip link set br3 up
ip addr add 193.0.0.254/24 dev br3

tail -f /dev/null