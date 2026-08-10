# TIPC Lab


# Setup Lab
- Load tipc module.
```sh
host$ modprobe tipc
host$ lsmod | grep tipc
```

- Create shared folder for host and containers.
```sh
host$ mkdir ~/space
host$ chmod -R 777 ~/space
```

- Setup cluster.
```sh
host$ docker build --tag tipc .
host$ docker compose up --detach --scale tipc-node=4
```


# Test
- List nodes.
```sh
host$ docker exec -it tipc-tipc-node-1 tipc node list
Node Identity                    Hash     State
1e12d47e2eec                     30fed47e up
56110f4a1ecb                     48da0f4a up
52ef91eeb28e                     e06191ee up
```