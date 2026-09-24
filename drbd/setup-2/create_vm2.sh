#!/usr/bin/bash

iso_file="alpine-standard-3.24.1-x86_64.iso"
url="https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-standard-3.24.1-x86_64.iso"
disk_file="vm2.qcow2"
extra_disk_file="dk2.qcow2"

if [ ! -f $iso_file ]; then
    wget $url
fi

if [ ! -f $disk_file ]; then
    qemu-img create -f qcow2 $disk_file 8G
fi

if [ ! -f $extra_disk_file ]; then
    qemu-img create -f qcow2 $extra_disk_file 8G
fi

qemu-system-x86_64 -name vm2 \
    -m 1024 \
    -smp cpus=2 \
    -nic user \
    -boot once=d -cdrom $iso_file \
    -drive file=$disk_file \
    -nographic
