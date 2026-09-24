#!/usr/bin/bash

qemu-system-x86_64 -name vm2 \
    -m 1024 \
    -smp cpus=2 \
    -drive file=vm2.qcow2 \
    -drive file=dk2.qcow2 \
    -nographic \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:00:00:02