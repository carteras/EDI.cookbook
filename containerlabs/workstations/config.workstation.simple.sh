#!/bin/sh

MY_USERNAME=adam
MY_IP=10.0.0.100
MY_SUBNET=24
MY_ETHERNET=eth1

echo "configuring $MY_USERNAME"

echo "adding $MY_USERNAME"
adduser -D -H $MY_USERNAME
echo "$MY_USERNAME:$MY_USERNAME" | chpasswd

mkdir /home/$MY_USERNAME
chown root:$MY_USERNAME /home/$MY_USERNAME
chmod 750 /home/$MY_USERNAME

# Capture and display the directory permissions for /home/$MY_USERNAME
echo "Listed directory"
DIRECTORY_LIST=$(ls -ld /home/$MY_USERNAME)
echo "$DIRECTORY_LIST"


echo "configuring $MY_IP/$MY_SUBNET on $MY_ETHERNET"

echo "waiting for interfaces to load up"

# Loop until the interface is up
for iface in $MY_ETHERNET; do
    while ! ip link show $iface up > /dev/null 2>&1; do
        echo "Waiting for $iface to be up..."
    done
done

echo "setting up IP address"

ip address add $MY_IP/$MY_SUBNET dev $MY_ETHERNET
ip link set $MY_ETHERNET up

ip a s


echo "update packages"
apk update && apk add iproute2 bash || exit 1
