# Alpine: Single Node Setup


# Setup Container
```sh
host$ docker compose build
host$ docker compose up --detach
```


# Install
- Access container.
```sh
host$ docker exec -it ap bash
```

- Download iso.
```sh
container$ wget https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-standard-3.24.1-x86_64.iso
```

- Create disk image.
```sh
container$ qemu-img create -f qcow2 alpine.qcow2 8G
```

- Install.
```sh
container$ qemu-system-x86_64 -m 1024 -nic user -boot once=d -cdrom alpine-standard-3.24.1-x86_64.iso -drive file=alpine.qcow2 -nographic
```

- Within VM, install alpine.
```sh
vm$ setup-alpine
# - Keyboard: us
# - Hostname: localhost
# - Network: eth0, dhcp
# - Password:
# - Timezone: your timezone
# - Disk: sda, sys (use entire disk)

# after setup done
vm$ reboot
```

- Later boot.
```sh
container$ qemu-system-x86_64 -m 1024 -nic user -drive file=alpine.qcow2 -nographic
```


# Shortcuts
- To exit:
    - Ctrl A + X
    - poweroff



# Setup Network Devices
```sh
container$ ip link add name br-testlab type bridge
container$ ip addr add 10.0.100.1/24 dev br-testlab
container$ ip link set br-testlab up

container$ sysctl -w net.ipv4.ip_forward=1

container$ ip tuntap add tap0 mode tap user root
container$ ip link set tap0 master br-testlab
container$ ip link set tap0 up

container$ ip tuntap add tap1 mode tap user root
container$ ip link set tap1 master br-testlab
container$ ip link set tap1 up

container$ ip tuntap add tap2 mode tap user root
container$ ip link set tap2 master br-testlab
container$ ip link set tap2 up
```

```sh
container$ qemu-system-x86_64 \
  -name gateway \
  -m 1024 \
  -smp 2 \
  -hda alpine.qcow2 \
  -netdev tap,id=net0,ifname=tap0,script=no,downscript=no \
  -device virtio-net-pci,netdev=net0,mac=52:54:00:12:34:00 \
  -netdev user,id=net1 \
  -device virtio-net-pci,netdev=net1,mac=52:54:00:12:34:01 \
  -nographic \
  -serial mon:stdio
```

# References
- https://wiki.alpinelinux.org/wiki/Installation
- https://wiki.alpinelinux.org/wiki/QEMU
- https://dev.to/zrouga/building-a-security-test-lab-with-qemu-from-zero-to-network-monitoring-4onm
