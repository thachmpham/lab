#!/usr/bin/bash

ip link add br0 type bridge
ip link set br0 up
ip addr add 192.0.0.2/24 dev br0

/usr/sbin/rsyslogd

service isc-dhcp-server restart
service atftpd restart

tail -f /var/log/syslog
