#!/usr/bin/bash

iso_file="alpine-standard-3.24.1-x86_64.iso"
url="https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-standard-3.24.1-x86_64.iso"
disk_a="disk_a.qcow2"
disk_b="disk_b.qcow2"

if [ ! -f $iso_file ]; then
    wget $url
fi

if [ ! -f $disk_a ]; then
    qemu-img create -f qcow2 $disk_a 8G
fi

if [ ! -f $disk_b ]; then
    qemu-img create -f qcow2 $disk_b 4G
fi

qemu-system-x86_64 -name vm \
    -m 1024 \
    -smp cpus=2 \
    -nographic \
    -boot once=d -cdrom $iso_file \
    -drive file=$disk_a \
    -drive file=$disk_b \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:00:00:01
