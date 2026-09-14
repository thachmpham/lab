#!/usr/bin/bash

# Add route: h2 -> rt -> h1
ip route add 10.0.0.0/24 dev eth0 via 20.0.0.254

# Start services
/usr/sbin/rsyslogd

# Keep container running
tail -f /dev/null