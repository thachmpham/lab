# IP Route


# Setup Lab
```sh
# +--------------------+                     +----------------------+
# | H1                 |                     |                   H2 |
# |                    |                     |                      |
# |            $eth0 + |                     | + $eth0              |
# |      10.0.0.2/24 | |                     | | 20.0.0.2/24        |
# |                  | |                     | |                    |
# |                  | |                     | |                    |
# +------------------|-+                     +-|--------------------+
#                    |                         |
# +------------------|-------------------------|--------------------+
# | RT (router)      |                         |                    |
# |                  |                         |                    |
# |            $eth0 +                         + $eth1              |
# |      10.0.2.1/24                             20.0.0.100/24      |
# |                                                                 |
# |                                                                 |
# +-----------------------------------------------------------------+
#
```


- Setup containers.
```sh
$ docker compose build
$ docker compose up --detach
```


- Show container addresses.
```sh
root@h1:/# ip addr show eth0
11: eth0@if123: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 0a:3f:2f:cc:ce:e7 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.0.0.2/24 brd 10.0.0.255 scope global eth0
       valid_lft forever preferred_lft forever


root@rt:/# ip addr show eth0
11: eth0@if121: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether d2:49:e3:e9:e3:a0 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 10.0.0.100/24 brd 10.0.0.255 scope global eth0
       valid_lft forever preferred_lft forever

root@rt:/# ip addr show eth1
12: eth1@if124: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether 86:59:0d:73:12:83 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 20.0.0.100/24 brd 20.0.0.255 scope global eth1
       valid_lft forever preferred_lft forever


root@h2:/# ip addr show eth0
11: eth0@if122: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default
    link/ether f6:13:8f:dc:3f:4e brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 20.0.0.2/24 brd 20.0.0.255 scope global eth0
       valid_lft forever preferred_lft forever
```


# Setup Route Tables
- Set route: h1 => rt => h2.
```sh
root@h1:/# ip route add 20.0.0.0/24 dev eth0 via 10.0.0.100

root@h1:/# ip route show
default via 10.0.0.1 dev eth0
10.0.0.0/24 dev eth0 proto kernel scope link src 10.0.0.2
20.0.0.0/24 via 10.0.0.100 dev eth0

root@h1:/# ip route get 20.0.0.2
20.0.0.2 via 10.0.0.100 dev eth0 src 10.0.0.2 uid 0
    cache
```


- Set route: h2 => rt => h1.
```sh
root@h2:/# ip route add 10.0.0.0/24 dev eth0 via 20.0.0.100

root@h2:/# ip route show
default via 20.0.0.1 dev eth0
10.0.0.0/24 via 20.0.0.100 dev eth0
20.0.0.0/24 dev eth0 proto kernel scope link src 20.0.0.2

root@h2:/# ip route get 10.0.0.2
10.0.0.2 via 20.0.0.100 dev eth0 src 20.0.0.2 uid 0
    cache
```


# Ping Check
- Ping: h1 => h2.
```sh
root@h1:/# ping -c3 20.0.0.2
PING 20.0.0.2 (20.0.0.2) 56(84) bytes of data.
64 bytes from 20.0.0.2: icmp_seq=1 ttl=63 time=0.178 ms
64 bytes from 20.0.0.2: icmp_seq=2 ttl=63 time=0.210 ms
64 bytes from 20.0.0.2: icmp_seq=3 ttl=63 time=0.191 ms

--- 20.0.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2092ms
rtt min/avg/max/mdev = 0.178/0.193/0.210/0.013 ms

root@h1:/# traceroute -n 20.0.0.2
traceroute to 20.0.0.2 (20.0.0.2), 30 hops max, 60 byte packets
 1  10.0.0.100  1.301 ms  1.119 ms  1.071 ms
 2  20.0.0.2  1.031 ms  0.931 ms  0.877 ms
```


