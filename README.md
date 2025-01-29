# BADAS


### Table of content

- [Usage](#usage)
- [Commands](#commands)
	- [Prerequisites](#prerequisites)
	- [Commands installation gsn3](#commands-installation-gsn3)
	- [Commands FRRouting](#commands-frrouting)
- [Part 1](#part-1)
	- [Requirements](#requirement-part-1)
	- [Notions](#notions-part-1)
	- [Display](#display-part-1)

### Usage

```sh
./start.sh
```

- In GNS3:
	- File->Import project-> `P1/P1.gns3project`
	- File->Import project-> `P2/P2.gns3project`
	- File->Import project-> `P3/P3.gns3project`

### Commands

#### Prerequisites

Prerequisites : 

```sh
sudo apt install busybox-static git build-essential pcaputils libpcap-dev
git clone https://github.com/GNS3/ubridge.git && cd ubridge && sudo make && sudo make install
```

#### Commands installation gsn3


```sh
sudo apt install python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst dynamips software-properties-common ca-certificates curl gnupg2 
sudo apt install software-properties-common
python3 -m venv gns3 && source gns3/bin/activate
pipx install gns3-server gns3-gui
pip3 inject gns3-gui gns3-server PyQt5
pip3 install -U gns3-gui gns3-server PyQt5
```

- [Doc GUI GNS3](https://docs.gns3.com/docs/using-gns3beginners/the-gns3-gui)


#### Commands FRRouting

- [**doc Vtysh**](https://docs.netscaler.com/en-us/citrix-adc/current-release/networking/vxlans)

```sh
# Launch vtysh terminal that permits to communicate with all daemons. Vtysh is installed by default in FRRoutingg/frr image.
vtysh

# Short for "configuration terminal". Permits to modify global parameters or protocol routers specific ones.
configure terminal

# Short for "interface loopback". Selects the loopback interface for comfiguration.
int lo

# Gives to (in our case) int lo the ip addr 1.1.1.1/32 .
ip addr 1.1.1.1/32

# Short for "interface ethernet0". Refers to 3.
int eth0

#Gives to (in our case) int eth0 the ip addr 10.1.1.1/30. 
ip addr 10.1.1.1/30

# Actvates the ospf protocol on the router and opens ospf's configuration mode.
router ospf

#Gives a network to opsf. In this case it means that all interfaces condigured with ip addresses will be included in ospf. area 0 is the default zone for ospf.
network 0.0.0.0/0 area 0
```

## Part 1

### Subject: GNS3 configuration with Docker

[Comands for part 1](#partie-1-commands)

#### Requirement Part 1:
	
- 2 images to need to be used:
	- 1 with a system containing at least 'busybox' (Alpine has this executable). Busybox is an small executable that combines many common UNIX utilities.
	- 1 with a system following these constraints:
		- A software that manages packet routing (zebra or quagga)
		- The service BGPD active and configured
		- The service OSPFD active and configured
		- An IS-IS routing engine service
		- Busybox or equivalent.


#### Notions Part 1:

Packet routing manager:

> Quagga is a network routing software handling IPv4 and IPv6. Among protocols as OSPFv4, IS-IS and others, BGP-4 is supported.

BGPD:

> BGPD stands for Border Gateway Protocol Daemon. It manages the network routing tables. Its main purpose is to exchange informations concerning "network reachability" with other BGP systems. BGPD uses BGP-4 (RFC 4271). Manual: [https://manpages.debian.org/testing/openbgpd/bgpd.8.en.html](https://manpages.debian.org/testing/openbgpd/bgpd.8.en.html) .

OSPFD:

> Stands for Open Shortest Path First Daemon. OSPF is a protocol that determines the best path that packets can use to navigate through networks. When a router detects a modification in a routing table or a change in the network, it immediatly spreads the information to all OSPF host in the network. French source: [https://www.lemagit.fr/definition/OSPF](https://www.lemagit.fr/definition/OSPF).

IS-IS:

> Stands for "Intermediate System to Intermediate System". It is a protocol used in autonomous systems(RFC 1930). Routers using this protocol maintain a common topology. The topology databse is built individually then shared between all routers. Packets are transmitted by the shortest path (calculated with the SPF algorithm).

>IS-IS routers are level 1 or level 2 or level 1-2. Level 1 communicates with level 1 only, level 2 with level 2 only. Level 1-2 can communicate with both types.

#### Display part 1

```sh
do sh ip route
do sh int

do sh ip ospf int
do sh ip ospf neighbor

do sh isis int
do sh isis neighbor

do sh ip bgp
do sh ip bgp summary	
```

## Part 2

### configuration unicast

routeur 1

```sh
/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up
/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 remote 30.1.1.2 local 30.1.1.1 dstport 4789
/sbin/ip link set vxlan10 up
brctl addif br0 eth1
brctl addif br0 vxlan10
```

routeur 2

```sh
/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up
/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 remote 30.1.1.1 local 30.1.1.2 dstport 4789
/sbin/ip link set vxlan10 up
brctl addif br0 eth1
brctl addif br0 vxlan10
```

### configuration multicast

> Same configuration for both routers

```sh
/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up
/sbin/ip link add name vxlan10 type vxlan id 10 dev eth0 group 239.1.1.1 dstport 4789
/sbin/ip link set vxlan10 up
brctl addif br0 eth1
brctl addif br0 vxlan10
```

### show infos

```sh
/sbin/ip -d link show vxlan10
/sbin/ip link show
/usr/sbin/brctl showmacs br0
```

## Part 3

### Step

- router1
	- set up vtysh (6:30)
		- eth0-2 & lo
		- bgp
			- evpn
		- ospf
- router2
	- set up interfaces (6:07)
	- set up vtysh (6:11)
		- eth0 & lo
		- bgp
			- evpn
		- ospf
- router3 (7:43)
	- set up vtysh (7:43)
		- eth1 & lo
		- bgp
			- evpn
		- ospf
- router4
	- set up interfaces (8:35)
	- set up vtysh (6:11)
		- eth2 & lo
		- bgp
			- evpn
		- ospf
- host1
	- set up ip 
- host3
	- set up ip

### Commands

```sh
/sbin/ip link add br0 type bridge
/sbin/ip link set dev br0 up
/sbin/ip link add name vxlan10 type vxlan id 10 dstport 4789
/sbin/ip link set vxlan10 up
# Adapt interface
brctl addif br0 eth1
brctl addif br0 vxlan10

vtysh
conf t

# router 1 (RR)
router bgp 1
 neighbor ibgp peer-group
 neighbor ibgp remote-as 1
 neighbor ibgp update-source lo
 bgp listen range 1.1.1.0/29 peer-group ibgp

 address-family l2vpn evpn
  neighbor ibgp activate
  neighbor ibgp route-reflector-client
 exit-address-family

router ospf
 network 0.0.0.0/0 area 0
 line vty


# router 2/3/4
router bgp 1
 neighbor 1.1.1.1 remote-as 1
 neighbor 1.1.1.1 update-source lo

 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family

router ospf
```

```sh
do sh bgp summary
do sh bgp l2vpn evpn
```

## TO-DO
