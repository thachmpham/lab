# Traffic Control


# Setup Lab
- Setup containers.
```sh
host$ docker compose build
host$ docker compose up --detach
```


# Rate
- Ping h1 => h2.
```sh
root@h1:/# ping h2
```

- Simulate latency increasing overtime.
```sh
root@h1:/# tc qdisc add dev eth0 root netem rate 10mbit delay 0ms limit 20
```

```sh
# before simulate
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=607 ttl=64 time=0.185 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=608 ttl=64 time=0.196 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=609 ttl=64 time=0.156 ms

# after simulate
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=553 ttl=64 time=1.51 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=554 ttl=64 time=1.10 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=555 ttl=64 time=1.67 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=556 ttl=64 time=1.71 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=557 ttl=64 time=1.58 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=558 ttl=64 time=0.753 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=559 ttl=64 time=1.30 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=560 ttl=64 time=1.41 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=561 ttl=64 time=1.42 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=562 ttl=64 time=1.44 ms
64 bytes from h2.netem_network_a (10.0.0.3): icmp_seq=563 ttl=64 time=1.12 ms
```

- Reset.
```sh
root@h1:/# tc qdisc del dev eth0 root netem
```