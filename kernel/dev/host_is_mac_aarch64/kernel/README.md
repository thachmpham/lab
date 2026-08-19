# Linux Kernel


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


# Build Kernel
- Access container.
```sh
host$ docker exec -it k1 bash
```

- Build kernel with default config.
```sh
root@k1:/linux# make defconfig
root@k1:/linux# ./build.sh
```

- Output copied to shared folder.
```sh
root@k1:/space# ls
Image
```


# Customize Kernel
```sh
root@k1:/linux# make menuconfig
root@k1:/linux# ./build.sh
```


# Run Kernel
```sh
root@k1:/linux# /space/run.sh
```
