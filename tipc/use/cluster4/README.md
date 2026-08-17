# TIPC Lab


# Setup Lab
- Load tipc module.
```sh
host$ modprobe tipc
host$ lsmod | grep tipc
```

- Create shared folder.
```sh
host$ mkdir ~/space
host$ chmod -R 777 ~/space
```

- Setup cluster.
```sh
host$ docker compose build
host$ docker compose up --detach 
```