# Changing File Permissions with `chmod`

## Overview

Linux files have **permissions** that control who can read, write, or execute them. The `chmod` command changes these permissions. This tutorial covers both **symbolic** (e.g., `u+rwx`) and **numeric** (e.g., `754`) modes.

---

## What You Need

- Terminal and basic navigation.  
- Ability to list detailed files with `ls -l`.  
- `sudo` access for system files (optional).

---

## Understanding File Permissions

When you run `ls -l`, you see:  

```
-rwxr-x--- 1 alice staff 120 May 01 15:00 script.sh
```

- The first 10 characters show permissions: `-rwxr-x---`
  - `r` = read, `w` = write, `x` = execute, `-` = none.  
  - Positions 1–3 = **user** (owner) perms (`rwx`).  
  - 4–6 = **group** perms (`r-x`).  
  - 7–9 = **others** perms (`---`).

---

## Viewing Current Permissions

1. In terminal, run:  

   ```bash
   ls -l example.txt
   ```

2. Note the three permission sets: user, group, others.

---

## Symbolic Mode (`[ugoa][+-=][rwx]`)

- **Classes**:  
  - `u` = user (owner)  
  - `g` = group  
  - `o` = others  
  - `a` = all (u, g, o)
- **Operators**:  
  - `+` add permission  
  - `-` remove permission  
  - `=` set exact permission (clears unspecified bits)

### Examples

1. **Add execute for user**:  

   ```bash
   chmod u+x script.sh
   ```

2. **Remove write for group**:  

   ```bash
   chmod g-w data.csv
   ```

3. **Give read to all**:  

   ```bash
   chmod a+r notes.txt
   ```

4. **Set user to read+write, group to read, others none**:  

   ```bash
   chmod u=rw,g=r,o= file.txt
   ```

---

## Numeric Mode (`[0-7][0-7][0-7]`)

Each digit = sum of permissions:  

- `4` = read (r)  
- `2` = write (w)  
- `1` = execute (x)  
- `0` = none

Order: **user**, **group**, **others**.  

### Examples

1. **Owner rwx, group r-x, others ---** = `750`:  

   ```bash
   chmod 750 script.sh
   ```

2. **Owner rw-, group r--, others r--** = `644`:  

   ```bash
   chmod 644 report.pdf
   ```

---

## Setting Permissions Recursively

To change permissions on a directory and **all its contents**, add `-R`:  

```bash
chmod -R  u=rwx,go=  private_folder/
```  

This example gives only the owner full rights and removes group/others access.

---

## Practice Tasks

1. Create files and list perms:  

   ```bash
   touch fileA.sh fileB.txt
   ls -l fileA.sh fileB.txt
   ```

2. Add execute perm for owner on `fileA.sh`:  

   ```bash
   chmod u+x fileA.sh
   ```

3. Remove read for others on `fileB.txt`:  

   ```bash
   chmod o-r fileB.txt
   ```

4. Set exact perms: owner `rw-`, group `r--`, others `---` on `fileB.txt`:  

   ```bash
   chmod u=rw,g=r,o= fileB.txt
   ```

5. Using numeric mode, set `fileA.sh` to `755`:  

   ```bash
   chmod 755 fileA.sh
   ```

---

## Tips & Errors

- **Common mistake**: forgetting to specify class (`u`, `g`, `o`, `a`)—will default to `a` if you omit.  
- **Permission denied**: you need `sudo` for protected files:  

  ```bash
  sudo chmod 640 /etc/secret.conf
  ```

---

**Explore further**: Check `man chmod` for special bits (setuid, setgid, sticky) once you’re comfortable with basic modes.
