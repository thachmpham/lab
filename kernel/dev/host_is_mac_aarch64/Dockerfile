FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y libncurses-dev make git exuberant-ctags bc libssl-dev
RUN apt install -y flex bison libelf-dev build-essential
RUN apt install -y cpio unzip rsync vim wget file xz-utils
RUN apt install -y qemu-system qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager

# WORKDIR /
# RUN wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.15.186.tar.xz
# RUN tar xf linux-5.15.186.tar.xz
# RUN rm -f linux-5.15.186.tar.xz
# RUN mv linux-5.15.186 linux

# WORKDIR /linux
# RUN make defconfig
# RUN make -j `nproc`

WORKDIR /
RUN wget https://buildroot.org/downloads/buildroot-2025.05.tar.gz
RUN tar xf buildroot-2025.05.tar.gz
RUN rm -f xf buildroot-2025.05.tar.gz
RUN mv buildroot-2025.05 buildroot

WORKDIR /buildroot
RUN make defconfig

RUN ./utils/config --file .defconfig --enable BR2_aarch64
RUN ./utils/config --file .defconfig --set-str BR2_ARCH aarch64
RUN ./utils/config --file .defconfig --set-str BR2_ENDIAN LITTLE
RUN ./utils/config --file .defconfig --enable BR2_TARGET_GENERIC_GETTY
RUN ./utils/config --file .defconfig --set-str BR2_TARGET_GENERIC_GETTY_PORT ttyAMA0
RUN ./utils/config --file .defconfig --enable BR2_PACKAGE_PCIUTILS
RUN ./utils/config --file .defconfig --enable BR2_TARGET_ROOTFS_EXT2
RUN ./utils/config --file .defconfig --enable BR2_TARGET_ROOTFS_EXT2_2
RUN ./utils/config --file .defconfig --enable BR2_TARGET_ROOTFS_EXT2_2r1
RUN ./utils/config --file .defconfig --set-val BR2_TARGET_ROOTFS_EXT2_GEN=2
RUN ./utils/config --file .defconfig --set-str BR2_TOOLCHAIN_BUILDROOT_LIBC glibc

RUN FORCE_UNSAFE_CONFIGURE=1 make -j `nproc`

CMD ["tail", "-f", "/dev/null"]