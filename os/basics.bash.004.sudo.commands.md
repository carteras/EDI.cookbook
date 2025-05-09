# Executing a Command Passed to a Bash Script Using `sudo` (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Write a Bash script that accepts a Linux command as input.
* Assign that input to a variable.
* Use `sudo` to run the command with elevated privileges.
* Understand how Bash handles command arguments and basic security considerations.

## Success Criteria

You have completed the task successfully if:

* You have a working Bash script.
* Running the script with `whoami` as an argument prints `root` (assuming you have `sudo` privileges).
* You understand the behavior of `sudo "$CMD"` and why quoting is used.

---

## Step 1: Create the Script

Open your terminal and create a new file:

```bash
nano run_with_sudo.sh
```

Add the following contents:

```bash
#!/bin/bash

CMD=$1

sudo "$CMD"
```

Save and exit.

---

## Step 2: Understand the Script

### `#!/bin/bash`

* Specifies that this script should be executed with the Bash shell.

### `CMD=$1`

* Captures the first command-line argument and assigns it to the variable `CMD`.
* `$1` refers to the first **positional parameter**—i.e., the first word after the script name.

### `sudo "$CMD"`

* Uses `sudo` to execute the value stored in `CMD`.
* The quotes around `"$CMD"` preserve spacing and avoid word splitting. This ensures a single-word command like `whoami` works correctly.
* `sudo` prompts for a password if required, and then runs the command as root (or another privileged user as configured).

---

## Step 3: Make the Script Executable

```bash
chmod +x run_with_sudo.sh
```

---

## Step 4: Run the Script with `whoami`

```bash
./run_with_sudo.sh whoami
```

If prompted, enter your password.

Expected output:

```
root
```

**Explanation**:

* `whoami` prints the current user.
* Running it with `sudo` changes the effective user to `root`, so it prints `root`.

---

## Step 5: Try Other Safe Commands

Experiment with other simple commands that do not require arguments:

```bash
./run_with_sudo.sh uptime
./run_with_sudo.sh hostname
```

---

## ⚠️ Important Note on Security

This script executes **any** command passed to it as root. For example:

```bash
./run_with_sudo.sh rm -rf /
```

This would be catastrophic if `$CMD` were expanded incorrectly.

**Limitation**: The script only accepts the first word (`$1`). So this:

```bash
./run_with_sudo.sh apt update
```

Will fail, because only `apt` is passed, not the entire command.

You’ll learn how to accept **full commands with arguments** using `"$@"` in a future lesson.

---

## Final Recap Checklist

* [ ] Created a script named `run_with_sudo.sh`.

* [ ] The script contains:

  ```bash
  #!/bin/bash
  CMD=$1
  sudo "$CMD"
  ```

* [ ] Made it executable with `chmod +x run_with_sudo.sh`.

* [ ] Ran it with `whoami` and confirmed it printed `root`.

* [ ] Understood the limitation: only the first word is captured.
