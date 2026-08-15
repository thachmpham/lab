
# IPROUTE2

# Setup Lab
- Create shared folder for host and containers.
```sh
host$ mkdir ~/space
host$ chmod -R 777 ~/space
```

- Setup containers.
```sh
host$ docker compose up --detach
```

# Test
- Access container.
```sh
host$ docker exec -it iproute2-iproute2-1 bash
```

- Run all testcases.
```sh
node1$ cd /space/iproute2/testsuite
node1$ make alltests
```