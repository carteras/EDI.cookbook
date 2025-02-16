### **Using `serialEvent()` in Arduino (C++)**

---

## **Overview: Handling Serial Input with `serialEvent()`**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Intermediate  
🎯 **Goal:** Learn how to use `serialEvent()` to handle incoming serial data asynchronously in Arduino.

---

### **1. Understanding `serialEvent()`**  
The `serialEvent()` function is an **optional** function in Arduino that is **automatically triggered** when new serial data arrives.

👀 **Basic Syntax:**  
```cpp
void serialEvent() {
  // Code to handle incoming serial data
}
```
✅ Runs **outside** the `loop()` function, allowing serial data to be processed separately.

📌 **Example:** Detecting new data from the Serial Monitor
```cpp
void serialEvent() {
  while (Serial.available()) {
    char incomingChar = Serial.read();
    Serial.print("Received: ");
    Serial.println(incomingChar);
  }
}
```
✅ Reads and prints **each received character** from the serial input.

---

### **2. Initializing Serial Communication**  
Before using `serialEvent()`, initialize the **Serial port** in `setup()`.

```cpp
void setup() {
  Serial.begin(9600); // Start Serial communication at 9600 baud
}
```
✅ Ensures serial communication is active.

---

### **3. Using `serialEvent()` in a Complete Program**  

#### 🔍 **1. Echoing Input from Serial Monitor**
```cpp
void setup() {
  Serial.begin(9600);
}

void loop() {
  // Main program runs here
}

void serialEvent() {
  while (Serial.available()) {
    Serial.println(Serial.readString());
  }
}
```
✅ This program **echoes back** received strings.

#### 📑 **2. Reading Until a Specific Character**
```cpp
void serialEvent() {
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    Serial.print("Command received: ");
    Serial.println(command);
  }
}
```
✅ Reads input **until a newline (`\n`)** is detected.

#### 🔢 **3. Extracting Numeric Values**
```cpp
void serialEvent() {
  while (Serial.available()) {
    int number = Serial.parseInt();
    Serial.print("Received number: ");
    Serial.println(number);
  }
}
```
✅ Extracts and prints **integer values** from serial input.

#### 📏 **4. Extracting Floating-Point Numbers**
```cpp
void serialEvent() {
  while (Serial.available()) {
    float value = Serial.parseFloat();
    Serial.print("Received float: ");
    Serial.println(value);
  }
}
```
✅ Extracts and prints **floating-point values** from serial input.

---

### **4. Handling Special Cases**

#### 🔗 **1. Checking If Serial is Available**
```cpp
void loop() {
  if (Serial) {
    Serial.println("Serial is active");
  }
  delay(1000);
}
```
✅ Checks if the Serial port is **ready** before reading data.

#### 🛑 **2. Peeking at Incoming Data**
```cpp
void serialEvent() {
  while (Serial.available()) {
    char nextChar = Serial.peek();
    Serial.print("Next character in buffer: ");
    Serial.println(nextChar);
    Serial.read(); // Remove it from the buffer
  }
}
```
✅ Looks at the **next character** in the buffer **without removing it**.

---

### **5. Common Errors & Fixes**

🚨 **Issue:** `serialEvent()` never runs.
💡 **Fix:** Ensure `Serial.begin()` is called in `setup()`.
```cpp
void setup() {
  Serial.begin(9600);
}
```

🚨 **Issue:** Incomplete or missing input.
💡 **Fix:** Use `Serial.readStringUntil('\n')` to ensure full commands are received.

🚨 **Issue:** Serial Monitor shows `garbage` characters.
💡 **Fix:** Ensure the **baud rate** in Serial Monitor matches the value in `Serial.begin()`.

---

### **6. Bonus: Using `serialEvent()` in Real Projects**

⭐ **Serial-Controlled LED Toggle**
```cpp
void serialEvent() {
  while (Serial.available()) {
    String command = Serial.readStringUntil('\n');
    if (command == "ON") {
      digitalWrite(13, HIGH);
      Serial.println("LED ON");
    } else if (command == "OFF") {
      digitalWrite(13, LOW);
      Serial.println("LED OFF");
    }
  }
}
```
✅ **Controls an LED** using text commands.

⭐ **Serial-Controlled Motor Speed (PWM)**
```cpp
void serialEvent() {
  while (Serial.available()) {
    int speed = Serial.parseInt();
    if (speed >= 0 && speed <= 255) {
      analogWrite(9, speed);
      Serial.print("Motor Speed: ");
      Serial.println(speed);
    }
  }
}
```
✅ **Controls a motor’s speed** by sending values between `0-255`.

---

### **7. Final Check: Did You Master `serialEvent()`?**  
✅ Used `serialEvent()` to read serial input  
✅ Processed text and numeric input with `Serial.readString()`, `Serial.readStringUntil()`, `Serial.parseInt()`, and `Serial.parseFloat()`  
✅ Checked serial availability with `if (Serial)`  
✅ Used `Serial.peek()` to preview input  
✅ Resolved common serial communication errors  