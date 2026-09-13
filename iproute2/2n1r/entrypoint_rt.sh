#!/usr/bin/bash

# Enable IP forward
sysctl -w net.ipv4.ip_forward=1

# Start services
/usr/sbin/rsyslogd

# Keep container running
tail -f /dev/null