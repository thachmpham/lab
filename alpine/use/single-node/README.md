# Alpine: Single Node Setup


# Setup Container
```sh
$ docker compose build
$ docker compose up --detach
```


# Install
- Access container.
```sh
$ docker exec -it ap bash
```

- Download iso.
```sh
$ wget https://dl-cdn.alpinelinux.org/alpine/v3.24/releases/x86_64/alpine-standard-3.24.1-x86_64.iso
```

- Create disk image.
```sh
$ qemu-img create -f qcow2 alpine.qcow2 8G
```

- Install.
```sh
$ qemu-system-x86_64 -m 1024 -nic user -boot once=d -cdrom alpine-standard-3.24.1-x86_64.iso -drive file=alpine.qcow2 -nographic
```

- Later boot.
```sh
$ qemu-system-x86_64 -m 1024 -nic user -drive file=alpine.qcow2 -nographic
```


# Shortcuts
- To exit:
    - Ctrl A + X
    - poweroff


# References
- https://wiki.alpinelinux.org/wiki/Installation
- https://wiki.alpinelinux.org/wiki/QEMU