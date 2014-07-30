#!/bin/bash

# Configure VMWare Player Network (on host):
# Open cmd.exe as Administrator
#   C:\> cd "C:\Program Files\VMware\VMware Player"
#   C:\...> rundll32.exe vmnetui.dll VMNetUI_ShowStandalone
#
# Configure IP ranges and NAT exceptions (forwarder) for port 22.
# For example, network 192.168.41.0/24, DHCP range 192.168.41.100-200,
# with the host IP 192.168.41.2 for example.
# Note: do NOT omit host IP, it seems to be required to be working (?)
#
# Static IP in guest:
# Note: when guest does not use DHCP, it seems Host will not route it (AAA?)
# Workaround: use both static and dynamic IP (DHCP).
# Have /etc/networking/interfaces:
#   auto eth0
#   iface eth0 inet dhcp
#   iface eth0 inet static
#     address 192.168.41.28
#     netmask 255.255.255.0
#     gateway 192.168.41.2
#
# apt-get remove avahi-daemon
#
# Then have ~/.ssh/config
#   Host vm
#   HostName 192.168.41.28
#   User steffen
#   ForwardX11Trusted Yes
#   ForwardAgent Yes
# For the appropriate IP address.

ssh -fY vm  -l root 'xterm' & 
ssh -fY vm 'xterm -geometry 80x53-9+30 & xterm -geometry 80x53+5+30' &
