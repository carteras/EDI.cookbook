**Bash Script to Create User, Secure Home, and Manage `secret.flag`**  

## Overview
This Bash script will perform the following tasks:
1. Create a new system user and group.  
2. Secure the user’s home directory with specific ownership and permissions.  
3. Create and initialize a file called `secret.flag`.  
4. Set file ownership to the script runner and the new user’s group.  
5. Apply symbolic permissions equivalent to `0640`.

You run the script **without arguments**; it defines its own user and group names internally.

---

## Prerequisites
- A terminal with `sudo` access.  
- Basic familiarity with `useradd`, `groupadd`, `chown`, `chmod`, and `echo`.

---

## 1. Create the Script File
```bash
nano setup_user_and_flag.sh
```
At the top, add:
```bash
#!/usr/bin/env bash
set -e
```  
- `set -e` stops the script if any command fails.

---

## 2. Define Variables
Below the shebang, include:
```bash
# Define new user and group\NEW_USER="bushranger"
NEW_GROUP="bushrangers"

# File settings
FLAG_FILE="secret.flag"
FLAG_CONTENT="foo"

# Script runner (current user)
RUNNER="$USER"
```

---

## 3. Create User and Group
Append:
```bash
# Create group if it doesn't exist
if ! getent group "$NEW_GROUP" >/dev/null; then
  echo "Creating group: $NEW_GROUP"
  sudo groupadd "$NEW_GROUP"
fi

# Create user with home directory and assign to group
if ! id "$NEW_USER" >/dev/null 2>&1; then
  echo "Creating user: $NEW_USER"
  sudo useradd -m -g "$NEW_GROUP" -s /bin/bash "$NEW_USER"
fi
```  
- `-m` creates the home directory `/home/bushranger`.
- `-g` sets the primary group.

---

## 4. Secure the User’s Home Directory
Append:
```bash
# Change ownership of home and all contents to script runner
echo "Chowning /home/$NEW_USER to $RUNNER:$NEW_GROUP"
sudo chown -R "$RUNNER":"$NEW_GROUP" "/home/$NEW_USER"

# Set directory perms: runner full, group rx, others none
echo "Setting home dir permissions"
sudo chmod u=rwx,g=rx,o= "/home/$NEW_USER"

# Ensure new files inside home allow group read by default
echo "Setting default umask for $NEW_USER"
# This requires editing /etc/profile or the user's shell rc; demonstration only
# sudo sed -i "/^umask /c\umask 027" "/home/$NEW_USER/.profile"
```  
- `chmod u=rwx,g=rx,o=` yields `750` on the directory.  
- Default `umask 027` ensures new files are `640` (group read).

---

## 5. Create and Initialize `secret.flag`
Append:
```bash
# Switch to the user’s home directory
echo "Creating flag file: $FLAG_FILE"
sudo -u "$NEW_USER" bash -c "echo '$FLAG_CONTENT' > /home/$NEW_USER/$FLAG_FILE"
```  
- Runs as the new user to place the file in their home.

---

## 6. Set File Ownership and Permissions
Append:
```bash
# Change owner to runner, group to new user
echo "Chowning flag file to $RUNNER:$NEW_USER"
sudo chown "$RUNNER":"$NEW_USER" "/home/$NEW_USER/$FLAG_FILE"

# Use symbolic mode to set 0640: owner rw, group r, others none
echo "Setting flag file perms to u=rw,g=r,o="
chmod u=rw,g=r,o= "/home/$NEW_USER/$FLAG_FILE"
```  
- Symbolic `u=rw,g=r,o=` matches numeric `0640`.

---

## 7. Final Script and Execution
Save and exit, then:
```bash
chmod +x setup_user_and_flag.sh
./setup_user_and_flag.sh
```  
- No arguments needed.  

After running, verify:
```bash
ls -ld /home/$NEW_USER
ls -l /home/$NEW_USER/$FLAG_FILE
```  
- Home directory should be `drwxr-x--- RUNNER NEW_GROUP`.  
- Flag file should be `-rw-r----- RUNNER NEW_USER`.

---

## Full Script
```bash
#!/usr/bin/env bash
set -e

# Variables
NEW_USER="bushranger"
NEW_GROUP="bushrangers"
FLAG_FILE="secret.flag"
FLAG_CONTENT="foo"
RUNNER="$USER"

# 1. Create group
if ! getent group "$NEW_GROUP" >/dev/null; then
  echo "Creating group: $NEW_GROUP"
  sudo groupadd "$NEW_GROUP"
fi

# 2. Create user
if ! id "$NEW_USER" >/dev/null 2>&1; then
  echo "Creating user: $NEW_USER"
  sudo useradd -m -g "$NEW_GROUP" -s /bin/bash "$NEW_USER"
fi

# 3. Secure home directory
echo "Chowning /home/$NEW_USER to $RUNNER:$NEW_GROUP"
sudo chown -R "$RUNNER":"$NEW_GROUP" "/home/$NEW_USER"

echo "Setting home dir permissions"
sudo chmod u=rwx,g=rx,o= "/home/$NEW_USER"

# (Optional) Set default umask for new files
# echo "Setting default umask"
# sudo sed -i "/^umask /c\umask 027" "/home/$NEW_USER/.profile"

# 4. Create and initialize secret.flag
echo "Creating flag file: $FLAG_FILE"
sudo -u "$NEW_USER" bash -c "echo '$FLAG_CONTENT' > /home/$NEW_USER/$FLAG_FILE"

# 5. Set flag file owner and perms
echo "Chowning flag file to $RUNNER:$NEW_USER"
sudo chown "$RUNNER":"$NEW_USER" "/home/$NEW_USER/$FLAG_FILE"

echo "Setting flag file perms to u=rw,g=r,o="
chmod u=rw,g=r,o= "/home/$NEW_USER/$FLAG_FILE"
```

