# Writing a Bash Script to Create, Populate, and Secure a Text File (with Arguments)

---

## Overview

This script will:

1. Create a new text file.  
2. Write specified text into it.  
3. Change its owner and group (provided as arguments).  
4. Set strict permissions (`u+rw,g-rwx,o-rwx`).

You will supply the **username** and **group** when running the script.

---

## Prerequisites

- Terminal with `sudo` access.  
- Basic commands: `ls`, `chmod`, `chown`.

---

## 1. Create the Script File

Open your preferred editor and name the file:

```bash
nano create_secure_file.sh
```

Add the shebang at the top:

```bash
#!/usr/bin/env bash
```

---

## 2. Parse Arguments and Define Variables

Below the shebang, add:

```bash
# Check for two arguments: user and group
if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <group>"
  exit 1
fi

TARGET_USER="$1"
TARGET_GROUP="$2"
FILENAME="secret.flag"
CONTENT="This is a secure file created by script"
```  

- `$0` is the script name; `$1` and `$2` are the user and group you pass in.
- The script exits with an error if you don’t supply exactly two arguments.

---

## 3. Create and Populate the File

Append:

```bash
# Create or overwrite file and add content
echo "$CONTENT" > "$FILENAME"
echo "Created $FILENAME with content."
```

---

## 4. Change Owner and Group

Append:

```bash
# Change ownership
echo "Setting owner to $TARGET_USER and group to $TARGET_GROUP"
sudo chown "$TARGET_USER:$TARGET_GROUP" "$FILENAME"
```  

- You will be prompted for your password if needed.

---

## 5. Set Permissions

Append:

```bash
# Restrict permissions: owner read/write; no access for group/others
echo "Setting permissions to u+rw,g-rwx,o-rwx"
chmod u=rw,go= "$FILENAME"
```  

---

## 6. Make the Script Executable

Save and exit. Then run:

```bash
chmod +x create_secure_file.sh
```

---

## 7. Run and Verify

1. Execute with arguments:

   ```bash
   ./create_secure_file.sh alice staff
   ```

2. Check file details:

   ```bash
   ls -l "$FILENAME"
   ```

   Expected output:

   ```text
   -rw------- 1 alice staff XX Mar 10 10:00 secret.flag
   ```

---

## 8. Full Script

```bash
#!/usr/bin/env bash

# Check for two arguments: user and group
if [ $# -ne 2 ]; then
  echo "Usage: $0 <username> <group>"
  exit 1
fi

TARGET_USER="$1"
TARGET_GROUP="$2"
FILENAME="secret.flag"
CONTENT="This is a secure file created by script"

# Create or overwrite file and add content
echo "$CONTENT" > "$FILENAME"
echo "Created $FILENAME with content."

# Change ownership
echo "Setting owner to $TARGET_USER and group to $TARGET_GROUP"
sudo chown "$TARGET_USER:$TARGET_GROUP" "$FILENAME"

# Restrict permissions: owner read/write; no access for group/others
echo "Setting permissions to u+rw,g-rwx,o-rwx"
chmod u=rw,go= "$FILENAME"
```
