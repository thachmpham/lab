#!/usr/bin/bash

disk_a="disk_1a.qcow2"
disk_b="disk_1b.qcow2"
disk_c="disk_1c.qcow2"

qemu-system-x86_64 -name vm1 \
    -m 1024 \
    -smp cpus=2 \
    -nographic \
    -drive file=$disk_a \
    -drive file=$disk_b \
    -drive file=$disk_c \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br1,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:01:00:01 \
    -netdev bridge,br=br2,id=net2 -device virtio-net-pci,netdev=net2,mac=50:54:00:02:00:01 \
    -netdev bridge,br=br3,id=net3 -device virtio-net-pci,netdev=net3,mac=50:54:00:03:00:01
