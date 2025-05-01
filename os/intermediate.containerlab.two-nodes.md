**Tutorial: Building a Two-Node SSH-Enabled Alpine Topology with Containerlab**  
*Audience:* Year 11 students with basic Linux and Containerlab experience  

---

## Overview
Learn how to create and deploy a two-node network using Containerlab and custom Alpine Linux containers with SSH enabled, default users, and password authentication.

**Goals:**
1. Build a custom Alpine-based Docker image that:  
   - Installs and configures OpenSSH.  
   - Creates a default user (`bushranger`) with a known password.  
   - Enables password authentication.  
2. Write a Containerlab topology (`.clab.yml`) that uses this image for two nodes.  
3. Deploy the lab and test SSH connectivity between the host and each node.

---

## Prerequisites
- Containerlab, containerd, and nerdctl (or Docker) installed on Fedora Server 42.  
- `git`, `curl`, and basic Bash.  
- `docker` or `nerdctl` CLI to build images.

---

## 1. Create the Provisioning Script
In your working directory, create `provision.sh`:
```bash
#!/usr/bin/env bash
set -e

# Install OpenSSH
apk update && apk add --no-cache openssh

# Create default user and set password
default_user="bushranger"
default_pass="badpass"
adduser -D "$default_user"
echo "$default_user:$default_pass" | chpasswd

# Enable password authentication
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Ensure SSH host keys exist
ssh-keygen -A

# Expose SSH on port 22
# (sshd will run as the container CMD)
```
Make it executable:
```bash
chmod +x provision.sh
```

---

## 2. Write the Dockerfile
Create `Dockerfile` next to `provision.sh`:
```Dockerfile
FROM alpine:latest

# Copy and run provisioning
COPY provision.sh /provision.sh
RUN chmod +x /provision.sh \
    && /provision.sh

# Expose SSH port and start sshd in foreground
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
```

---

## 3. Build and Tag the Image
Build locally with nerdctl or Docker:
```bash
# Using nerdctl
erdctl build -t clab-alpine-ssh:latest .

# Or using Docker
docker build -t clab-alpine-ssh:latest .
```

---

## 4. Create the Containerlab Topology
In the same folder, create `two-node-ssh.clab.yml`:
```yaml
name: two-node-ssh

nodes:
  node1:
    kind: generic
    image: clab-alpine-ssh:latest
  node2:
    kind: generic
    image: clab-alpine-ssh:latest

links:
  - endpoints:
    - "node1:eth1"
    - "node2:eth1"
```  
- **kind:** `generic` runs plain Docker/nerdctl containers.  
- **image:** our custom Alpine SSH image.

---

## 5. Deploy the Lab
Run:
```bash
containerlab deploy -t two-node-ssh.clab.yml
```
Verify nodes:
```bash
containerlab nodes
```

---

## 6. Test SSH Connectivity
1. **On the host**, SSH into `node1`:
   ```bash
   ssh bushranger@172.20.20.1  # default link IP
   ```
2. **Use the password** `badpass` when prompted.  
3. **Repeat** for `node2` (e.g., `ssh bushranger@172.20.20.2`).

Inside a node, you can inspect interfaces:
```bash
ip a
```  

---

## 7. Cleanup
When finished:
```bash
containerlab destroy -t two-node-ssh.clab.yml
```  
To remove the image:
```bash
nerdctl rmi clab-alpine-ssh:latest
# or docker rmi clab-alpine-ssh:latest
```

---

**Congratulations!** You’ve built, deployed, and tested a two-node SSH-enabled topology using Containerlab and Alpine Linux.

