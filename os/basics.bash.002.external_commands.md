# Accepting and Printing a Script Argument in Bash (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Understand what a positional parameter is in a Bash script.
* Assign a script argument to a variable.
* Print the variable's value to the terminal.

## Success Criteria

You can confirm success if:

* The script accepts a value as a command-line argument.
* The script assigns that value to a variable using correct syntax.
* Running the script displays the provided value.

---

## Step 1: Create the Script File

Open a terminal and create the script:

```bash
nano print_arg.sh
```

Add the following contents:

```bash
#!/bin/bash

FOO=$1

echo "$FOO"
```

Save and close the file.

---

## Step 2: Understand the Script Components

### `#!/bin/bash`

* This line ensures the script is executed using the Bash shell.

### `FOO=$1`

* This assigns the first positional parameter (`$1`) to a variable named `FOO`.
* **Positional parameters** are special variables in shell scripts that represent arguments passed to the script when it is run.

  * `$1` is the first argument
  * `$2` is the second
  * and so on.

### `echo "$FOO"`

* This prints the value of the `FOO` variable to the terminal.
* Quotes around `$FOO` preserve whitespace and prevent word splitting.

---

## Step 3: Make the Script Executable

```bash
chmod +x print_arg.sh
```

---

## Step 4: Run the Script with an Argument

Run the script by providing a string argument:

```bash
./print_arg.sh "Fedora is stable"
```

You should see:

```
Fedora is stable
```

---

## Step 5: Try Additional Examples

Run the script with different input to confirm your understanding:

```bash
./print_arg.sh "System Administration"
./print_arg.sh 12345
./print_arg.sh
```

**Explanation**:

* When no argument is provided (last example), the script prints a blank line because `$1` is empty.
* You can add input validation in more advanced scripts (optional in this lesson).

---

## Final Recap Checklist

* [ ] Created a script named `print_arg.sh`.

* [ ] Script contents:

  ```bash
  #!/bin/bash
  FOO=$1
  echo "$FOO"
  ```

* [ ] Made the script executable with `chmod +x`.

* [ ] Ran the script with a command-line argument and confirmed the output matched the input.