- Ping: h2 => h1.
```sh
root@h2:/# ping -c3 10.0.0.2
PING 10.0.0.2 (10.0.0.2) 56(84) bytes of data.
64 bytes from 10.0.0.2: icmp_seq=1 ttl=63 time=0.258 ms
64 bytes from 10.0.0.2: icmp_seq=2 ttl=63 time=0.160 ms
64 bytes from 10.0.0.2: icmp_seq=3 ttl=63 time=0.194 ms

--- 10.0.0.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2054ms
rtt min/avg/max/mdev = 0.160/0.204/0.258/0.040 ms

root@h2:/# traceroute -n 10.0.0.2
traceroute to 10.0.0.2 (10.0.0.2), 30 hops max, 60 byte packets
 1  20.0.0.100  1.403 ms  1.228 ms  1.182 ms
 2  10.0.0.2  1.141 ms  0.977 ms  0.920 ms
```


# IP Forward Check
## Check Counters
- Counters before ping.
```sh
root@rt:/# ip -s link show eth0
11: eth0@if121: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
    link/ether d2:49:e3:e9:e3:a0 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    RX:  bytes packets errors dropped  missed   mcast
         10248     130      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
          6854      81      0       0       0       0

root@rt:/# ip -s link show eth1
12: eth1@if124: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
    link/ether 86:59:0d:73:12:83 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    RX:  bytes packets errors dropped  missed   mcast
          6900      82      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
          7256      94      0       0       0       0
```


- Ping: h1 => h2.
```sh
root@h1:/# ping -c1 20.0.0.2
PING 20.0.0.2 (20.0.0.2) 56(84) bytes of data.
64 bytes from 20.0.0.2: icmp_seq=1 ttl=63 time=0.307 ms

--- 20.0.0.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.307/0.307/0.307/0.000 ms
```


- Counters after ping.
```sh
root@rt:/# ip -s link show eth0
11: eth0@if121: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
    link/ether d2:49:e3:e9:e3:a0 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    RX:  bytes packets errors dropped  missed   mcast
         10430     133      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
          7036      84      0       0       0       0

root@rt:/# ip -s link show eth1
12: eth1@if124: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default
    link/ether 86:59:0d:73:12:83 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    RX:  bytes packets errors dropped  missed   mcast
          7082      85      0       0       0       0
    TX:  bytes packets errors dropped carrier collsns
          7438      97      0       0       0       0
```

- eth0 receives ping requests, forward to eth1. So,
    - eth0.RX ↑
    - eth0.TX ↑
    - eth1.RX ↑
- eth1 receives ping replies, forward to eth0. So
    - eth1.RX ↑
    - eth1.TX ↑
    - eth0.RX ↑


## Capture Packets
- Ping: h1 => h2.
```sh
root@h1:/# ping -c1 20.0.0.2
PING 20.0.0.2 (20.0.0.2) 56(84) bytes of data.
64 bytes from 20.0.0.2: icmp_seq=1 ttl=63 time=0.307 ms

--- 20.0.0.2 ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 0.307/0.307/0.307/0.000 ms
```


- Capture eth0 in h1.
```sh
root@h1:/# tshark -i eth0
   19 283.312093505     10.0.0.2 ? 20.0.0.2     ICMP 98 Echo (ping) request  id=0x0030, seq=1/256, ttl=64
   20 283.312232172     20.0.0.2 ? 10.0.0.2     ICMP 98 Echo (ping) reply    id=0x0030, seq=1/256, ttl=63 (request in 19)
   21 288.827908383 0a:3f:2f:cc:ce:e7 ? d2:49:e3:e9:e3:a0 ARP 42 Who has 10.0.0.100? Tell 10.0.0.2
   22 288.827953883 d2:49:e3:e9:e3:a0 ? 0a:3f:2f:cc:ce:e7 ARP 42 Who has 10.0.0.2? Tell 10.0.0.100
   23 288.827984633 0a:3f:2f:cc:ce:e7 ? d2:49:e3:e9:e3:a0 ARP 42 10.0.0.2 is at 0a:3f:2f:cc:ce:e7
   24 288.828007258 d2:49:e3:e9:e3:a0 ? 0a:3f:2f:cc:ce:e7 ARP 42 10.0.0.100 is at d2:49:e3:e9:e3:a0
```


