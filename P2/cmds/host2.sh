cat <<EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto eth1
iface eth1 inet static
    address 192.168.1.3
    netmask 255.255.255.0
EOF
