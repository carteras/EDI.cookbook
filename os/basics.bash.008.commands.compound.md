# Searching Files for Content Using `find` and `grep` in Bash (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Accept and validate command-line arguments in a Bash script.
* Use `find` to locate files by pattern.
* Use `grep` to search inside those files for specific content.
* Prevent the script from breaking on filenames with spaces.
* Suppress unwanted error messages using `2>/dev/null`.

## Success Criteria

You have completed this task successfully if:

* The script accepts two arguments: a filename pattern and a string to search for.
* It searches from the root directory (`/`), suppressing permission errors.
* It lists only files that match both the name pattern and contain the search string.
* The script handles files with spaces in their names correctly.

---

## Step-by-Step Instructions

### Step 1: Create the Script

Open your terminal and create a new file:

```bash
nano find_with_grep.sh
```

Paste in the following code:

```bash
#!/bin/bash

# Check that two arguments were provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 <filename-pattern> <search-string>"
    echo "Example: $0 '*.txt' 'FLAG{'"
    exit 1
fi

# Assign arguments to variables
PATTERN=$1
STRING=$2

# Search from root for files matching the pattern
# Use -print0 and xargs -0 to handle filenames with spaces
find / -type f -name "$PATTERN" -print0 2>/dev/null | xargs -0 grep -l "$STRING" 2>/dev/null
```

Save and exit the editor (`Ctrl + O`, `Enter`, then `Ctrl + X`).

---

### Step 2: Make the Script Executable

```bash
chmod +x find_with_grep.sh
```

---

### Step 3: Understand the Script

#### `if [ $# -lt 2 ]; then ... fi`

This conditional checks how many arguments the user passed:

* `$#` is the number of arguments.
* `-lt` means "less than."
* If fewer than 2 arguments are provided, the script exits with a usage message.

#### `find / -type f -name "$PATTERN" -print0`

* Searches from `/` for files (`-type f`) matching the name pattern.
* `-print0` outputs results with **null characters** (`\0`) instead of newlines, which prevents problems with filenames containing spaces, newlines, or special characters.

#### `xargs -0 grep -l "$STRING"`

* `xargs -0` reads the null-terminated file list and safely passes each one to `grep`.
* `grep -l` prints only the names of files that contain the specified string.
* `2>/dev/null` suppresses error output from both `find` and `grep`.

---

### Step 4: Run the Script

#### Example 1: Search for `.conf` files containing `password`

```bash
./find_with_grep.sh "*.conf" password
```

#### Example 2: Search for `.txt` files containing `FLAG{`

```bash
./find_with_grep.sh "*.txt" "FLAG{"
```

#### Example 3: Search for `.sh` scripts that use `sudo`

```bash
./find_with_grep.sh "*.sh" sudo
```

---

### Step 5: What Happens with Missing Arguments

```bash
./find_with_grep.sh "*.sh"
```

Output:

```
Usage: ./find_with_grep.sh <filename-pattern> <search-string>
Example: ./find_with_grep.sh '*.txt' 'FLAG{'
```

The script exits and does nothing else because it validated your input before running.

---

## Final Recap Checklist

* [ ] You created a script named `find_with_grep.sh`.

* [ ] The script contains:

  ```bash
  #!/bin/bash
  if [ $# -lt 2 ]; then
      echo "Usage: $0 <filename-pattern> <search-string>"
      exit 1
  fi
  PATTERN=$1
  STRING=$2
  find / -type f -name "$PATTERN" -print0 2>/dev/null | xargs -0 grep -l "$STRING" 2>/dev/null
  ```

* [ ] You made it executable using `chmod +x`.

* [ ] You successfully ran it with:

  * A valid filename pattern (`*.txt`, `*.conf`, etc.)
  * A search string (`password`, `FLAG{`, etc.)

* [ ] You understand how `"$@"`, `find -print0`, and `xargs -0` work together.

