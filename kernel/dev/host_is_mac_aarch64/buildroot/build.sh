export FORCE_UNSAFE_CONFIGURE=1
make -j `nproc`

cp /buildroot/output/images/rootfs.ext2 /space