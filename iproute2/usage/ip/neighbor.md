# IP Neighbor


# Setup Lab
- Start cluster.
```sh
host$ cd lab/iproute2
host$ docker compose up --detach --scale iproute2=4
```


# Show Neighbor Table
- IPs of nodes.
```sh
node1$ ip addr show
11: eth0@if105: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 8a:af:db:e8:a3:9a brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.2/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever

node2$ ip addr show
11: eth0@if106: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether b6:21:4d:70:6f:f8 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.3/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever

node3$ ip addr show
eth0@if107: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether be:12:98:c6:ae:5d brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.18.0.4/16 brd 172.18.255.255 scope global eth0
       valid_lft forever preferred_lft forever
```

- Ping.
```sh
node2$ ping 172.18.0.2
node3$ ping 172.18.0.2
```

- Show neighbor table.
```sh
node1$ ip neighbor show
172.18.0.4 dev eth0 lladdr be:12:98:c6:ae:5d STALE 
172.18.0.3 dev eth0 lladdr b6:21:4d:70:6f:f8 STALE
```



# References
- https://man7.org/linux/man-pages/man8/ip-neighbour.8.html
- http://www.policyrouting.org/iproute2.doc.html