- Capture eth0 in router.
```sh
root@rt:/# tshark -i eth0
   54 406.129457159     10.0.0.2 ? 20.0.0.2     ICMP 98 Echo (ping) request  id=0x002f, seq=1/256, ttl=64
   55 406.129536951     20.0.0.2 ? 10.0.0.2     ICMP 98 Echo (ping) reply    id=0x002f, seq=1/256, ttl=63 (request in 54)
   56 411.354293620 d2:49:e3:e9:e3:a0 ? 0a:3f:2f:cc:ce:e7 ARP 42 Who has 10.0.0.2? Tell 10.0.0.100
   57 411.354368703 0a:3f:2f:cc:ce:e7 ? d2:49:e3:e9:e3:a0 ARP 42 Who has 10.0.0.100? Tell 10.0.0.2
   58 411.354392328 d2:49:e3:e9:e3:a0 ? 0a:3f:2f:cc:ce:e7 ARP 42 10.0.0.100 is at d2:49:e3:e9:e3:a0
   59 411.354393037 0a:3f:2f:cc:ce:e7 ? d2:49:e3:e9:e3:a0 ARP 42 10.0.0.2 is at 0a:3f:2f:cc:ce:e
```


- Capture eth1 in router.
```sh
root@rt:/# tshark -i eth1
   38 207.667628915     10.0.0.2 ? 20.0.0.2     ICMP 98 Echo (ping) request  id=0x002f, seq=1/256, ttl=63
   39 207.667678831     20.0.0.2 ? 10.0.0.2     ICMP 98 Echo (ping) reply    id=0x002f, seq=1/256, ttl=64 (request in 38)
   40 212.892474792 86:59:0d:73:12:83 ? f6:13:8f:dc:3f:4e ARP 42 Who has 20.0.0.2? Tell 20.0.0.100
   41 212.892511459 f6:13:8f:dc:3f:4e ? 86:59:0d:73:12:83 ARP 42 Who has 20.0.0.100? Tell 20.0.0.2
   42 212.892532251 86:59:0d:73:12:83 ? f6:13:8f:dc:3f:4e ARP 42 20.0.0.100 is at 86:59:0d:73:12:83
   43 212.892540709 f6:13:8f:dc:3f:4e ? 86:59:0d:73:12:83 ARP 42 20.0.0.2 is at f6:13:8f:dc:3f:4e
```


- Capture eth0 in h2.
```sh
root@h2:/# tshark -i eth0
   27 445.016900470     10.0.0.2 ? 20.0.0.2     ICMP 98 Echo (ping) request  id=0x0031, seq=1/256, ttl=63
   28 445.016928928     20.0.0.2 ? 10.0.0.2     ICMP 98 Echo (ping) reply    id=0x0031, seq=1/256, ttl=64 (request in 27)
   29 450.082514514 f6:13:8f:dc:3f:4e ? 86:59:0d:73:12:83 ARP 42 Who has 20.0.0.100? Tell 20.0.0.2
   30 450.082731847 86:59:0d:73:12:83 ? f6:13:8f:dc:3f:4e ARP 42 Who has 20.0.0.2? Tell 20.0.0.100
   31 450.082811014 f6:13:8f:dc:3f:4e ? 86:59:0d:73:12:83 ARP 42 20.0.0.2 is at f6:13:8f:dc:3f:4e
   32 450.082819472 86:59:0d:73:12:83 ? f6:13:8f:dc:3f:4e ARP 42 20.0.0.100 is at 86:59:0d:73:12:83
```


# Disable IP Forward
- Disable ip forward on router.
```sh
root@rt:/# sysctl -w net.ipv4.ip_forward=0
net.ipv4.ip_forward = 0
```

- Ping: h1 => h2. Result: 100% packet loss.
```sh
root@h1:/# ping -c3 20.0.0.2
PING 20.0.0.2 (20.0.0.2) 56(84) bytes of data.

--- 20.0.0.2 ping statistics ---
3 packets transmitted, 0 received, 100% packet loss, time 2082ms
```

- Enable ip forward on router.
```sh
root@rt:/# sysctl -w net.ipv4.ip_forward=1
net.ipv4.ip_forward = 1
```





# References
- https://github.com/torvalds/linux/blob/master/tools/testing/selftests/net/forwarding/router.sh