**Using `echo` to Create and Append to Files**  

---

## Overview
The `echo` command prints text to standard output. By combining it with output redirection (`>` and `>>`), you can create files or add text to existing files without opening an editor.

---

## Creating a New File
1. **Command:**  
   ```bash
   echo "Hello, world!" > greeting.txt
   ```
2. **What happens:**  
   - `>` redirects the text into `greeting.txt`.  
   - If `greeting.txt` doesn’t exist, it’s created.  
   - If it does exist, its contents are **overwritten**.
3. **Verify:**  
   ```bash
   cat greeting.txt
   ```
   Output:
   ```text
   Hello, world!
   ```

---

## Appending to a File
1. **Command:**  
   ```bash
   echo "Goodbye!" >> greeting.txt
   ```
2. **What happens:**  
   - `>>` adds the text to the **end** of `greeting.txt`.  
   - Existing content remains.
3. **Verify:**  
   ```bash
   cat greeting.txt
   ```
   Output:
   ```text
   Hello, world!
   Goodbye!
   ```

---

## Useful Variations
- **Without newline:**  
  ```bash
  echo -n "No newline" > file.txt
  ```
- **Redirecting multiple lines:**  
  ```bash
  echo -e "Line1
Line2" > lines.txt
  ```
- **Using variables:**  
  ```bash
  name="Alice"
  echo "User: $name" >> info.txt
  ```

---

## Practice Tasks
1. Create `todo.txt` with an initial item:
   ```bash
   echo "Buy groceries" > todo.txt
   ```
2. Add two more items:
   ```bash
   echo "Pay bills" >> todo.txt
   echo "Walk the dog" >> todo.txt
   ```
3. Display `todo.txt`:
   ```bash
   cat todo.txt
   ```
4. Overwrite with a fresh list:
   ```bash
   echo "Start new list" > todo.txt
   cat todo.txt
   ```

---

## Tips & Common Pitfalls
- **Overwriting** vs. **appending**: using `>` will erase existing content, while `>>` preserves it.  
- **Quotation marks**: use quotes around text with spaces or special characters.  
- To **clear** a file without adding text, use:
  ```bash
  > filename.txt
  ```

---

**Explore further:** Combine `echo` with `sudo` for system files (e.g., `echo "config" | sudo tee /etc/config.conf`).

