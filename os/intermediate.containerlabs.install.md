# Installing Containerlab on Fedora Server 42

---

## Overview

Containerlab is a tool for deploying virtual network topologies using container runtimes. In Fedora Server 42, we'll install **containerd** + **nerdctl** as the container backend, then install Containerlab itself.

---

## Prerequisites

- A Fedora Server 42 system with root or `sudo` access.  
- Basic familiarity with the shell (`dnf`, `systemctl`, `curl`).

---

## 1. Update Your System

Always start by updating installed packages:

```bash
sudo dnf update -y
```

---

## 2. Install Required Tools

Install Git, curl, and jq for downloads and scripting:

```bash
sudo dnf install -y git curl jq
```

---

## 3. Install containerd and nerdctl

Containerlab supports multiple runtimes; we’ll use containerd + nerdctl:

1. **Install containerd**:

   ```bash
   sudo dnf install -y containerd
   ```

2. **Enable and start** containerd:

   ```bash
   sudo systemctl enable --now containerd
   ```

3. **Download and install** nerdctl (CLI for containerd):

   ```bash
   NERDCTL_VERSION="1.5.0"
   curl -fsSL \
     "https://github.com/containerd/nerdctl/releases/download/v${NERDCTL_VERSION}/nerdctl-${NERDCTL_VERSION}-linux-amd64.tar.gz" \
     -o nerdctl.tar.gz
   sudo tar Cxzvf /usr/local/bin nerdctl.tar.gz
   rm nerdctl.tar.gz
   ```

4. **Verify** installation:

   ```bash
   nerdctl --version
   ```

---

## 4. Install Containerlab

Containerlab provides a simple installer script:

```bash
curl -sL https://get.containerlab.dev | sudo bash
```

Check you have the binary:

```bash
containerlab version
```

---

## 5. Ensure Your PATH

Make sure `/usr/local/bin` is in your `PATH`, so you can run Containerlab:

```bash
echo $PATH  # should include /usr/local/bin
```

If not, add it to `/etc/profile.d/containerlab.sh`:

```bash
sudo tee /etc/profile.d/containerlab.sh << 'EOF'
export PATH=
/usr/local/bin:$PATH
EOF
source /etc/profile.d/containerlab.sh
```

---

## 6. Test with a Sample Topology

1. **Create** `basic.clab.yml`:

   ```yaml
   name: clab-test
   nodes:
     r1:
       kind: vr-sros
       image: ghcr.io/srl-labs/containerlab-rr:latest
   ```

2. **Deploy** it:

   ```bash
   containerlab deploy -t basic.clab.yml
   ```

3. **List nodes**:

   ```bash
   containerlab nodes
   ```

4. **Destroy** the lab:

   ```bash
   containerlab destroy -t basic.clab.yml
   ```

---

## 7. Cleanup Tips

- To remove Containerlab binary:

  ```bash
  sudo rm -f /usr/local/bin/containerlab
  ```

- To stop and remove containerd:

  ```bash
  sudo systemctl disable --now containerd
  sudo dnf remove -y containerd
  ```

---

**Congratulations!** You now have Containerlab running on Fedora Server 42.
