#!/usr/bin/bash

# copy resource configuration
scp drbd0.res vm1:/etc/drbd.d/
scp drbd0.res vm2:/etc/drbd.d/


# setup vm1
ssh vm1 bash << 'EOF'
    export PATH=$PATH:/usr/lib/drbd
    drbdadm create-md drbd0
    drbdadm up drbd0
    drbdadm primary --force drbd0
EOF


# setup vm2
ssh vm2 bash << 'EOF'
    export PATH=$PATH:/usr/lib/drbd
    drbdadm create-md drbd0
    drbdadm up drbd0
    drbdadm secondary drbd0
EOF