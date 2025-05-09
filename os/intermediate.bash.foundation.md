# Writing a Bash Script to Safely Create, Populate, and Secure a File on Fedora Server

## Overview

In this tutorial, you will:

1. Write a Bash script that:

   * Removes a user (if they exist).
   * Creates the user and sets a password.
   * Creates a secure text file in their home directory.
   * Sets specific ownership and permission rules.

---

## Script Requirements

* **Filename to create:** defined in `FILENAME`.
* **Text to insert:** stored in `CONTENT`.
* **Target user & group:** created in the script.
* **Final ownership:** file owned by `OWNER_USER:$TARGET_GROUP`.
* **Permissions:**

  * Directory: `u+rwx`, `g+rx`, `o-rwx`
  * File: readable/writable by owner, readable by group, no access to others

---

## 1. Create the Script File

Open your text editor:

```bash
nano create_secure_file.sh
```

Add the shebang line:

```bash
#!/bin/bash
set -x
```

The `set -x` enables debugging output during script execution.

---

## 2. Define Variables

Below the shebang, define the required variables:

```bash
FILENAME="secret.flag"
CONTENT="MY_SECRET_FLAG"
OWNER_USER="adam"
TARGET_USER="bushranger.000"
TARGET_GROUP="bushranger.000"
```

---

## 3. Remove Existing User (if present)

Append the following line to safely remove the user:

```bash
echo "Removing $TARGET_USER from system"
sudo userdel --remove "$TARGET_USER" 2>/dev/null
```

* The `2>/dev/null` hides errors if the user doesn’t exist.

---

## 4. Create the User and Set a Password

Add:

```bash
echo "Adding $TARGET_USER to the system"
sudo useradd "$TARGET_USER"

echo "Changing password"
echo "$TARGET_USER:$TARGET_USER" | sudo chpasswd
```

---

## 5. Secure the User’s Home Directory

```bash
echo "Setting ownership and permissions on home directory"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/"
sudo chmod ugo-rwx "/home/$TARGET_USER/"
sudo chmod u+rwx,g+rx "/home/$TARGET_USER/"
```

* These commands restrict access to others while allowing the group to read/execute (e.g., `cd` into the directory).

---

## 6. Create and Populate the File

Now safely create and secure the target file:

```bash
touch "/home/$TARGET_USER/$FILENAME"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/$FILENAME"
sudo chmod u+rw,g+r,o-rwx "/home/$TARGET_USER/$FILENAME"
echo "$CONTENT" > "/home/$TARGET_USER/$FILENAME"
```

---

## 7. Make the Script Executable

Save and exit the editor, then run:

```bash
chmod +x create_secure_file.sh
```

---

## 8. Run and Verify

Execute the script:

```bash
./create_secure_file.sh
```

Then verify file and directory permissions:

```bash
ls -ld "/home/$TARGET_USER"
ls -l "/home/$TARGET_USER/$FILENAME"
```

You should see something like:

```bash
drwxr-x--- 2 adam bushranger.000 ... /home/bushranger.000
-rw-r----- 1 adam bushranger.000 ... /home/bushranger.000/secret.flag


```bash
#!/bin/bash
set -x

FILENAME="secret.flag"
CONTENT="MY_SECRET_FLAG"
OWNER_USER="adam"
TARGET_USER="bushranger.000"
TARGET_GROUP="bushranger.000"

echo "Removing $TARGET_USER from system"
sudo userdel --remove "$TARGET_USER" 2>/dev/null

echo "Adding $TARGET_USER to the system"
sudo useradd "$TARGET_USER"

echo "Changing password"
echo "$TARGET_USER:$TARGET_USER" | sudo chpasswd

echo "Setting ownership and permissions on home directory"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/"
sudo chmod ugo-rwx "/home/$TARGET_USER/"
sudo chmod u+rwx,g+rx "/home/$TARGET_USER/"

touch "/home/$TARGET_USER/$FILENAME"
sudo chown "$OWNER_USER:$TARGET_GROUP" "/home/$TARGET_USER/$FILENAME"
sudo chmod u+rw,g+r,o-rwx "/home/$TARGET_USER/$FILENAME"
echo "$CONTENT" > "/home/$TARGET_USER/$FILENAME"
```