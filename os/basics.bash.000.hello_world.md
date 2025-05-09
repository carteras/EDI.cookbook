# Creating and Running a Simple Bash Script on Fedora Server

## Learning Intentions

By the end of this tutorial, you will be able to:

* Understand what a Bash script is.
* Create a basic Bash script using a terminal-based text editor.
* Make the script executable.
* Execute the script from the command line.

## Success Criteria

You have completed the task correctly if:

* A file named `hello.sh` exists on the server.
* The file begins with the correct shebang and uses proper Bash syntax.
* You have assigned executable permissions to the script.
* Running `./hello.sh` prints `hello world` to the terminal.

---

## Step 1: Connect to the Server and Open a Shell

**Explanation**:
If you're working directly on Fedora Server (via physical access or virtual console), log in and open a shell.
If you're connecting remotely (which is typical for Fedora Server), use SSH:

```bash
ssh your_username@your_server_ip
```

Replace `your_username` and `your_server_ip` with the actual user and IP.

---

## Step 2: Create a New Script File

Use a command-line text editor such as `nano` or `vim`.

```bash
nano hello.sh
```

**Note**: If `nano` is not installed (it may not be by default), install it with:

```bash
sudo dnf install nano
```

---

## Step 3: Add Bash Script Content

In the `nano` editor, enter the following script:

```bash
#!/bin/bash

echo "hello world"
```

**Explanation**:

* `#!/bin/bash` is the **shebang line**, which tells Fedora to use the Bash shell to interpret this file.
* `echo "hello world"` is the command that prints a string to the standard output.

To save and exit:

* Press `Ctrl + O`, then `Enter` to save.
* Press `Ctrl + X` to exit.

---

## Step 4: Make the Script Executable

Give the script execute permission using `chmod`:

```bash
chmod +x hello.sh
```

**Explanation**:

* `chmod` changes the file permissions.
* `+x` means "add execute permission."
* Without this step, you cannot run the script as a program.

You can verify the permissions with:

```bash
ls -l hello.sh
```

You should see something like:

```
-rwxr-xr-x. 1 your_username your_group 25 May 9 12:34 hello.sh
```

The `x` characters indicate it’s executable.

---

## Step 5: Run the Script

Execute the script with:

```bash
./hello.sh
```

**Explanation**:

* `./` specifies the current directory.
* If the script is not in your `$PATH`, typing just `hello.sh` will result in a “command not found” error.

Expected output:

```
hello world
```

---

## Final Recap Checklist

* [ ] You are connected to your Fedora Server terminal or via SSH.

* [ ] You created a file named `hello.sh`.

* [ ] The script contains:

  ```bash
  #!/bin/bash
  echo "hello world"
  ```

* [ ] You ran `chmod +x hello.sh` to make it executable.

* [ ] Running `./hello.sh` prints `hello world`.

