# Assigning and Printing a String Variable in Bash (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Understand how to assign a static string value to a variable in a Bash script.
* Use `echo` to print the value of a variable.
* Execute the script on Fedora Server.

## Success Criteria

You have completed the task correctly if:

* The script runs without error.
* It prints `Hello World` to the terminal output.

---

## Step 1: Create the Script File

Use a text editor to create a new script:

```bash
nano hello_var.sh
```

Add the following content:

```bash
#!/bin/bash

FOO="Hello World"

echo "$FOO"
```

Save and exit the file.

---

## Step 2: Understand the Script

### `#!/bin/bash`

* Tells the system to run this script using the Bash shell.

### `FOO="Hello World"`

* This creates a Bash variable named `FOO` and assigns it the string `"Hello World"`.
* In Bash, there should be **no spaces** around the `=` sign when assigning a variable.

### `echo "$FOO"`

* This command prints the contents of the variable `FOO` to the terminal.
* Quoting `$FOO` ensures that any spaces in the string are preserved.

---

## Step 3: Make the Script Executable

```bash
chmod +x hello_var.sh
```

**Explanation**:

* This adds execute permissions so the script can be run like a program.

---

## Step 4: Run the Script

Execute the script:

```bash
./hello_var.sh
```

Expected output:

```
Hello World
```

---

## Final Recap Checklist

* [ ] You created a script named `hello_var.sh`.

* [ ] The script contains:

  ```bash
  #!/bin/bash
  FOO="Hello World"
  echo "$FOO"
  ```

* [ ] You made it executable with `chmod +x hello_var.sh`.

* [ ] Running `./hello_var.sh` printed `Hello World` to the terminal.

