# KMOD


# Setup Containers
```sh
$ docker compose build
$ docker compose up --detach
```


# Test
- Access container.
```sh
$ docker exec -it kmod bash
```

- Build test.
```sh
kmod$ cd /kmod/testsuite/module-playground
kmod$ make
```

- Run test.
```sh
kmod$ export PATH=$PATH:/kmod/tools
kmod$ insmod mod-simple.ko
kmod$ lsmod
kmod$ rmmod mod-simple
```
