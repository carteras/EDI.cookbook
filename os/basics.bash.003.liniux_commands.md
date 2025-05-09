# Accepting a Directory or File Pattern as an Argument in Bash (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Accept a directory path or file pattern as a script argument.
* Store that input in a Bash variable.
* Print the input to verify correct handling of shell arguments.

## Success Criteria

You have completed the task successfully if:

* Your script stores the first argument in a variable.
* Running the script with a directory or wildcard prints the expected value.
* You understand that this does not yet run `ls`, but prepares you to do so.

---

## Step 1: Create the Script File

Create a script named `print_ls_arg.sh`:

```bash
nano print_ls_arg.sh
```

Insert the following contents:

```bash
#!/bin/bash

FOO=$1

echo "$FOO"
```

Save and exit.

---

## Step 2: Understand the Script

### `#!/bin/bash`

* Declares the interpreter to be Bash.

### `FOO=$1`

* Assigns the first argument passed to the script to the variable `FOO`.

### `echo "$FOO"`

* Prints the value of `FOO` to the terminal.
* Quotes are used to handle directory names that contain spaces.

---

## Step 3: Make the Script Executable

```bash
chmod +x print_ls_arg.sh
```

---

## Step 4: Run the Script with Various `ls`-style Inputs

These examples do **not** run `ls`—they just print the input that would be passed to `ls`.

```bash
./print_ls_arg.sh /etc
./print_ls_arg.sh /home
./print_ls_arg.sh "*.sh"
```

Expected output:

```
/etc
/home
*.sh
```

**Note**: If you pass `*.sh` without quotes and files match that pattern, the shell will expand it before the script sees it. Use quotes if you want to see the literal string.

---

## Bonus: Demonstrating Shell Expansion

Try this without quotes (if you have `.sh` files):

```bash
./print_ls_arg.sh *.sh
```

Expected output (example):

```
print_ls_arg.sh run_with_sudo.sh hello_var.sh
```

This shows that the shell expands `*.sh` into matching filenames **before** the script runs.

---

## Final Recap Checklist

* [ ] Script named `print_ls_arg.sh` exists.

* [ ] Script contents:

  ```bash
  #!/bin/bash
  FOO=$1
  echo "$FOO"
  ```

* [ ] Script is executable with `chmod +x`.

* [ ] Running the script with different paths or patterns prints the correct string.
