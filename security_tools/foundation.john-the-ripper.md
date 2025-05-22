Absolutely! Here's a direct instruction tutorial designed for students to use **John the Ripper** in a CTF context, especially in a controlled "cyberlab" environment.

---

# 🔐 John the Ripper CTF Tutorial – Student Guide

## 💡 What is John the Ripper?

John the Ripper (JtR) is a powerful password cracking tool. It helps security professionals (and students like you) understand how weak passwords can be exploited if not properly protected.

---

## ✅ Step 1: Setting Up the Environment

> 📌 You will either be provided with a Linux machine or VM. These instructions assume you're using a Debian-based system like Ubuntu.

### 🔧 Install John the Ripper

Open your terminal and type:

```bash
sudo apt update
sudo apt install john -y
```

Check that it installed correctly:

```bash
john --version
```

Expected output: something like `John the Ripper 1.9.x`

---

## 🔐 Step 2: Getting a Sample Password Hash

### 🧪 Simulate a password file

Let’s create a simple password hash using `openssl`. Run this command to create a hash of the word `password123`:

```bash
echo -n "password123" | openssl passwd -6 -stdin
```

Example output:

```
$6$randomsalt$kXnq5L4VoMEr9rB7wPpxONQk...
```

Copy this hash into a file:

```bash
echo 'student:$6$randomsalt$kXnq5L4VoMEr9rB7wPpxONQk...:0:0::/home/student:/bin/bash' > shadow.txt
```

---

## 🚀 Step 3: Cracking the Password

### 🧠 Use a wordlist

John uses wordlists to guess passwords. Try with a basic wordlist like `/usr/share/wordlists/rockyou.txt`.

If it's not there, install it:

```bash
sudo apt install wordlists
```

Unzip the wordlist:

```bash
gunzip /usr/share/wordlists/rockyou.txt.gz
```

### 🔓 Crack the password

Now run John against the shadow file:

```bash
john --wordlist=/usr/share/wordlists/rockyou.txt shadow.txt
```

Let it run. When it finds a match, it’ll stop.

To see the cracked password:

```bash
john --show shadow.txt
```

Expected output:

```
student:password123:0:0::/home/student:/bin/bash
```

---

## 🧼 Step 4: Resetting or Clearing

To start over:

```bash
john --wipe
```

---

## 🏁 Challenge Example

> You can use this for a basic flag challenge:

1. Provide a `shadow.txt` file with a user and a known password hash.
2. Students must use John the Ripper to identify the password.
3. The password itself can be the flag: `flag{cracked_password}`

---

## 🧠 Bonus Challenges

* Try adding multiple users with different hashes.
* Use custom wordlists with obscure passwords.
* Time students and award bonus points for cracking harder hashes.

---

Would you like a **Docker version** of this lab or a **teacher version** that includes how to generate multiple user accounts and hashes?
