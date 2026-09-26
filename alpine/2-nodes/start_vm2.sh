#!/usr/bin/bash

disk_a="disk_2a.qcow2"
disk_b="disk_2b.qcow2"

qemu-system-x86_64 -name vm2 \
    -m 1024 \
    -smp cpus=2 \
    -nographic \
    -drive file=$disk_a \
    -drive file=$disk_b \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:00:00:02
