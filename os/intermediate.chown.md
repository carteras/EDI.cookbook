**Changing File Ownership with `chown`**  

## Overview
In Linux, every file and directory has an **owner** and a **group**. The `chown` command lets you change who owns a file or which group it belongs to. This tutorial will guide you through the essential steps to view and modify ownership.

---

## What You Need
- A terminal and basic command-line navigation skills.  
- Ability to list files with `ls -l`.  
- `sudo` access to change ownership on files you don’t own.

---

## Viewing Current Ownership
1. Open a terminal.  
2. Run:
   ```bash
   ls -l example.txt
   ```
3. Read the owner and group columns:
   ```
   -rw-r--r-- 1 alice staff 120 Apr 30 12:00 example.txt
   ```
   - **Owner:** `alice`  
   - **Group:** `staff`

---

## Changing the Owner
1. To set a new owner, use:
   ```bash
   sudo chown newuser example.txt
   ```
2. Confirm with:
   ```bash
   ls -l example.txt
   ```
3. You should see:
   ```
   -rw-r--r-- 1 newuser staff 120 Apr 30 12:05 example.txt
   ```

---

## Changing Owner and Group Together
1. Use this format:
   ```bash
   sudo chown username:groupname example.txt
   ```
2. Verify:
   ```bash
   ls -l example.txt
   ```
   ```
   -rw-r--r-- 1 username groupname 120 Apr 30 12:10 example.txt
   ```

---

## Working with Directories
- **Single folder only:**
  ```bash
  sudo chown alice:staff project_folder/
  ```
- **Include all contents:** Add `-R` for recursive changes:
  ```bash
  sudo chown -R alice:staff project_folder/
  ```

---

## Common Errors
- **Permission denied:**
  ```
  chown: changing ownership of 'file': Operation not permitted
  ```
  → You need `sudo` or root privileges.

---

## Practice Tasks
Try these on your machine:
1. Create two files:
   ```bash
   touch file1.txt file2.txt
   ls -l file1.txt file2.txt
   ```
2. Change the owner of `file1.txt` to your username:
   ```bash
   sudo chown $(whoami) file1.txt
   ```
3. Change both owner and group of `file2.txt` to one of your groups:
   ```bash
   sudo chown $(whoami):$(groups | awk '{print $1}') file2.txt
   ```
4. Verify each change with `ls -l`.

---

## Next Steps
Feel free to explore other flags in `man chown`, such as `--from` to change only when the current owner matches a given name. Always double-check with `ls -l` after making changes.

