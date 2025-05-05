# Building a Two-Node SSH-Enabled Alpine Topology with Containerlab  

[containerlab install](https://containerlab.dev/install/)

```bash
mkdir clab
cd clab
mkdir switch-pc
cd switch-pc
mkdir config
```

```bash
nano topology.yml
```

```bash
name: switch-pc
topology:
  nodes:
    switch:
      kind: linux
      image: frrouting/frr:latest
      exec:
        - /config/config.switch.sh
      binds:
        - ./config:/config
    workstation:
      kind: linux
      image: alpine:latest
      exec:
        - /config/config.workstation.sh
      binds:
        - ./config:/config

  links:
    - endpoints: ["switch:eth1", "workstation:eth1"]
```

`cd config`

`nano config.switch.sh`

copy and paste this: 

```bash
#!/bin/bash

echo "Hello switch1!"

# Enable immediate flushing of output
set -o pipefail
exec > >(tee /proc/1/fd/1) 2>&1

# Ensure correct environment variables are set
export PATH=/usr/lib/frr:$PATH
export LD_LIBRARY_PATH=/usr/lib/frr:$LD_LIBRARY_PATH

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

# Check if zebra is already running to avoid starting it twice
if ! pgrep zebra > /dev/null; then
    echo "Starting up FRR daemons"
    /usr/lib/frr/zebra -d
    /usr/lib/frr/ospfd -d
    /usr/lib/frr/bgpd -d
else
    echo "FRR daemons are already running"
fi

# Check if FRR daemons are running
if ! pgrep zebra > /dev/null; then
    echo "FRR failed to start" >&2
    exit 1
fi

# Wait for the interfaces to be up
echo "Waiting for interfaces to load up"

# Loop over the interfaces and check for their status
for iface in $(ip -br link | awk '$1 !~ /@/ && $2 == "UP" {print $1}'); do
    while ! ip link show $iface > /dev/null 2>&1; do
        echo "Waiting for $iface to exist..."
        sleep 1
    done

    while ! ip -br link show $iface | grep -q "UP"; do
        echo "Waiting for $iface to be fully up..."
        sleep 1
    done

    echo "$iface is up"
done

echo "All interfaces are up!"

echo "Setting up Linux bridge"

# Create a Linux bridge instead of using FRR
brctl addbr br0

# Add all UP interfaces to the bridge, ignoring the '@' part
for iface in $(ip -br link | awk '$2 == "UP" {print $1}' | cut -d'@' -f1); do
    echo "Adding $iface to bridge br0"
    brctl addif br0 $iface
done

# Bring the bridge up
ip link set dev br0 up

echo "Bridge setup complete!"

ip -br link

exit 0

```

exit 

`nano configure.workstation.sh`

I would probably type this out

```bash
#!/bin/sh

MY_USERNAME=adam
MY_IP=10.0.0.100
MY_SUBNET=24
MY_ETHERNET=eth1

echo "configuring $MY_USERNAME"

/config/config.workstations.make_user.sh $MY_USERNAME

echo "configuring $MY_IP/$MY_SUBNET on $MY_ETHERNET"

/config/config.workstations.set_ip_addresses.sh $MY_IP $MY_SUBNET $MY_ETHERNET

echo "update packages"
apk update && apk add iproute2 || exit 1



### THIS PART I WOULD COPY AND PASTE 

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
### STOP COPYING AND PASTING
```

After that you can access your workstation by typing in terminal 

```bash
sudo docker exec -it <your-clab-name-workstation> sh
```

