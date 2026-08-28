# Buildroot


# Setup Containers
- Create shared folder between host and containers.
```sh
host$ mkdir -p ~/space
```

- Setup containers.
```sh
host$ docker compose build
host$ docker compose up --detach
```


# Build Filesystem Image
- Access container
```sh
host$ docker exec -it b1 bash
```

- Build filesystem image.
```sh
root@b1:/buildroot# make menuconfig
root@b1:/buildroot# make source
root@b1:/buildroot# ./build.sh
```

Options in menuconfig:
    - Target options / Target Architecture / AArch64 (little endian)
    - System configuration / Run a getty (login prompt) after boot / TTY port / ttyAMA0
    - Target packages / Hardware handling / pciutils
    - File images / ext2/3/4 root filesystem / ext2


- Output copied to the shared folder: /space/rootfs.ext2


# Customize Filesystem Image.
```sh
root@b1:/buildroot# make menuconfig
root@b1:/buildroot# ./build.sh
```