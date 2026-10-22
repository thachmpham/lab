#!/usr/bin/bash

qcow_file="Fedora-Server-Guest-Generic-44-1.7.x86_64.qcow2"
url="https://mirror.freedif.org/fedora/fedora/linux/releases/44/Server/x86_64/images/Fedora-Server-Guest-Generic-44-1.7.x86_64.qcow2"

if [ ! -f $qcow_file ]; then
    wget $url
fi

disk_a=$qcow_file
disk_b="disk_b.qcow2"
disk_c="disk_c.qcow2"

if [ ! -f $disk_b ]; then
    qemu-img create -f qcow2 $disk_b 4G
    qemu-img create -f qcow2 $disk_c 4G
fi

qemu-system-x86_64 -name vm \
    -m 2048 \
    -smp cpus=2 \
    -nographic \
    -drive file=$disk_a \
    -netdev user,id=net0 -device virtio-net-pci,netdev=net0 \
    -netdev bridge,br=br1,id=net1 -device virtio-net-pci,netdev=net1,mac=50:54:00:01:00:01 \
    -netdev bridge,br=br2,id=net2 -device virtio-net-pci,netdev=net2,mac=50:54:00:02:00:01 \
    -netdev bridge,br=br3,id=net3 -device virtio-net-pci,netdev=net3,mac=50:54:00:03:00:01
