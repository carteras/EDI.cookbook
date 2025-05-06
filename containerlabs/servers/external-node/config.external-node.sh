#!/bin/sh

set -eux

IP_ADDR="$1"
CIDR_MASK="$2"

apk update && apk add openssh sudo iproute2 bash

# Create testuser only if not already present
if ! id -u testuser >/dev/null 2>&1; then
  adduser -D testuser
  echo "testuser:testpass" | chpasswd
  addgroup testuser wheel
fi

echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
chmod 0440 /etc/sudoers.d/wheel

# Enable SSH password authentication
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Generate host keys
ssh-keygen -A

# Set IP address manually
ip addr add "${IP_ADDR}/${CIDR_MASK}" dev eth1
ip link set eth0 up

mkdir -p /var/run/sshd

exec /usr/sbin/sshd -D
