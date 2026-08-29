qemu-system-x86_64 -boot order=c -nographic \
    -append "root=/dev/sda rw console=ttyS0,115200 nokaslr" \
    -m 2G -cpu max \
    -kernel /space/bzImage \
    -hda /space/rootfs.ext2
