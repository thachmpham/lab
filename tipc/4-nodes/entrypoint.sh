#!/usr/bin/bash

# load tipc module
if ! lsmod | grep -q tipc; then
    modprobe tipc
fi

# setup kernel dynamic debug
if ! mountpoint -q /sys/kernel/debug; then
    mount -t debugfs none /sys/kernel/debug;
fi

# enable tipc debug log
echo "module tipc +p" > /sys/kernel/debug/dynamic_debug/control

# set tipc address
tipc node set addr "${tipc_address}"
tipc bearer enable media eth dev eth0

# keep container running
tail -f /dev/null