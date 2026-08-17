# Traffic Control

```c
/*
Egress Path
    App (sendmsg)
    => Socket buffer
    => TCP/IP
    => root qdisc (handle 1: egress)
    => netem (delay, loss, rate)
    => NIC txqueue
    => Wire

Ingress Path
    Inbound wire
    => NIC rx path
    => ingress qdisc
    => mirred redirect (action mirror to ifb0)
    => ifb0 (netem on egress)
*/
```


# Setup Lab
- Setup containers.
```sh
host$ docker compose build
host$ docker compose up --detach
```


# Test
## Delay
- Fixed delay.
```sh
root@h1:/# tc qdisc change dev eth0 root netem delay 300ms
```

- Ping time.
```sh
root@h1:/# ping h2
# before add delay
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=39 ttl=64 time=0.196 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=40 ttl=64 time=0.159 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=41 ttl=64 time=0.220 ms
# after add delay
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=100 ttl=64 time=311 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=101 ttl=64 time=311 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=102 ttl=64 time=304 ms
```

- Dynamic delay 300 ± 100 (ms), probability 50%.
```sh
root@h1:/# tc qdisc change dev eth0 root netem delay 300ms 100ms 50%
```

- Ping time.
```sh
root@h1:/# ping h2
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=171 ttl=64 time=336 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=172 ttl=64 time=260 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=173 ttl=64 time=341 ms
```


# References
- https://stackharbor.com/en/knowledge-base/tc-netem-simulate-latency-packet-loss
- https://hugne.github.io/2015/04/01/tipc-and-traffic-control