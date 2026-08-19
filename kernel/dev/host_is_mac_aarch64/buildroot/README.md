# Buildroot


# Setup Containers
- Create shared folder between host and containers.
```sh
host$ mkdir ~/space
```

- Setup containers.
```sh
host$ docker compose build
host$ docker compose up --detach
```


# Build Filesystem Image.
- Access container.
```sh
host$ docker exec -it b1 bash
```

- Build filesystem image.
```sh
root@b1:/buildroot# ./build.sh
```

- Output copied to the shared folder.
```sh
host$ ls ~/space
rootfs.ext
```


# Customize Filesystem Image.
```sh
root@b1:/buildroot# make menuconfig

root@b1:/buildroot# ./build.sh
```