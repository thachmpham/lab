#!/usr/bin/bash

iso_file="alpine-standard-3.24.1-x86_64.iso"
url="https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-standard-3.24.1-x86_64.iso"
disk_a="disk_1a.qcow2"
disk_b="disk_1b.qcow2"
disk_c="disk_1c.qcow2"

if [ ! -f $iso_file ]; then
    wget $url
fi

if [ ! -f $disk_a ]; then
    qemu-img create -f qcow2 $disk_a 8G
    qemu-img create -f qcow2 $disk_b 4G
    qemu-img create -f qcow2 $disk_c 4G
fi

qemu-system-x86_64 -name vm1 \
    -m 1024 \
    -smp cpus=2 \
    -nographic \
    -boot once=d -cdrom $iso_file \
    -drive file=$disk_a \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br1,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:01:00:01 \
    -netdev bridge,br=br2,id=net2 -device virtio-net-pci,netdev=net2,mac=50:54:00:02:00:01 \
    -netdev bridge,br=br3,id=net3 -device virtio-net-pci,netdev=net3,mac=50:54:00:03:00:01
