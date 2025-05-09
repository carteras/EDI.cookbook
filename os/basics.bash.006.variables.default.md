# Using Default Values for Script Arguments in Bash (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Accept an optional script argument and assign it to a variable.
* Use Bash parameter expansion to provide a default value when no input is given.
* Print a customized or fallback message based on the input.

## Success Criteria

You have completed this lesson successfully if:

* Running the script with an argument prints a personalized greeting.
* Running the script without an argument prints a default message.
* You understand how `${1:-default}` works in Bash.

---

## Step 1: Create the Script File

Create a new script:

```bash
nano greet_default.sh
```

Insert the following code:

```bash
#!/bin/bash

NAME=${1:-"whoever you are."}

echo "Hello, $NAME"
```

Save and exit.

---

## Step 2: Understand the Script

### `NAME=${1:-"whoever you are."}`

* This uses **parameter expansion** with a default value.
* `${1}` is the first script argument.
* The `:-` operator means: “Use the value of `$1` if it's set and not null; otherwise use the string `whoever you are.`”
* The result is assigned to the variable `NAME`.

### `echo "Hello, $NAME"`

* Prints a greeting with either the user-provided name or the default fallback.

---

## Step 3: Make the Script Executable

```bash
chmod +x greet_default.sh
```

---

## Step 4: Run the Script

### Example 1: With a Name

```bash
./greet_default.sh Alice
```

Expected output:

```
Hello, Alice
```

### Example 2: With No Argument

```bash
./greet_default.sh
```

Expected output:

```
Hello, whoever you are.
```

---

## Step 5: Try More Cases

Test with empty quotes:

```bash
./greet_default.sh ""
```

Output:

```
Hello, 
```

**Explanation**:

* Quoting an empty string passes a null value (`""`), which Bash **does not replace** with the default. The `:-` default only applies if the variable is **unset or null**, and `""` counts as a set (but empty) value.

---

## Final Recap Checklist

* [ ] Created the script `greet_default.sh`.

* [ ] Script contents:

  ```bash
  #!/bin/bash
  NAME=${1:-"whoever you are."}
  echo "Hello, $NAME"
  ```

* [ ] Made it executable with `chmod +x greet_default.sh`.

* [ ] Verified that:

  * With an argument, it prints a personal greeting.
  * Without an argument, it prints: `Hello, whoever you are.`
