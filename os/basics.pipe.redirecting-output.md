### **Using the Pipe (`|`) in Linux**

---

## **Overview: Redirecting Output Between Commands with Pipes**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner to Intermediate  
🎯 **Goal:** Learn how to use the pipe (`|`) to pass the output of one command as input to another.

---

### **1. Understanding the Pipe (`|`)**  
In Linux, the **pipe operator (`|`)** allows you to **chain commands together**, passing the output of one command as the input to another.

👀 **Basic Syntax:**  
```bash
command1 | command2
```
- **command1** → Produces output
- **command2** → Receives `command1`’s output as input

📌 **Example:** Listing files and filtering results
```bash
ls -l | grep "txt"
```
✅ Lists all files and filters those containing "txt".

---

### **2. Common Uses of Pipes**  

#### 🔍 **1. Filtering Output with `grep`**
```bash
ps aux | grep "nginx"
```
✅ Finds running processes related to `nginx`.

#### 📑 **2. Counting Lines with `wc -l`**
```bash
ls | wc -l
```
✅ Counts the number of files in the current directory.

#### 🏷 **3. Sorting Output with `sort`**
```bash
du -h | sort -h
```
✅ Displays directory sizes and sorts them from smallest to largest.

#### 🔗 **4. Displaying Unique Entries with `uniq`**
```bash
cat names.txt | sort | uniq
```
✅ Sorts and removes duplicate lines from `names.txt`.

#### 🛠 **5. Viewing Logs in Real-Time with `tail -f`**
```bash
dmesg | tail -f
```
✅ Continuously displays new kernel log messages.

---

### **3. Combining Multiple Pipes**

#### 🔗 **1. Finding and Counting a Pattern in Logs**
```bash
cat logfile.txt | grep "ERROR" | wc -l
```
✅ Counts occurrences of "ERROR" in `logfile.txt`.

#### 📊 **2. Displaying Disk Usage for Large Files**
```bash
find /var/log -type f -size +100M | xargs du -sh | sort -h
```
✅ Finds files larger than 100MB, gets their sizes, and sorts them.

#### 🔍 **3. Extracting Specific Columns with `awk`**
```bash
ps aux | awk '{print $1, $2, $11}'
```
✅ Displays process owner, PID, and command name.

---

### **4. Handling Special Cases**

#### 🛑 **1. Handling Errors in a Pipeline**
```bash
command1 | command2 | command3
```
✅ If `command1` fails, it may affect subsequent commands.

#### 🔄 **2. Ignoring Errors in a Pipeline**
```bash
command1 | command2 2>/dev/null
```
✅ Redirects errors to `/dev/null`, preventing them from affecting the pipeline.

#### ⏳ **3. Running Pipes in Background**
```bash
command1 | command2 &
```
✅ Executes the pipeline in the background.

---

### **5. Common Pipe Errors & Fixes**

🚨 **Issue:** `Broken pipe`
💡 **Fix:** Ensure previous commands do not terminate prematurely.

🚨 **Issue:** `command not found`
💡 **Fix:** Verify that all commands in the pipeline exist by running them individually.

🚨 **Issue:** `Permission denied`
💡 **Fix:** Try using `sudo` if administrative access is required.

---

### **6. Bonus: Advanced Pipe Tricks**

⭐ **Chaining with `tee` to Save Output to a File**
```bash
ls -l | tee filelist.txt
```
✅ Displays output and saves it to `filelist.txt`.

⭐ **Piping Output into a `while` Loop**
```bash
ls | while read file; do echo "Processing $file"; done
```
✅ Iterates over each file in the directory.

⭐ **Processing JSON Output with `jq`**
```bash
curl -s https://api.example.com/data | jq '.'
```
✅ Formats JSON data in a readable format.

---

### **Final Check: Did You Master Piping?**  
✅ Used `|` to chain commands  
✅ Filtered and manipulated text using `grep`, `sort`, and `awk`  
✅ Combined multiple pipes for complex workflows  
✅ Resolved common errors  



