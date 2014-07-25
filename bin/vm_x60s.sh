#!/bin/bash

# Configure VMWare Player Network:
# Open cmd.exe as Administrator
# C:\> cd "C:\Program Files\VMware\VMware Player"
# C:\...> rundll32.exe vmnetui.dll VMNetUI_ShowStandalone
# Configure IP ranges and NAT exceptions (forwarder) for port 22
# Note: do NOT omit host IP, it seems to be required to be working (?)
# Then have ~/.ssh/config
#   Host vm
#   HostName 192.168.41.28
#   User steffen
#   ForwardX11Trusted Yes
#   ForwardAgent Yes
# For the appropriate IP address.
ssh -fY vm  -l root 'xterm' & 
ssh -fY vm 'xterm -geometry 80x53-9+30 & xterm -geometry 80x53+5+30' &
