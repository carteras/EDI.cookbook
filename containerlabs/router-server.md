# 🧪 Containerlab Tutorial: Router ➝ Switch ➝ Web Server (Alpine + Nginx + FRR)

This tutorial guides you through creating a simple network topology using Containerlab with three nodes:

- A router (FRRouting)
- A layer 2 switch (FRRouting in bridge mode)
- A web server (Alpine Linux with Nginx)

---

## Step 1: Create the Project Directory

```bash
mkdir -p clab-router-web/routers clab-router-web/switches clab-router-web/servers/nginx
cd clab-router-web
```

---

## Step 2: Define the Containerlab Topology

Create a file named `topology.clab.yaml` with the following content:

```yaml
name: router-switch-web-lab

topology:
  nodes:
    router:
      kind: linux
      image: frrouting/frr:latest
      binds:
        - ./routers:/etc/frr
      # This script initializes all required FRR daemons and applies configuration from /etc/frr
      cmd: /usr/lib/frr/docker-start

    switch:
      kind: linux
      image: frrouting/frr:latest
      binds:
        - ./switches:/etc/frr
      # Also uses the docker-start script to bring up the bridging configuration
      cmd: /usr/lib/frr/docker-start

    web:
      kind: linux
      image: alpine:latest
      binds:
        - ./servers/nginx:/etc/nginx/conf.d
      # Installs nginx and runs it in the foreground to keep the container alive
      cmd: sh -c "apk add nginx && nginx -g 'daemon off;'"

  links:
    - endpoints: ["router:eth1", "switch:eth1"]
    - endpoints: ["switch:eth2", "web:eth1"]
```

---

## Step 3: Add FRR Configs

### Router Configuration

```bash
mkdir -p routers
```

Create `routers/frr.conf`:

```text
frr version 8.4
hostname router
log stdout

interface eth1
 ip address 10.10.10.1/24

ip route 10.10.10.0/24 eth1

line vty
```

### Switch Configuration

```bash
mkdir -p switches
```

Create `switches/frr.conf`:

```text
frr version 8.4
hostname switch
log stdout

interface eth1
 no ip address

interface eth2
 no ip address

# Bridge configuration to allow switching between eth1 and eth2
bridge bridge0
 bridge ports eth1 eth2

line vty
```

---

## Step 4: Add Nginx Configuration

```bash
mkdir -p servers/nginx
```

Create `servers/nginx/default.conf`:

```nginx
server {
    listen 80;
    server_name localhost;

    location / {
        return 200 'Welcome to Nginx from Alpine!';
    }
}
```

---

## Step 5: Deploy the Lab

```bash
sudo containerlab deploy -t topology.clab.yaml
```

If you encounter issues from a previous run (e.g., interface collisions or stuck namespaces), clean up with:

---

## Step 6: Test the Setup

- **Access the router CLI:**

```bash
  docker exec -it clab-router-switch-web-lab-router vtysh
```

```bash
  show running-config
```

```bash
Hello, this is FRRouting (version 8.4_git).
Copyright 1996-2005 Kunihiro Ishiguro, et al.

router# show running-config
Building configuration...

Current configuration:
!
frr version 8.4_git
frr defaults traditional
hostname router
log stdout
no ipv6 forwarding
!
ip route 10.10.10.0/24 eth1
!
interface eth1
 ip address 10.10.10.1/24
exit
!
end
```

- **Access the switch CLI:**

```bash
  docker exec -it clab-router-switch-web-lab-switch vtysh
```

- **Access the web container shell:**

```bash
  docker exec -it clab-router-switch-web-lab-web sh
```

- **Test the Nginx server:**

```bash
  wget -qO- http://localhost
```

---

## Step 7: Tear Down the Lab

```bash
sudo containerlab destroy -t topology.clab.yaml
```
