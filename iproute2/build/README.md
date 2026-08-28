
# IPROUTE2


# Build iproute2
- Create shared folder.
```sh
host$ mkdir ~/space
host$ chmod -R 777 ~/space
```

- Build.
```sh
host$ cd lab/iproute2/dev
host$ docker compose build
host$ docker compose up --detach
```


# Run Testcases
- Access container.
```sh
host$ docker exec -it iproute2-iproute2-1 bash
```

- Run all testcases.
```sh
node1$ cd /space/iproute2/testsuite
node1$ make alltests
```