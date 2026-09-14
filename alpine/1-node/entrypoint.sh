#!/usr/bin/bash

ip link add br0 type bridge
ip link set br0 up
ip addr add 192.0.0.254/24 dev br0

tail -f /dev/null