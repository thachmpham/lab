#!/usr/bin/bash

# install packages
ssh vm1 apk add drbd-utils lsblk parted e2fsprogs-extra
ssh vm2 apk add drbd-utils lsblk parted e2fsprogs-extra

echo 'export PATH=$PATH:/usr/lib/drbd' | ssh vm1 tee -a /root/.profile
echo 'export PATH=$PATH:/usr/lib/drbd' | ssh vm2 tee -a /root/.profile
