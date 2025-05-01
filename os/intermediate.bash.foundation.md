# Writing a Bash Script to Create, Populate, and Secure a Text File

## Overview

In this tutorial, you will:

1. Write a simple Bash script that:
   - Creates a new text file.  
   - Writes (echoes) specified text into it.  
   - Changes its owner and group.  
   - Sets strict permissions (`u+rw,g-rwx,o-rwx`).  
2. Run and verify the script.

---

## Script Requirements

- **Filename to create:** defined in variables (e.g., `FILENAME`).  
- **Text to insert:** defined in a variable (`CONTENT`).  
- **Target user:** defined (`TARGET_USER`).  
- **Target group:** defined (`TARGET_GROUP`).  
- **Final permissions:** owner read/write; group and others no permissions.

---

## 1. Create the Script File

1. Open your editor (nano, vim, etc.):

   ```bash
   nano create_secure_file.sh
   ```

2. At the top, add the shebang line:

   ```bash
   #!/usr/bin/env bash
   ```

---

## 2. Define Variables

Add the following lines below the shebang:

```bash
# Variables
FILENAME="secret.flag"
CONTENT="This is a secure file created by script"
TARGET_USER="alice"    # replace with your target user
TARGET_GROUP="staff"   # replace with your target group
```  

- **Modify** `alice` and `staff` to the desired user and group on your system.

---

## 3. Create and Populate the File

Append these lines to the script:

```bash
# Create or overwrite file and add content
echo "$CONTENT" > "$FILENAME"
```  

- The `>` operator creates (or truncates) the file and writes the content.

---

## 4. Change Owner and Group

Append:

```bash
# Change ownership
echo "Setting owner to $TARGET_USER and group to $TARGET_GROUP"
sudo chown "$TARGET_USER:$TARGET_GROUP" "$FILENAME"
```  

- `sudo` may prompt for your password.

---

## 5. Set Permissions

Append:

```bash
# Restrict permissions: owner read/write; no access for group/others
echo "Setting permissions to u+rw,g-rwx,o-rwx"
chmod u=rw,go= "$FILENAME"
```  

- Alternatively, you can use numeric mode: `chmod 600 "$FILENAME"`.

---

## 6. Make the Script Executable

Save and exit. Then:

```bash
chmod +x create_secure_file.sh
```  

- The `+x` flag makes the script runnable.

---

## 7. Run and Verify

1. Execute the script:

   ```bash
   ./create_secure_file.sh
   ```

2. Inspect file ownership and permissions:

   ```bash
   ls -l "$FILENAME"
   ```

   Expected output:

   ```text
   -rw------- 1 alice staff XX Mar 10 10:00 secret.flag
   ```

   - `-rw-------` means **owner** has read/write, **group/others** have no permissions.

---

## 8. Practice and Customization

- Try changing `TARGET_USER` and `TARGET_GROUP` to other users/groups.  
- Experiment with different permission sets (e.g., `u=rwx,g=rx,o=`).  
- Add error checking: verify that `useradd` exists or that the user/group is valid.

---

**Congratulations!** You’ve automated file creation, ownership change, and permission setting using Bash.

---

## Full Script

```bash
#!/usr/bin/env bash

# Variables
FILENAME="secret.flag"
CONTENT="This is a secure file created by script"
TARGET_USER="alice"    # replace with your target user
TARGET_GROUP="staff"   # replace with your target group

# Create or overwrite file and add content
echo "$CONTENT" > "$FILENAME"

# Change ownership
echo "Setting owner to $TARGET_USER and group to $TARGET_GROUP"
sudo chown "$TARGET_USER:$TARGET_GROUP" "$FILENAME"

# Restrict permissions: owner read/write; no access for group/others
echo "Setting permissions to u+rw,g-rwx,o-rwx"
chmod u=rw,go= "$FILENAME"
```
