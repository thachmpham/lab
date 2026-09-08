#!/usr/bin/bash

disk_file="vm1.qcow2"

if [ ! -f $disk_file ]; then
    qemu-img create -f qcow2 vm1.qcow2 8G
fi

qemu-system-amd64 -name vm1 \
    -m 4096 \
    -smp cpus=2 \
    -boot order=n \
    -drive file=vm1.qcow2 \
    -nographic \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1
