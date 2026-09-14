#!/usr/bin/bash

disk_file="vm.qcow2"

if [ ! -f $disk_file ]; then
    qemu-img create -f qcow2 $disk_file 8G
fi

qemu-system-amd64 -name vm \
    -m 4096 \
    -smp cpus=2 \
    -boot order=n \
    -drive file=$disk_file \
    -nographic \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1
