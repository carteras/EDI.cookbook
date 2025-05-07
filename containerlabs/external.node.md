# Tutorial: Create an External Alpine Node Connected to a Switch in Containerlab

## 🧠 Learning Intentions
By the end of this tutorial, you will be able to:
- Write a valid Containerlab topology that connects an external Alpine-based node to a Linux switch.
- Understand each key concept in the topology file and shell script.
- Configure a startup script to initialize the external node with a static IP and working SSH server.

## ✅ Success Criteria
You will know you're successful when:
- You can deploy the topology with no errors.
- You can SSH into the external node on port `2222`.
- The external node has a working IP address and user account with sudo rights.

---

## Part 1: Create the Containerlab Topology

### 🔧 Step 1: Create `alpine-dual-net.yml`
This file defines a **network topology** for Containerlab. It includes a Linux switch and an external Alpine-based node, connected by a virtual link.

#### 📘 Key Concepts

- **Declaring a Topology**: 
  The `topology:` key begins the structure. It contains the `nodes` and `links` sections.

- **Declaring Nodes**: 
  The `nodes:` section defines all the devices (containers) in your lab.

- **Individual Nodes**: 
  Each node (e.g., `switch-1`, `external`) is declared by name, and includes its properties like kind, image, and any scripts or ports.

- **`kind`:** 
  Defines the type of node. `linux` tells Containerlab to use a lightweight Linux container (not a virtual router or vendor-specific appliance).

- **`image`:** 
  The container image to use. For example, `frrouting/frr:latest` uses a Linux image with FRRouting pre-installed.

- **`exec`:** 
  A list of commands to run *after* the container has started. Useful for configuring network forwarding, daemons, or logging.

- **`cmd`:** 
  Overrides the container's default startup command. It's the main command that runs when the container launches.
  
  > ⚠️ `exec` runs **after** the container starts. `cmd` defines **how** it starts.

- **`ports`:** 
  Maps host ports to container ports. `2222:22` lets you SSH to the container by connecting to `localhost:2222`.

- **`links`:** 
  Creates virtual Ethernet links between containers. 

- **`endpoints`:** 
  Defines which interfaces are connected. Here, `external:eth1` is linked to `switch-1:eth1`, creating a direct connection between them.

```yaml
yaml
name: alpine-dual-net

topology:
  nodes:
    switch-1:
      kind: linux
      image: frrouting/frr:latest
      exec:
        - sh /config/config.switch.sh
      binds:
        - ./switches/config.switch.sh:/config/config.switch.sh

    external:
      kind: linux
      image: alpine:latest
      binds:
        - ./servers/external-node/config.external-node.sh:/config/start.sh
      cmd: sh /config/start.sh 10.13.37.1 24
      ports:
        - 2222:22

  links:
    - endpoints: ["external:eth1", "switch-1:eth1"]
```

### ✅ Checkpoint:
Save this file as `alpine-dual-net.yml`. You’ll use it to deploy the topology.

---

## Part 2: Create the External Node Startup Script

### 🔧 Step 2: Write `config.external-node.sh`
This script is executed when the external container starts up. It configures the container to:
- Install networking and SSH tools.
- Create a user account.
- Enable SSH password authentication.
- Assign a static IP address to `eth1`.

#### 📘 Key Concepts in the Script

```bash
#!/bin/sh

set -eux
```
- **`set -eux`**:
  - `-e`: Exit the script if any command fails.
  - `-u`: Exit if a variable is used before being set.
  - `-x`: Print each command before it is run (useful for debugging).

```bash
IP_ADDR="$1"
CIDR_MASK="$2"
```
- **Global Variables**: These take the arguments passed to the script (IP address and subnet mask) and store them for use later.

```bash
apk update && apk add openssh sudo iproute2 bash
```
- **`apk update`**: Refreshes the list of available packages (like `apt update` on Debian).
- **`apk add`**: Installs the listed packages.
  - `openssh`: Provides SSH server/client tools.
  - `sudo`: Lets users run commands as root.
  - `iproute2`: Includes the `ip` command for managing interfaces.

```bash
if ! id -u testuser >/dev/null 2>&1; then
  adduser -D testuser
  echo "testuser:testpass" | chpasswd
  addgroup testuser wheel
fi
```
- This block:
  - Checks if `testuser` already exists.
  - If not, it creates the user with a default password.
  - Adds the user to the `wheel` group.

```bash
echo '%wheel ALL=(ALL) ALL' > /etc/sudoers.d/wheel
chmod 0440 /etc/sudoers.d/wheel
```
- Grants `sudo` permissions to all users in the `wheel` group.
- This allows `testuser` to run privileged commands.

```bash
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
```
- **`sed`**:
  - A stream editor for text manipulation.
  - These commands enable password login for SSH by editing the SSH config file.

```bash
ssh-keygen -A
```
- Generates all the necessary host keys for SSH to function.

```bash
ip addr add "${IP_ADDR}/${CIDR_MASK}" dev eth1
ip link set eth0 up
```
- Assigns a static IP to the secondary interface `eth1`.
- Brings up the default interface `eth0`.

```bash
mkdir -p /var/run/sshd
exec /usr/sbin/sshd -D
```
- **`exec /usr/sbin/sshd -D`**:
  - Replaces the current shell with the SSH server.
  - `-D` keeps SSH running in the foreground so the container stays alive.

### 📁 File location:
Save this as:
```
./servers/external-node/config.external-node.sh
```
Option 1: Make it executable:
```bash
chmod +x ./servers/external-node/config.external-node.sh
```
Option 2: ensure that you use sh in the yml file
```bash
exec:
    - sh /config/config.switch.sh
```

---

## Part 3: Deploy and Test

### 🏗 Step 3: Deploy the Topology
Run the following:
```bash
containerlab deploy -t alpine-dual-net.yml --reconfigure
```

NOTE: if this fails and you get weird errors about the file already existing or proc/something/something not found 

```bash
containerlab destroy --all 
sudo docker image prune -a -f

# if that doens't work, try this
docker stop $(docker ps -q)
```

### 🔌 Step 4: Connect via SSH
Once deployed, test access with:
```bash
ssh testuser@localhost -p 2222
```
Password: `testpass`

---

## ✅ Recap and Check

If all three are true, you’ve successfully built and configured an external Alpine node in Containerlab.

