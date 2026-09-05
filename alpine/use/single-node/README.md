# Alpine: Single Node Setup

+------- host ----------+
| +----- container --+  |
| |   +- vm ---+     |  |
| |   |        |     |  |
| |   +--------+     |  |
| +------------------+  |
+-----------------------+


# 1. Setup Container
- Create container.
```sh
host$ docker compose build
host$ docker compose up --detach
```

- Access container.
```sh
host$ docker exec -it apk bash
```

# 2. Setup VM
- Create VM.
```sh
container$ /ws/create_vm.sh
```

- Install alpine to VM.
```sh
vm$ setup-alpine
# - hostname:   vm1
# - interface:  eth0
# - ipv4 addr:  dhcp
# - ipv6 addr:  auto
# - manual network config:  no
# - password:
# - timezone:   UTC
# - proxy:      none
# - ntp:        busybox
# - apk mirror: 1
# - setup user: no
# - ssh server: openssh
# - allow root ssh: yes
# - ssh key:    none
# - disk:       sda, sys

# after setup done
vm$ poweroff
```

- Start VM.
```sh
container$ /ws/start_vm.sh
```


# 3. Setup SSH

```go
container               vm
192.0.0.2            192.0.0.3
   br0                  eth1
    +                    +
    +--------------------+
```

- Setup static IP.
```sh
vm$ cat /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
hostname alpine-test

auto eth1
iface eth1 inet static
    address 192.0.0.3
    netmask 255.255.255.0

vm$ rc-service networking restart

vm$ ip addr show
3: eth1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    inet 192.0.0.3/24 scope global eth1
```

- Permit root login.
```sh
vm$ cat /etc/ssh/sshd_config
PermitRootLogin yes

vm$ rc-service sshd restart
```

- From container, ssh to vm.
```sh
container$ ssh root@192.0.0.3
```


# References
- https://wiki.alpinelinux.org/wiki/Installation
- https://wiki.alpinelinux.org/wiki/QEMU
- https://dev.to/zrouga/building-a-security-test-lab-with-qemu-from-zero-to-network-monitoring-4onm
- https://wiki.qemu.org/Features/HelperNetworking
- https://wiki.alpinelinux.org/wiki/Setting_up_a_SSH_server
