FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt install -y isc-dhcp-server atftpd atftp rsyslog
RUN apt install -y qemu-system syslinux-common pxelinux debootstrap
RUN apt install -y wget vim iproute2 perl lsof file

# setup qemu
RUN mkdir -p /etc/qemu
RUN touch /etc/qemu/bridge.conf
RUN chmod 0640 /etc/qemu/bridge.conf
RUN echo "allow br0" >> /etc/qemu/bridge.conf
RUN chmod u+s /usr/lib/qemu/qemu-bridge-helper

# setup dhcp server
RUN perl -pi -e 's/INTERFACESv4=""/INTERFACESv4="br0"/g' /etc/default/isc-dhcp-server
RUN cat << 'EOF' >> /etc/dhcp/dhcpd.conf
allow booting;
allow bootp;
subnet 192.0.0.0 netmask 255.255.255.0 {
        range 192.0.0.100 192.0.0.150;
        option broadcast-address 192.0.0.255;
        next-server 192.0.0.2;
        option subnet-mask 255.255.255.0;
        filename "/pxelinux.0";
}
EOF

# setup tftp server
RUN mkdir -p /srv/tftp
RUN perl -pi -e 's/USE_INETD=true/USE_INETD=false/g' /etc/init.d/atftpd
RUN echo 'OPTIONS="--port 69 --verbose=7 /srv/tftp"' > /etc/default/atftpd

# download boot files to tftp directory
WORKDIR /srv/tftp
RUN wget http://archive.ubuntu.com/ubuntu/dists/bionic-updates/main/installer-amd64/current/images/netboot/netboot.tar.gz
RUN tar xf netboot.tar.gz
RUN rm -f netboot.tar.gz
RUN echo 'console 0' >> /srv/tftp/pxelinux.cfg/default
RUN echo 'serial 0 19200 0' >> /srv/tftp/pxelinux.cfg/default
RUN perl -pi -e 's/--- quiet/--- console=ttyS0,19200 earlyprint=serial,ttyS0,19200/g' /srv/tftp/ubuntu-installer/amd64/boot-screens/txt.cfg

# helper scripts
RUN mkdir /ws
WORKDIR /ws
COPY entrypoint.sh start_vm.sh /ws

CMD ["/ws/entrypoint.sh"]
