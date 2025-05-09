
# Conditional Logic in Bash: Handling Empty Input (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Accept a string argument and store it in a variable.
* Use an `if` statement in Bash to check if a variable is empty.
* Print different output depending on whether the variable contains a value.

## Success Criteria

You have completed this lesson successfully if:

* The script prints `Hello, NAME` when a name is provided.
* The script prints `Name is empty` when no name is given.
* You understand how `[ -z "$VAR" ]` works in Bash.

---

## Step 1: Create the Script

Create a new file named `greet.sh`:

```bash
nano greet.sh
```

Insert the following contents:

```bash
#!/bin/bash

NAME=$1

if [ -z "$NAME" ]; then
    echo "Name is empty"
else
    echo "Hello, $NAME"
fi
```

Save and exit.

---

## Step 2: Understand the Script

### `NAME=$1`

* Captures the first positional argument and assigns it to the variable `NAME`.

### `if [ -z "$NAME" ]; then`

* `-z` is a **string test** that returns true if the string is empty.
* Quoting `$NAME` ensures the test behaves correctly even if the variable is unset or contains spaces.

### `then ... else ... fi`

* Standard `if` statement structure in Bash:

  * `then` marks the start of the true block.
  * `else` is executed if the test fails.
  * `fi` ends the conditional.

### `echo "Hello, $NAME"`

* Greets the user if input is provided.

---

## Step 3: Make the Script Executable

```bash
chmod +x greet.sh
```

---

## Step 4: Run the Script

### Example 1: With a Name

```bash
./greet.sh Alice
```

Expected output:

```
Hello, Alice
```

### Example 2: Without an Argument

```bash
./greet.sh
```

Expected output:

```
Name is empty
```

---

## Step 5: Try Other Variations

```bash
./greet.sh "System Admin"
./greet.sh ""
```

* Passing `""` simulates explicitly setting the argument to an empty string.

---

## Final Recap Checklist

* [ ] Script file `greet.sh` exists.

* [ ] Script includes:

  ```bash
  #!/bin/bash
  NAME=$1
  if [ -z "$NAME" ]; then
      echo "Name is empty"
  else
      echo "Hello, $NAME"
  fi
  ```

* [ ] Script is executable (`chmod +x greet.sh`).

* [ ] Running it:

  * With a name → prints greeting.
  * Without input → prints `Name is empty`.
