#!/usr/bin/bash


# install packages
ssh vm1 apk add nfs-utils rsyslog util-linux e2fsprogs-extra
ssh vm2 apk add nfs-utils rsyslog util-linux e2fsprogs-extra


# start nfs
ssh vm1 rc-service nfs start
ssh vm2 rc-service nfs start


# setup vm1 as nfs server
scp /ws/exports vm1:/etc/
ssh vm1 mkdir -p /srv/nfs
ssh vm1 chmod -R 777 /srv/nfs
ssh vm1 exportfs -a


# setup vm2 as nfs client
ssh vm2 mkdir -p /mnt/nfs
ssh vm2 mount -t nfs 192.0.0.10:/srv/nfs /mnt/nfs