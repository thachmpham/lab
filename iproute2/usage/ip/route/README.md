# IP Route


# Setup Lab
- Setup containers.
```sh
$ docker compose build
$ docker compose up --detach
```

- Show container IPs.
```sh
root@h1:/# ip -br addr show eth0
eth0@if123       UP             10.0.0.2/24

root@h2:/# ip -br addr show eth0
eth0@if122       UP             20.0.0.2/24

root@rt:/# ip -br addr
eth0@if121       UP             10.0.0.100/24
eth1@if124       UP             20.0.0.100/24
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


# Ping Test
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


# References
- https://github.com/torvalds/linux/blob/master/tools/testing/selftests/net/forwarding/router.sh