# Bash Script to Reset and Create a Secure User Environment

## Learning Intentions

* By the end of this tutorial, students will be able to:
* Understand how to write and run a basic Bash script
* Use terminal commands to manage users, groups, files, and permissions
* Apply step-by-step logic to automate system setup tasks
* Practice safe scripting practices using set -euo pipefail
* Interpret and assign file ownership and permissions using chown and chmod

## Success Criteria 

Students will be successful when they can:

* Create and execute a Bash script without syntax errors
* Successfully delete and recreate a user, group, and home directory
* Secure a home directory with correct ownership with `-rwxr-x---` permissions
* Create a secret.flag file with custom content
* Assign file permissions using symbolic notation to provide `-rw-r----` permissions
* Verify the results using ls -l and explain what each column means

---

## Step 1: Understand What the Script Will Do

This script will:

1. Remove a user, group, home directory, and flag file
2. Create a new system user and group
3. Set correct ownership and permissions on the home directory
4. Create a file called `secret.flag`
5. Set ownership and symbolic permissions (`-rw-r-----`) on that file

---

## Step 2: Create the Script File

In your terminal:

```bash
nano reset_and_setup.sh
```

This command opens a new file named `reset_and_setup.sh` using the `nano` text editor.

---

## Step 3: Write the Script Line by Line

Follow the instructions below to build the script. Type each line carefully and press `Enter` after each one.

### 3.1: Start with the script header

```bash
#!/usr/bin/env bash
```

This tells the system to use the Bash interpreter.

### 3.2: Add safe execution options

```bash
set -euo pipefail
IFS=$'\n\t'
```

These settings make your script safer and more predictable.

### 3.3: Define your variables

```bash
NEW_USER="bushranger"
NEW_GROUP="bushrangers"
HOME_DIR="/home/$NEW_USER"
FLAG_FILE="secret.flag"
FLAG_CONTENT="foo"
RUNNER="$USER"
```

These variables let you reuse values later without repeating yourself.

### 3.4: Remove any previous setup

```bash
sudo rm -f "$HOME_DIR/$FLAG_FILE"
sudo rm -rf "$HOME_DIR"
sudo userdel "$NEW_USER"
sudo groupdel "$NEW_GROUP"
```

This section clears out old users, groups, and files.

### 3.5: Create a new user and group

```bash
sudo groupadd "$NEW_GROUP"
sudo useradd -m -g "$NEW_GROUP" -s /bin/bash "$NEW_USER"
```

This makes sure the new user and group exist and that the user has a home folder.

### 3.6: Secure the home directory

```bash
sudo chown -R "$RUNNER:$NEW_GROUP" "$HOME_DIR"
sudo chmod u=rwx,g=rx,o= "$HOME_DIR"
```

These lines set correct ownership and limit who can access the directory.

### 3.7: Create the flag file

```bash
echo "$FLAG_CONTENT" | sudo tee "$HOME_DIR/$FLAG_FILE" >/dev/null
```

This creates a file named `secret.flag` and adds a short message inside.

### 3.8: Set ownership and permissions for the flag file

```bash
sudo chown "$RUNNER:$NEW_USER" "$HOME_DIR/$FLAG_FILE"
chmod u=rw,g=r,o= "$HOME_DIR/$FLAG_FILE"
```

This makes sure only the correct people can read or modify the file.

When you're done typing, save and exit:

* Press `Ctrl + O` to save
* Press `Enter` to confirm the filename
* Press `Ctrl + X` to exit the editor

---

## Step 4: Make the Script Executable

In your terminal, run:

```bash
chmod +x reset_and_setup.sh
```

This gives permission to run the file as a program.

---

## Step 5: Run the Script

Now run the script:

```bash
./reset_and_setup.sh
```

You may be asked to enter your password to allow `sudo` commands to run.

---

## Step 6: Check the Results

After the script finishes, verify the setup using:

```bash
ls -ld /home/bushranger
ls -l /home/bushranger/secret.flag
```

Expected output:

```
drwxr-x---  RUNNER  bushrangers  ... /home/bushranger
-rw-r-----  RUNNER  bushranger   ... /home/bushranger/secret.flag
```


