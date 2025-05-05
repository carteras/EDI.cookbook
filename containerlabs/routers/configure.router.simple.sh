#!/bin/sh

# Set hostname
vtysh -c "configure terminal" \
      -c "hostname router" \
      -c "log stdout" \
      -c "interface eth1" \
      -c "ip address 10.10.10.1/24" \
      -c "exit" \
      -c "ip route 10.10.10.0/24 eth1" \
      -c "line vty" \
      -c "end" \
      -c "write memory"
