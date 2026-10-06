#!/usr/bin/bash

# install packages
ssh vm2 apk add drbd-utils lsblk parted e2fsprogs-extra


# fix minor issues
ssh vm2 bash << 'EOF'

    if ! grep -qE "PATH=.*/usr/lib/drbd" /root/.profile; then
        echo 'export PATH=$PATH:/usr/lib/drbd' >> /root/.profile
    fi

    if ! grep -qE "PATH=.*/usr/lib/drbd" /etc/init.d/drbd; then
        echo 'export PATH=$PATH:/usr/lib/drbd' >> /etc/init.d/drbd
    fi
EOF


# create partition /dev/sdb1
ssh vm2 bash << 'EOF'
    if [ ! -b /dev/sdb1 ]; then
        parted -s /dev/sdb mklabel msdos
        parted -s /dev/sdb mkpart primary 0% 2GiB
    fi
EOF


# setup drbd resource r0
scp /ws/r0.res vm2:/etc/drbd.d/

ssh vm2 bash << 'EOF'
    export PATH=$PATH:/usr/lib/drbd
    drbdadm create-md --force r0
    drbdadm up r0
    drbdadm secondary r0
EOF