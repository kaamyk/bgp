#!/bin/bash

/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up
/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
/sbin/ip link set vxlan10 up
brctl addif br0 eth1
brctl addif br0 vxlan10
