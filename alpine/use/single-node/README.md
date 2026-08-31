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


# References
- https://wiki.alpinelinux.org/wiki/Installation
- https://wiki.alpinelinux.org/wiki/QEMU
- https://dev.to/zrouga/building-a-security-test-lab-with-qemu-from-zero-to-network-monitoring-4onm