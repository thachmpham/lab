#!/usr/bin/bash

tipc node set addr "${tipc_address}"
tipc bearer enable media eth dev eth0
tail -f /dev/null