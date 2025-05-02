# Changing Another User’s Password with `passwd` and `sudo`

## Overview

The `passwd` command lets you set or change a user’s password. By default, you can only change your own password. With `sudo`, administrators can update **other users’** passwords. This tutorial shows how to:

1. Verify the target user exists.
2. Change a user’s password using `sudo passwd <username>`.
3. Handle common errors.

---

## Prerequisites

* A Linux system with `sudo` privileges.
* Familiarity with opening a terminal and running basic commands.

---

## 1. Verify the Target User Exists

Before changing a password, ensure the account is present:

```bash
getent passwd bushranger
```

* **Output example:**

  ```text
  bushranger:x:1001:1001::/home/bushranger:/bin/bash
  ```
* If no output appears, the user does not exist.

---

## 2. Change the User’s Password

1. Run the `passwd` command with `sudo`:

   ```bash
   sudo passwd bushranger
   ```
2. When prompted:

   * Enter a new UNIX password for **bushranger**.
   * Confirm by typing it again.

**Example session:**

```text
$ sudo passwd bushranger
Enter new UNIX password: ********
Retype new UNIX password: ********
passwd: password updated successfully
```

---

## 3. Common Errors & Troubleshooting

* **`user not found`**:

  * You mistyped the username or the account doesn’t exist.
  * Verify with `getent passwd <username>`.
* **`Authentication token manipulation error`**:

  * Happens if `/etc/passwd` or `/etc/shadow` permissions are incorrect.
  * Check with `ls -l /etc/shadow`; it should be `-rw-r----- root:shadow`.
* **`sudo: unable to resolve host`**:

  * Your hostname might be missing in `/etc/hosts`.
  * Ensure `hostname` appears alongside `127.0.0.1` in `/etc/hosts`.

---

## 4. Practice Task

1. Create a test user (if permitted):

   ```bash
   sudo useradd testuser
   sudo passwd testuser
   ```
2. Change `testuser`’s password to a new value using `sudo passwd testuser`.
3. Verify you can switch to the new user and log in:

   ```bash
   su - testuser
   ```

   * Enter the new password when prompted.

---

## 5. Security Tips

* Use strong, unique passwords.
* Encourage users to change their own passwords regularly.
* Limit which accounts have `sudo` rights to reduce risk.

