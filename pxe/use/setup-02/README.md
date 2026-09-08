# Setup PXE Boot

- PXE server
    - Ubuntu container.
    - isc-dhcp-server
    - atftpd

- PXE client
    - qemu


# Setup container
- Create container.
```sh
host$ docker compose build
host$ docker compose up
```

- Access container.
```sh
host$ docker exec -it pxe bash
```


# Check PXE Server
- Check ports: dhcp (67), tftp (69).
```sh
pxe$ lsof -P -i -n
COMMAND PID   USER FD   TYPE DEVICE SIZE/OFF NODE NAME
dhcpd    46   root 8u  IPv4   9300      0t0  UDP *:67
atftpd   59 nobody 0u  IPv6   8401      0t0  UDP *:69
```


- Check dhcp, tftp process.
```sh
pxe$ ps ax | grep -P 'dhcp|tftp'
  PID TTY      STAT   TIME COMMAND
   46 ?        Ss     0:00 /usr/sbin/dhcpd -4 -q -cf /etc/dhcp/dhcpd.conf br0
   59 ?        Ss     0:00 /usr/sbin/atftpd --daemon --port 69 --verbose=7 /srv/tftp
```


- Show dhcp config.
```sh
pxe$ cat /etc/dhcp/dhcpd.conf

allow booting;
allow bootp;

subnet 192.0.0.0 netmask 255.255.255.0 {
        range 192.0.0.100 192.0.0.150;          # addr range for clients
        option broadcast-address 192.0.0.255;

        next-server 192.0.0.2;                  # where is boot file
        option subnet-mask 255.255.255.0;
        filename "/pxelinux.0";                 # boot file
}
```


```sh
pxe$ cat /etc/default/isc-dhcp-server

# On what interfaces should the DHCP server (dhcpd) serve DHCP requests?
#       Separate multiple interfaces with spaces, e.g. "eth0 eth1".
INTERFACESv4="br0"
```


- Show tftp config.
```sh
pxe$ cat /etc/default/atftpd
OPTIONS="--port 69 --verbose=7 /srv/tftp"
```


- Show tftp directory.
```sh
pxe$ tree /srv/tftp
.
|-- ldlinux.c32 -> ubuntu-installer/amd64/boot-screens/ldlinux.c32
|-- pxelinux.0 -> ubuntu-installer/amd64/pxelinux.0
|-- pxelinux.cfg -> ubuntu-installer/amd64/pxelinux.cfg
|-- ubuntu-installer
|   `-- amd64
|       |-- boot-screens
|       |   |-- adtxt.cfg
|       |   |-- exithelp.cfg
|       |   |-- f1.txt
|       |   |-- f10.txt
|       |   |-- f2.txt
|       |   |-- f3.txt
|       |   |-- f4.txt
|       |   |-- f5.txt
|       |   |-- f6.txt
|       |   |-- f7.txt
|       |   |-- f8.txt
|       |   |-- f9.txt
|       |   |-- ldlinux.c32
|       |   |-- libcom32.c32
|       |   |-- libutil.c32
|       |   |-- menu.cfg
|       |   |-- prompt.cfg
|       |   |-- rqtxt.cfg
|       |   |-- splash.png
|       |   |-- stdmenu.cfg
|       |   |-- syslinux.cfg
|       |   |-- txt.cfg
|       |   `-- vesamenu.c32
|       |-- initrd.gz
|       |-- linux
|       |-- pxelinux.0
|       `-- pxelinux.cfg
|           `-- default -> ../boot-screens/syslinux.cfg
`-- version.info
```


```sh
pxe$ file /srv/tftp/ubuntu-installer/amd64/pxelinux.0
/srv/tftp/ubuntu-installer/amd64/pxelinux.0: data


pxe$ file /srv/tftp/ubuntu-installer/amd64/boot-screens/ldlinux.c32
/srv/tftp/ubuntu-installer/amd64/boot-screens/ldlinux.c32: ELF 32-bit LSB shared object, Intel i386, version 1 (SYSV), dynamically linked, stripped


pxe$ cat /srv/tftp/ubuntu-installer/amd64/boot-screens/syslinux.cfg
path ubuntu-installer/amd64/boot-screens/
include ubuntu-installer/amd64/boot-screens/menu.cfg
default ubuntu-installer/amd64/boot-screens/vesamenu.c32
prompt 0
timeout 0
console 0
serial 0 19200 0


pxe$ cat /srv/tftp/ubuntu-installer/amd64/boot-screens/menu.cfg
menu title Installer boot menu
include ubuntu-installer/amd64/boot-screens/stdmenu.cfg
include ubuntu-installer/amd64/boot-screens/txt.cfg
include ubuntu-installer/amd64/boot-screens/gtk.cfg


pxe$ cat /srv/tftp/ubuntu-installer/amd64/boot-screens/txt.cfg
default install
label install
        menu label ^Install
        menu default
        kernel ubuntu-installer/amd64/linux
        append vga=788 initrd=ubuntu-installer/amd64/initrd.gz --- console=ttyS0,19200 earlyprint=serial,ttyS0,19200
label cli
        menu label ^Command-line install
        kernel ubuntu-installer/amd64/linux
        append tasks=standard pkgsel/language-pack-patterns= pkgsel/install-language-support=false vga=788 initrd=ubuntu-installer/amd64/initrd.gz --- console=ttyS0,19200 earlyprint=serial,ttyS0,19200
```


- pxelinux.0: bootloader binary, start boot process in client.
- ldlinux.c32: control module, read configuration, display menu.
- pxelinux.cfg/default:
    - ubuntu-installer/amd64/boot-screens/txt.cfg: text menu configuration.
- linux: kernel.
- initrd.gz: ramdisk, tools for kernel before load filesystem.


