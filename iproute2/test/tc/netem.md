# Traffic Control Network Emulator (tc netem)

# Setup Lab
- Start cluster.
```sh
host$ cd lab/iproute2
host$ docker compose up --detach --scale iproute2=2
```

- Access containers.
```sh
host$ docker exec -it iproute2-iproute2-1 bash
host$ docker exec -it iproute2-iproute2-2 bash
```

- Ping.
```sh
node1$ ip -br addr
eth0@if98        UP             172.18.0.2/16

node2$ ip -br addr
eth0@if99        UP             172.18.0.3/16

node1$ ping ping -c 10 172.18.0.3
PING 172.18.0.3 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: icmp_seq=0 ttl=64 time=0.187 ms
64 bytes from 172.18.0.3: icmp_seq=1 ttl=64 time=0.166 ms
64 bytes from 172.18.0.3: icmp_seq=2 ttl=64 time=0.255 ms
64 bytes from 172.18.0.3: icmp_seq=3 ttl=64 time=0.283 ms
64 bytes from 172.18.0.3: icmp_seq=4 ttl=64 time=0.259 ms
64 bytes from 172.18.0.3: icmp_seq=5 ttl=64 time=0.274 ms
64 bytes from 172.18.0.3: icmp_seq=6 ttl=64 time=0.121 ms
64 bytes from 172.18.0.3: icmp_seq=7 ttl=64 time=0.233 ms
64 bytes from 172.18.0.3: icmp_seq=8 ttl=64 time=0.250 ms
64 bytes from 172.18.0.3: icmp_seq=9 ttl=64 time=0.236 ms
--- 172.18.0.3 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max/stddev = 0.121/0.226/0.283/0.049 ms
```


# TC NetEm Delay
```sh
node1$ tc qdisc add dev eth0 root netem delay 500ms

node$ tc qdisc show dev eth0
qdisc netem 8001: root refcnt 9 limit 1000 delay 500ms

node1$ ping -c 10 172.18.0.3
PING 172.18.0.3 (172.18.0.3): 56 data bytes
64 bytes from 172.18.0.3: icmp_seq=0 ttl=64 time=502.045 ms
64 bytes from 172.18.0.3: icmp_seq=1 ttl=64 time=510.650 ms
64 bytes from 172.18.0.3: icmp_seq=2 ttl=64 time=501.120 ms
64 bytes from 172.18.0.3: icmp_seq=3 ttl=64 time=511.018 ms
64 bytes from 172.18.0.3: icmp_seq=4 ttl=64 time=507.966 ms
64 bytes from 172.18.0.3: icmp_seq=5 ttl=64 time=510.135 ms
64 bytes from 172.18.0.3: icmp_seq=6 ttl=64 time=503.304 ms
64 bytes from 172.18.0.3: icmp_seq=7 ttl=64 time=511.133 ms
64 bytes from 172.18.0.3: icmp_seq=8 ttl=64 time=511.063 ms
64 bytes from 172.18.0.3: icmp_seq=9 ttl=64 time=511.110 ms
--- 172.18.0.3 ping statistics ---
10 packets transmitted, 10 packets received, 0% packet loss
round-trip min/avg/max/stddev = 501.120/507.954/511.133/3.929 ms

node1$ tc qdisc delete dev eth0 root
```


# Reference
- https://man7.org/linux/man-pages/man8/tc.8.html
- https://man7.org/linux/man-pages/man8/tc-netem.8.html