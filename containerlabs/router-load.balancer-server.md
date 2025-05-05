# Adding a Simple Load Balancer to a Containerlab Topology

## Overview

In this tutorial, we will extend an existing Containerlab topology to include a basic HTTP load balancer using HAProxy. The load balancer will distribute traffic between two nginx-based web servers. We will use Alpine Linux as the base image for all containers.

### Learning Intentions

Learning Intentions

By the end of this tutorial, students will be able to:

* Identify the purpose of a load balancer in a network topology.
* Extend an existing Containerlab topology with additional nodes.
* Configure Alpine Linux containers with static IP addresses.
* Deploy a simple HAProxy-based HTTP load balancer.
* Verify round-robin behavior using curl or browser-based testing.

### Success Criteria

Students will demonstrate success when they:

* ✔️ Correctly duplicate the web server node into web1 and web2 with separate IP addresses.
* ✔️ Configure and bind appropriate scripts that bring up the network interfaces and start nginx.
* ✔️ Define and deploy a load balancer container that uses a provided haproxy.cfg.
* ✔️ Connect all nodes via a switch with valid interface links.
* ✔️ Use curl or a browser to confirm that traffic alternates between web1 and web2 responses.


---

## Learning Intentions

* Understand how to extend a Containerlab topology with new nodes.
* Configure static IP addresses in Alpine Linux containers.
* Set up and configure HAProxy as a basic HTTP load balancer.
* Deploy and verify the topology using `containerlab`.

---

## Step-by-Step Instructions

### Step 1: Duplicate the Web Server

**Purpose:** We need two web servers to distribute traffic between.

1. Copy your existing `web` node and create two nodes: `web1` and `web2`.
2. Ensure each node has its own static IP and initialization script.

```yaml
topology:
  nodes:
    web1:
      kind: linux
      image: alpine:latest
      binds:
        - ./servers/nginx/nginx.conf:/etc/nginx/nginx.conf
        - ./servers/config.web1.sh:/config/config.web.sh
      cmd: sh -c "apk add nginx && nginx -g 'daemon off;'"
      exec:
        - sh /config/config.web.sh

    web2:
      kind: linux
      image: alpine:latest
      binds:
        - ./servers/nginx/nginx.conf:/etc/nginx/nginx.conf
        - ./servers/config.web2.sh:/config/config.web.sh
      cmd: sh -c "apk add nginx && nginx -g 'daemon off;'"
      exec:
        - sh /config/config.web.sh
```

### Step 2: Create Configuration Scripts for Web Servers

**Purpose:** Assign each web server a unique IP and start nginx.

**File: `config.web1.sh`**

```sh
#!/bin/sh
set -eux
ip addr add 10.10.10.11/24 dev eth1
ip link set eth1 up
nginx -g "daemon off;"
```

**File: `config.web2.sh`**

```sh
#!/bin/sh
set -eux
ip addr add 10.10.10.12/24 dev eth1
ip link set eth1 up
nginx -g "daemon off;"
```

### Step 3: Add the Load Balancer Node

**Purpose:** This node will route traffic to the two web servers using HAProxy.

```yaml
    loadbalancer:
      kind: linux
      image: alpine:latest
      binds:
        - ./loadbalancer/haproxy.cfg:/etc/haproxy/haproxy.cfg
      cmd: sh -c "apk add haproxy && haproxy -f /etc/haproxy/haproxy.cfg"
```

### Step 4: Configure HAProxy

**Purpose:** Define how HAProxy should route incoming HTTP requests.

**File: `haproxy.cfg`**

```cfg
global
    daemon
    maxconn 256

defaults
    mode http
    timeout connect 5s
    timeout client  50s
    timeout server  50s

frontend http_front
    bind *:80
    default_backend http_back

backend http_back
    balance roundrobin
    server web1 10.10.10.11:80 check
    server web2 10.10.10.12:80 check
```

### Step 5: Define Network Links

**Purpose:** Connect all nodes via a virtual switch.

```yaml
links:
  - endpoints: ["router:eth1", "switch:eth1"]
  - endpoints: ["switch:eth2", "web1:eth1"]
  - endpoints: ["switch:eth3", "web2:eth1"]
  - endpoints: ["switch:eth4", "loadbalancer:eth1"]
```

### Step 6: Deploy the Topology

**Purpose:** Apply the topology and start all containers.

Run the following command in your Containerlab project directory:

```bash
containerlab deploy -t router-switch-web-lab.yml
```

### Step 7: Test the Load Balancer

**Purpose:** Verify round-robin behavior.

Use curl or a browser to access the load balancer's IP:

```bash
curl http://<loadbalancer-ip>
```

Repeat several times to see alternating responses (e.g., from different servers).

---

## Summary

You have successfully added a simple load balancer to your Containerlab topology. You used Alpine Linux and HAProxy to distribute traffic between two nginx web servers, each configured with a static IP address.

This setup is ideal for testing basic load balancing behavior in a controlled lab environment.

---

**Next Steps:** Consider adding logging, HTTPS termination, or scaling with more backend nodes.
