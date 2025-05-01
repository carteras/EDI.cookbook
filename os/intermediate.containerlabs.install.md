# Tutorial: Deploying Alpine Linux Servers with Containerlab

## Overview

This guide shows how to use Containerlab on Fedora Server 42 to quickly deploy multiple Alpine Linux container-based servers. You’ll:

1. Verify Containerlab is installed.
2. Create a simple topology file deploying Alpine nodes.
3. Deploy, access, and destroy the lab.

---

## Prerequisites

* Fedora Server 42 with Containerlab, containerd (or Docker), and nerdctl installed.
* Basic familiarity with shell commands (`ls`, `curl`, `containerlab`).

---

## 1. Verify Containerlab Installation

Ensure Containerlab is available on your system:

```bash
containerlab version
```

You should see a version string. If not, follow your standard Containerlab install steps before proceeding.

---

## 2. Create an Alpine Topology File

1. In your working directory, create `alpine-servers.clab.yml`:

   ```yaml
   name: alpine-servers
   nodes:
     server1:
       kind: generic
       image: alpine:latest
       env:
         - "PS1=[server1]\$ "
     server2:
       kind: generic
       image: alpine:latest
       env:
         - "PS1=[server2]\$ "
   # No links: servers operate independently
   ```

   * **name**: lab identifier.
   * **kind**: `generic` uses a plain container.
   * **image**: official Alpine Linux Docker image.
   * **env**: optional, sets shell prompt for clarity.

2. Save the file.

---

## 3. Deploy the Alpine Lab

Use Containerlab to spin up the containers:

```bash
containerlab deploy -t alpine-servers.clab.yml
```

* Containerlab will pull the Alpine image (if needed) and start three containers: `server1`, `server2`, and `server3`.

---

## 4. Verify Running Servers

List active nodes:

```bash
containerlab nodes
```

Example output:

```
NODE       TYPE      IMAGE           STATE  
server1    generic   alpine:latest   up     
server2    generic   alpine:latest   up     
server3    generic   alpine:latest   up     
```

Check container details:

```bash
containerlab inspect alpine-servers
```

---

## 5. Access a Server Shell

To open a shell on `server1`:

```bash
containerlab exec -t alpine-servers server1 sh
```

* You’ll land in an Alpine shell.
* Run `uname -a` or `cat /etc/os-release` to confirm it’s Alpine.

Repeat for `server2` or `server3` by replacing the node name.

---

## 6. Interact with the Servers

Inside a server container, you can install packages or run tests. For example:

```bash
# Inside server1
apk update
apk add bash
bash --version
```

Use these servers as lightweight test VMs for network experiments, scripting practice, or service demos.

---

## 7. Destroy the Lab

When you’re done, clean up all containers and networks:

```bash
containerlab destroy -t alpine-servers.clab.yml
```

---

## 8. Cleanup Images (Optional)

To remove the Alpine image from your local cache:

```bash
nerdctl rmi alpine:latest
# or docker rmi alpine:latest
```

---

**Congratulations!** You’ve deployed and managed multiple Alpine Linux server containers using Containerlab on Fedora Server 42. Feel free to extend the topology, add links, or customize each server further.
