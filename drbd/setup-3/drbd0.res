resource drbd0 {
    device minor 0;
    disk /dev/sdb1;
    meta-disk internal;
    protocol C;

    on vm1 {
        address       192.0.0.10:7789;
    }

    on vm2 {
        address       192.0.0.20:7789;
    }
}