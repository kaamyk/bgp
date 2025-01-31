# BADASS - BGP At Doors of Autonomous Systems is Simple

The aim of this project is to enhance our understanding of networking by emulating multiple networks, specifically VXLAN combined with BGP-EVPN, within the GNS3 environment.

## Introduction

This initiative seeks to broaden our networking expertise by configuring and simulating a network using GNS3 alongside Docker images.

VXLAN (Virtual Extensible LAN) is a network virtualization technology that allows the extension of Layer 2 networks over a Layer 3 infrastructure. It addresses the scalability limitations of traditional VLANs by using a **24-bit VXLAN Network Identifier (VNI)**, enabling up to **16 million** isolated networks instead of the **4,096** available in VLANs. VXLAN encapsulates Ethernet frames inside **UDP packets**, allowing seamless communication between remote hosts as if they were in the same Layer 2 domain. This technology is widely used in **data centers and cloud environments** to create scalable, flexible, and multi-tenant network architectures.

### Table of content

- [Usage](#usage)
- [General Guidelines](#general-guidelines)
- [Mandatory Components](#mandatory-components)
- [Dependencies](#dependencies)

## Usage

```sh
./start.sh
```

- In GNS3:
	- File->Import project-> `P1/P1.gns3project`
	- File->Import project-> `P2/P2.gns3project`
	- File->Import project-> `P3/P3.gns3project`

## General Guidelines

- The entirety of this project is to be executed within a virtual machine.
- The project necessitates the installation and utilization of both Docker and GNS3.
- All configuration files should be organized into directories located at the root of your repository.
- The directories corresponding to the mandatory sections should be named: p1, p2, and p3.

## Mandatory Components

This project is structured into three sequential parts, each to be completed in the specified order:

1. [**Part 1**](./P1/): Setting up GNS3 with Docker.
2. [**Part 2**](./P2/): Exploring VXLAN.
3. [**Part 3**](./P3/): Delving into BGP with EVPN. 

## Dependencies

```sh
sudo apt install busybox-static git build-essential pcaputils libpcap-dev
git clone https://github.com/GNS3/ubridge.git && cd ubridge && sudo make && sudo make install
sudo apt install python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst dynamips software-properties-common ca-certificates curl gnupg2 
sudo apt install software-properties-common
python3 -m venv gns3 && source gns3/bin/activate
pipx install gns3-server gns3-gui
pip3 inject gns3-gui gns3-server PyQt5
pip3 install -U gns3-gui gns3-server PyQt5
```