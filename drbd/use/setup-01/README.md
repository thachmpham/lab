# DRBD


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

# 2. Setup VMs
- Create VMs.
```sh
container$ /ws/create_vm1.sh
container$ /ws/create_vm2.sh
```

- Install alpine to VMs.
```sh
vm$ setup-alpine
# - hostname:   vm1/vm2
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

- Start VMs.
```sh
container$ /ws/start_vm1.sh
container$ /ws/start_vm2.sh
```


# 3. Setup IP.

```go
container               vm1                  vm2
192.0.0.2            192.0.0.10           192.0.0.20
   br0                  eth1                 eth1
    +                    +                    +
    +--------------------+--------------------+
```


- Setup IP for vm1.
```sh
vm1$ vi /etc/network/interfaces
auto lo
iface lo inet loopback
iface lo inet6 loopback

auto eth0
iface eth0 inet dhcp
iface eth0 inet6 auto

auto eth1
iface eth1
    address 192.0.0.10/24


vm1$ rc-service networking restart
```


- Setup IP for vm2.
```sh
vm2$ vi /etc/network/interfaces
auto lo
iface lo inet loopback
iface lo inet6 loopback

auto eth0
iface eth0 inet dhcp
iface eth0 inet6 auto

auto eth1
iface eth1
    address 192.0.0.20/24


vm2$ rc-service networking restart
```


# 4. Setup DRBD
- Install dependencies on both VMs.
```sh
vm$ apk add cfdisk lvm2 drbd-utils lsblk

vm$ echo 'export PATH=$PATH:/usr/lib/drbd/' >> ~/.bashrc
vm$ source ~/.bashrc
```


# References
- https://wiki.alpinelinux.org/wiki/Disk_Replication_with_DRBD
