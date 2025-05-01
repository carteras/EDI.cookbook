# Bash Script to Reset, Create User, Secure Home, and Manage `secret.flag`  

## Overview

This enhanced Bash script will **reset** any previous configuration, then:

1. Remove the old user, group, home, and flag.  
2. Create a new system user and group.  
3. Secure the user’s home directory with specific ownership and permissions.  
4. Create and initialize `secret.flag`.  
5. Set file ownership to the script runner and the new user’s group.  
6. Apply symbolic permissions equivalent to `0640`.

**Justification:** Cleaning up ensures that rerunning the script leaves no leftover artifacts or conflicting settings, making it idempotent and safe for repeated use.

---

## Prerequisites

- A terminal with `sudo` privileges.  
- Familiarity with `useradd`, `groupadd`, `userdel`, `groupdel`, `rm`, `chown`, `chmod`, and `echo`.

---

## 1. Create the Script File

```bash
nano reset_and_setup.sh
```

At the top, add:

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'
```  

- `set -euo pipefail` makes the script exit on errors, undefined variables, or pipeline failures.  
- `IFS` prevents word-splitting issues.

---

## 2. Define Variables

Below the shebang, include:

```bash
# Configuration
NEW_USER="bushranger"
NEW_GROUP="bushrangers"
HOME_DIR="/home/$NEW_USER"
FLAG_FILE="secret.flag"
FLAG_CONTENT="foo"
RUNNER="$USER"
```  

- Defining variables once makes maintenance easier.

---

## 3. Clean Up Previous Configuration

Append:

```bash
# Remove flag file if exists
if [ -f "$HOME_DIR/$FLAG_FILE" ]; then
  echo "Removing old flag: $HOME_DIR/$FLAG_FILE"
  sudo rm -f "$HOME_DIR/$FLAG_FILE"
fi

# Remove home directory if exists
if [ -d "$HOME_DIR" ]; then
  echo "Deleting old home directory: $HOME_DIR"
  sudo rm -rf "$HOME_DIR"
fi

# Delete user if exists
if id "$NEW_USER" >/dev/null 2>&1; then
  echo "Deleting user: $NEW_USER"
  sudo userdel "$NEW_USER"
fi

# Delete group if exists
if getent group "$NEW_GROUP" >/dev/null; then
  echo "Deleting group: $NEW_GROUP"
  sudo groupdel "$NEW_GROUP"
fi
```  

- **Justification:** Ensures no leftover files, directories, or accounts conflict with our fresh setup.

---

## 4. Create User and Group

Append:

```bash
# Create group
echo "Creating group: $NEW_GROUP"
sudo groupadd "$NEW_GROUP"

# Create user with home directory
echo "Creating user: $NEW_USER"
sudo useradd -m -g "$NEW_GROUP" -s /bin/bash "$NEW_USER"
```  

- `-m` guarantees a fresh home directory.  
- **Justification:** Explicit group creation avoids relying on defaults and clarifies intent.

---

## 5. Secure the User’s Home Directory

Append:

```bash
# Set ownership to runner and group
echo "Chowning $HOME_DIR to $RUNNER:$NEW_GROUP"
sudo chown -R "$RUNNER":"$NEW_GROUP" "$HOME_DIR"

# Directory permissions: runner rwx, group rx, others none
echo "Setting home directory perms to u=rwx,g=rx,o="
sudo chmod u=rwx,g=rx,o= "$HOME_DIR"
```  

- **Justification:** `u=rwx,g=rx,o=` (`750`) allows the runner full control, group read/execute, and denies others.

---

## 6. Create and Initialize `secret.flag`

Append:

```bash
# Create flag file with runner as owner
echo "Creating flag file: $FLAG_FILE"
echo "$FLAG_CONTENT" | sudo tee "$HOME_DIR/$FLAG_FILE" >/dev/null
```  

- Using `tee` with `sudo` writes as root, preserving permissions.  
- **Justification:** Simplifies writing and avoids switching user context.

---

## 7. Set File Ownership and Permissions

Append:

```bash
# Change owner to runner, group to new user
echo "Chowning flag to $RUNNER:$NEW_USER"
sudo chown "$RUNNER":"$NEW_USER" "$HOME_DIR/$FLAG_FILE"

# Symbolic chmod for 0640: u=rw, g=r, o=
echo "Setting flag perms to u=rw,g=r,o="
chmod u=rw,g=r,o= "$HOME_DIR/$FLAG_FILE"
```  

- **Justification:** Symbolic mode clearly communicates intent and can be combined with other flags.

---

## 8. Make the Script Executable and Run

Save and exit. Then:

```bash
chmod +x reset_and_setup.sh
./reset_and_setup.sh
```  

- No arguments needed; fully automated.

---

## 9. Verification

```bash
ls -ld "$HOME_DIR"
ls -l "$HOME_DIR/$FLAG_FILE"
```  

- Home dir: `drwxr-x--- RUNNER NEW_GROUP`  
- Flag file: `-rw-r----- RUNNER NEW_USER`

---

## Full Script

```bash
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Configuration
NEW_USER="bushranger"
NEW_GROUP="bushrangers"
HOME_DIR="/home/$NEW_USER"
FLAG_FILE="secret.flag"
FLAG_CONTENT="foo"
RUNNER="$USER"

# 3. Clean up previous setup
if [ -f "$HOME_DIR/$FLAG_FILE" ]; then
  echo "Removing old flag: $HOME_DIR/$FLAG_FILE"
  sudo rm -f "$HOME_DIR/$FLAG_FILE"
fi
if [ -d "$HOME_DIR" ]; then
  echo "Deleting old home directory: $HOME_DIR"
  sudo rm -rf "$HOME_DIR"
fi
if id "$NEW_USER" >/dev/null 2>&1; then
  echo "Deleting user: $NEW_USER"
  sudo userdel "$NEW_USER"
fi
if getent group "$NEW_GROUP" >/dev/null; then
  echo "Deleting group: $NEW_GROUP"
  sudo groupdel "$NEW_GROUP"
fi

# 4. Create group and user
echo "Creating group: $NEW_GROUP"
sudo groupadd "$NEW_GROUP"

echo "Creating user: $NEW_USER"
sudo useradd -m -g "$NEW_GROUP" -s /bin/bash "$NEW_USER"

# 5. Secure home directory
echo "Chowning $HOME_DIR to $RUNNER:$NEW_GROUP"
sudo chown -R "$RUNNER":"$NEW_GROUP" "$HOME_DIR"

echo "Setting home directory perms to u=rwx,g=rx,o="
sudo chmod u=rwx,g=rx,o= "$HOME_DIR"

# 6. Create and initialize secret.flag
echo "Creating flag file: $FLAG_FILE"
echo "$FLAG_CONTENT" | sudo tee "$HOME_DIR/$FLAG_FILE" >/dev/null

# 7. Set flag ownership and perms
echo "Chowning flag to $RUNNER:$NEW_USER"
sudo chown "$RUNNER":"$NEW_USER" "$HOME_DIR/$FLAG_FILE"

echo "Setting flag perms to u=rw,g=r,o="
chmod u=rw,g=r,o= "$HOME_DIR/$FLAG_FILE"
```
