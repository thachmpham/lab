#!/usr/bin/bash

# Add route: h1 -> rt -> h2
ip route add 20.0.0.0/24 dev eth0 via 10.0.0.100

# Start services
/usr/sbin/rsyslogd

# Keep container running
tail -f /dev/null