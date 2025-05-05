#!/bin/sh
set -eux

ip addr add 10.10.10.11/24 dev eth1
ip link set eth1 up

nginx -g "daemon off;"
