#!/bin/sh
set -eux

# Assign static IP to the main interface (typically eth1 in containerlab topologies)
ip addr add 10.10.10.10/24 dev eth1
ip link set eth1 up

# Start nginx
# nginx -g "daemon off;"
