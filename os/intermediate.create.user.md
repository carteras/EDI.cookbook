**Adding a User to Linux with `useradd` and `adduser`**  


## Overview
Linux provides two main commands to create new user accounts:
- **`useradd`**: A low-level utility available on most distributions.  
- **`adduser`**: A friendlier, high-level script (Debian/Ubuntu) that calls `useradd` with sensible defaults.

This tutorial shows how to add a user named **bushranger** using both commands.

---

## Prerequisites
- A terminal with `sudo` privileges.  
- Familiarity with basic commands (`ls`, `passwd`).

---

## Using `useradd`
1. **Create the user:**  
   ```bash
   sudo useradd bushranger
   ```
   - This adds an account **bushranger** with no password and default home directory.

2. **Set a password:**  
   ```bash
   sudo passwd bushranger
   ```
   - Enter and confirm a secure password when prompted.

3. **Verify account creation:**  
   ```bash
   getent passwd bushranger
   ```
   Output sample:
   ```
   bushranger:x:1001:1001::/home/bushranger:/bin/bash
   ```
   - Shows UID, GID, home directory, and default shell.

4. **Create the home directory (if needed):**  
   ```bash
   sudo mkdir -p /home/bushranger
   sudo chown bushranger:bushranger /home/bushranger
   ```

5. **Assign to a group (optional):**  
   - To add **bushranger** to group `sudo`:
     ```bash
     sudo usermod -aG sudo bushranger
     ```

---

## Using `adduser` (Debian/Ubuntu)
1. **Create the user and home directory:**  
   ```bash
   sudo adduser bushranger
   ```
   - The script prompts for password, full name, and other details.
   - Automatically creates `/home/bushranger` and sets ownership.

2. **Add to additional groups:**  
   ```bash
   sudo adduser bushranger sudo
   ```
   - No `-aG` needed; `adduser` handles group appending.

---

## Summary of Differences
| Feature            | `useradd`                | `adduser`                   |
|--------------------|--------------------------|-----------------------------|
| Home directory     | Not created by default¹  | Created automatically       |
| Interactive prompts| No                       | Yes (password, info fields) |
| Group management   | `usermod -aG` required   | `adduser user group`        |

¹ On some distros, `/etc/default/useradd` may enable home creation.

---

## Practice Tasks
1. **Using `useradd`:**
   - Create `bushranger2`, set a password, make its home, and add to `sudo`.
2. **Using `adduser`:**
   - Create `bushranger3` and add to group `staff`.
3. **Verify all users:**
   ```bash
   getent passwd bushranger bushranger2 bushranger3
   ```

---

## Tips & Troubleshooting
- **`useradd` errors:** If `useradd` says `user exists`, pick a different username.  
- **Password issues:** If `passwd` refuses weak passwords, choose stronger ones or adjust `/etc/pam.d/common-password` policies.  
- **No `adduser`?** Use `useradd` on distributions without `adduser`.

---

**Explore further:** Check `man useradd`, `man adduser`, and `man usermod` for advanced options (e.g., setting expiration dates, shells, or custom skeleton files).

