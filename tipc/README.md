# TIPC Lab
- Load tipc module.
```sh
host$   modprobe tipc
host$   lsmod | grep tipc
```

- Setup cluster.
```sh
host$   docker build --tag tipc .
host$   docker compose up --detach --scale tipc-node=4
```

- Post check.
```sh
host$   docker ps
CONTAINER ID   IMAGE          COMMAND                  CREATED          STATUS          PORTS     NAMES
e3384c132bfa   tipc           "/tipcutils/entrypoi…"   13 seconds ago   Up 12 seconds             tipc-tipc-node-1
ed827ca8124f   tipc           "/tipcutils/entrypoi…"   13 seconds ago   Up 12 seconds             tipc-tipc-node-3
55140f44090c   tipc           "/tipcutils/entrypoi…"   13 seconds ago   Up 11 seconds             tipc-tipc-node-2
29b26107a8c5   tipc           "/tipcutils/entrypoi…"   13 seconds ago   Up 11 seconds             tipc-tipc-node-4
```

```sh
host$   docker exec -it tipc-tipc-node-1 tipc node list
Node Identity                    Hash     State
1e12d47e2eec                     30fed47e up
56110f4a1ecb                     48da0f4a up
52ef91eeb28e                     e06191ee up
```

- Stop cluster.
```sh
host$ docker compose down
```