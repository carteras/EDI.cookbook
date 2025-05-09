# Writing a Script to Search the Filesystem with `find` and Suppressed Errors (Fedora Server)

## Learning Intentions

By the end of this tutorial, you will be able to:

* Accept `find` conditions as arguments to a script.
* Run `find /` with those conditions.
* Suppress error output using Bash redirection (`2>/dev/null`).

## Success Criteria

You have completed the task successfully if:

* The script searches from the root (`/`) using user-provided criteria.
* It prints matching results (e.g., files with a given name).
* It suppresses “Permission denied” or similar errors.

---

## Step 1: Create the Script

Create a new file named `search_flag.sh`:

```bash
nano search_flag.sh
```

Insert the following contents:

```bash
#!/bin/bash

find / "$@" 2>/dev/null
```

Save and exit.

---

## Step 2: Understand the Script

### `find / "$@"`

* This calls `find` with `/` as the **search root**.
* `"$@"` includes all additional arguments the user provides (e.g., `-name "secret.flag"`).
* This limits what users can modify—only the search **conditions**, not the search location.

### `2>/dev/null`

* This redirects **file descriptor 2** (standard error) to `/dev/null`, effectively silencing it.
* It hides warnings like `Permission denied`, which are common when searching `/` as a non-root user.

---

## Step 3: Make the Script Executable

```bash
chmod +x search_flag.sh
```

---

## Step 4: Run the Script

### Example: Search for a file named `secret.flag`

```bash
./search_flag.sh -name "secret.flag"
```

Expected output:
A list of full paths (if found), or no output if the file does not exist or is unreadable.

### Other Examples:

```bash
./search_flag.sh -type f -name "*.sh"
./search_flag.sh -type d -empty
```

All of these:

* Search from `/`
* Use user-defined filters
* Hide permission errors

---

## Step 5: Optional — Add Input Validation

Add a check to ensure arguments are passed:

```bash
if [ $# -eq 0 ]; then
    echo "Usage: $0 <find-conditions>"
    echo "Example: $0 -name 'secret.flag'"
    exit 1
fi
```

Put this block **before** the `find` command.

---

## Final Recap Checklist

* [ ] Script is named `search_flag.sh`.

* [ ] Script contents:

  ```bash
  #!/bin/bash
  find / "$@" 2>/dev/null
  ```

* [ ] Script is executable (`chmod +x`).

* [ ] Running with arguments like `-name "secret.flag"` returns results or remains silent (no error spam).

* [ ] You understand how `"$@"` passes arguments safely and how `2>/dev/null` suppresses stderr.

