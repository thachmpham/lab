qemu-system-aarch64 -machine virt -nographic \
    -append "root=/dev/vda rw console=ttyAMA0 nokaslr" \
    -m 2G -cpu max \
    -kernel /space/Image \
    -hda /space/rootfs.ext2