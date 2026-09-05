#!/usr/bin/bash

qemu-system-x86_64 -name vm1 \
    -m 1024 \
    -smp cpus=2 \
    -drive file=vm1.qcow2 \
    -nographic \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br0,id=net1 -device virtio-net-pci,netdev=net1