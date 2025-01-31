# Part 1: GNS3 configuration with Docker

> Goal: Install and set up GNS3 and Docker, and create two basics images for routeurs and hosts.

### Table of content
- [Definitions](#definitions)
	- [Zebra](#zebra)
	- [GNS3](#gns3)
	- [BGPD](#bgpd)
	- [OSFPD](#osfpd)
	- [IS-IS](#is-is)
- [Setup](#setup)
	- [Enable daemons](#enable-daemons)
	- [Configuration terminal](#configuration-terminal)
	- [Display command](#display-command)

## Definitions

> In this part we will shortly present the new software, technologies and protocols.

### GNS3

> GNS3 is a software that simulates networks, used for test and trainning. In this software we can connect our docker images and set up parameters that will be automatically be applied to them.<br>For example, we modified the network configuration files of our GNS3 entities to set up interfaces on start-up.

### Zebra

Zebra is a **routing software package** with routing protocol supports as [BGP](#bgpd) and [OSPF](#ospfd). It also supports BGP Route Reflector (RR)(See [Part 3]()). Source: [Wikipedia](#https://en.wikipedia.org/wiki/GNU_Zebra).

### BGPD

BGPD stands for Border Gateway Protocol Daemon. It **manages the network routing tables**. Its main purpose is to exchange informations concerning "network reachability" with other BGP systems. BGPD uses BGP-4 (RFC 4271).<br>Manual: [https://manpages.debian.org/testing/openbgpd/bgpd.8.en.html](https://manpages.debian.org/testing/openbgpd/bgpd.8.en.html) .
> BGP will be mostly used in the third part of this project.

### OSPFD

Stands for Open Shortest Path First Daemon. OSPF is a **protocol that determines the best path** that packets can use to navigate through physical networks. When a router detects a modification in a routing table or a change in the network, it immediatly spreads the information to all OSPF host in the network.<br>French source: [https://www.lemagit.fr/definition/OSPF](https://www.lemagit.fr/definition/OSPF).

### IS-IS

Stands for "Intermediate System to Intermediate System". It is a **protocol used in autonomous systems**(RFC 1930). Routers using this protocol maintain a common topology. The topology databse is built individually then shared between all routers. Packets are transmitted by the shortest path (calculated with the SPF algorithm).<br>
**IS-IS routers are level 1 or level 2 or level 1-2**. Level 1 communicates with level 1 only, level 2 with level 2 only. Level 1-2 can communicate with both types.


## Setup

> In this part we will present the main commands and their function.

### Enable daemons

The daemons are enable thanks to ```/etc/frr/daemons``` in our host. We simply have to change the values from "no" to "yes" to do so.<br>
The changes can be checked by restarting the container and simply cat the file and/or type ```ps```.

### Configuration terminal

```vtysh```: Enters the zebra terminal.
```write memory```: Write the modifications in configurations files.
```conf t```: Enters the vtysh's configuration terminal to configure our daemon. Short for ```configuration terminal```.

### Display command

> These commands can be run in vtysh and configuration terminal by adding ```do```. Ex: ```sh int``` -> ```do sh int```

```sh int``` (show interfaces): Pretty self explainatory.
e