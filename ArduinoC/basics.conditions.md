### **Using Conditional Statements in Arduino (C++)**

---

## **Overview: Controlling Program Flow with Conditions**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Goal:** Learn how to use conditional statements (`if`, `else`, `switch`) in Arduino programming.

---

### **1. Understanding Conditional Statements**  
Conditional statements allow an Arduino program to make **decisions** based on input values.

👀 **Basic Syntax:**  
```cpp
if (condition) {
  // Code runs if condition is true
} else {
  // Code runs if condition is false
}
```
📌 **Example:** Checking if a button is pressed.
```cpp
if (digitalRead(2) == HIGH) {
  digitalWrite(13, HIGH); // Turn LED on
} else {
  digitalWrite(13, LOW); // Turn LED off
}
```
✅ The LED turns **ON** when the button is pressed.

---

### **2. Using `if-else` Statements**  
#### 🔍 **1. Checking Sensor Values**
```cpp
int sensorValue = analogRead(A0);
if (sensorValue > 500) {
  digitalWrite(13, HIGH);
} else {
  digitalWrite(13, LOW);
}
```
✅ Turns an LED on if the sensor value is greater than `500`.

#### 📑 **2. Using `else if` for Multiple Conditions**
```cpp
int temp = 25;
if (temp < 20) {
  Serial.println("Cold");
} else if (temp < 30) {
  Serial.println("Warm");
} else {
  Serial.println("Hot");
}
```
✅ Categorizes temperature readings.

---

### **3. Using `switch-case` for Multiple Choices**  
The `switch-case` statement is useful for handling multiple fixed values.

#### 🔄 **1. Controlling LEDs Based on a Mode**
```cpp
int mode = 2;
switch (mode) {
  case 1:
    digitalWrite(13, HIGH);
    break;
  case 2:
    digitalWrite(13, LOW);
    break;
  default:
    Serial.println("Invalid mode");
}
```
✅ Turns LED **ON** in mode `1` and **OFF** in mode `2`.

---

### **4. Combining Logical Operators (`&&`, `||`, `!`)**

#### 📌 **1. Checking Multiple Conditions**
```cpp
if (digitalRead(2) == HIGH && digitalRead(3) == LOW) {
  digitalWrite(13, HIGH);
}
```
✅ Turns LED **ON** only if button `2` is pressed **and** button `3` is not pressed.

#### 🔄 **2. Using `||` (OR) for Flexible Conditions**
```cpp
if (temp > 30 || humidity > 70) {
  Serial.println("Warning: High Temp or Humidity!");
}
```
✅ Triggers a warning if **either** condition is met.

---

### **5. Common Errors & Fixes**

🚨 **Issue:** `expected ')' before '{' token`
💡 **Fix:** Ensure parentheses are properly closed.
```cpp
if (x > 5) { // ✅ Correct
```

🚨 **Issue:** `error: missing 'break' statement in switch`
💡 **Fix:** Always include `break;` inside `switch` cases.
```cpp
case 1:
  digitalWrite(13, HIGH);
  break; // ✅ Correct
```

🚨 **Issue:** `digitalWrite` not working in `if` block
💡 **Fix:** Ensure `pinMode()` is set in `setup()`.
```cpp
void setup() {
  pinMode(13, OUTPUT);
}
```

---

### **6. Bonus: Using Conditions in Real Projects**

⭐ **Automatic Night Light**
```cpp
int lightLevel = analogRead(A0);
if (lightLevel < 300) {
  digitalWrite(13, HIGH);
} else {
  digitalWrite(13, LOW);
}
```
✅ Turns LED **ON** when it's dark.

⭐ **Motion-Activated Alarm**
```cpp
int motion = digitalRead(2);
if (motion == HIGH) {
  Serial.println("Motion Detected!");
}
```
✅ Prints a message when motion is detected.

---

### **7. Final Check: Did You Master Arduino Conditions?**  
✅ Used `if-else` for decision-making  
✅ Handled multiple conditions with `switch-case`  
✅ Combined logical operators  
✅ Debugged common issues  



