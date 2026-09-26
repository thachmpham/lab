#!/usr/bin/bash

# vm1: create partition /dev/sdb1
ssh vm1 bash << 'EOF'
    if [ ! -b /dev/sdb1 ]; then
        parted -s /dev/sdb mklabel msdos
        parted -s /dev/sdb mkpart primary 0% 2GiB
    fi
EOF


# vm2: create partition /dev/sdb1
ssh vm2 bash << 'EOF'
    if [ ! -b /dev/sdb1 ]; then
        parted -s /dev/sdb mklabel msdos
        parted -s /dev/sdb mkpart primary 0% 2GiB
    fi
EOF