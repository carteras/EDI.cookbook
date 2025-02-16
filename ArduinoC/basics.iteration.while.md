### **Using `while` Loops in Arduino (C++)**

---

## **Overview: Repeating Code with `while` Loops**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Goal:** Learn how to use `while` loops to execute repetitive tasks efficiently in Arduino.

---

### **1. Understanding `while` Loops in Arduino**  
A `while` loop **repeats a block of code** as long as a specified condition is `true`.

👀 **Basic Syntax:**  
```cpp
while (condition) {
  // Code to execute while condition is true
}
```
- **condition** → The loop will continue running as long as this condition remains `true`.

📌 **Example:** Counting from `1` to `5`
```cpp
int i = 1;
while (i <= 5) {
  Serial.println(i);
  i++;
}
```
✅ Prints numbers `1` through `5` to the Serial Monitor.

---

### **2. Using `while` Loops in Arduino Programs**  

#### 🔍 **1. Blinking an LED Until a Button is Pressed**
```cpp
const int ledPin = 13;
const int buttonPin = 2;
void setup() {
  pinMode(ledPin, OUTPUT);
  pinMode(buttonPin, INPUT_PULLUP);
}
void loop() {
  while (digitalRead(buttonPin) == HIGH) {
    digitalWrite(ledPin, HIGH);
    delay(500);
    digitalWrite(ledPin, LOW);
    delay(500);
  }
}
```
✅ The LED **blinks until** the button is pressed.

#### 📑 **2. Waiting for Serial Input**
```cpp
void setup() {
  Serial.begin(9600);
}
void loop() {
  Serial.println("Enter a number:");
  while (Serial.available() == 0) {
    // Wait for user input
  }
  int number = Serial.parseInt();
  Serial.print("You entered: ");
  Serial.println(number);
}
```
✅ The program **waits for user input** before proceeding.

#### 🔄 **3. Using `while` to Read Sensor Data Continuously**
```cpp
const int sensorPin = A0;
void setup() {
  Serial.begin(9600);
}
void loop() {
  while (analogRead(sensorPin) > 500) {
    Serial.println("High sensor value detected!");
    delay(500);
  }
}
```
✅ The program **logs data** as long as the sensor value is above `500`.

---

### **3. Infinite `while` Loops and How to Exit**
A `while (true)` loop **runs forever** unless a condition is used to break it.

#### 📌 **1. Using `break` to Exit a Loop**
```cpp
void loop() {
  int i = 0;
  while (true) {
    Serial.println(i);
    i++;
    if (i > 5) {
      break;
    }
  }
}
```
✅ Stops after printing `0` to `5`.

#### 🔄 **2. Restarting an Arduino Using `while (true)`**
```cpp
void loop() {
  Serial.println("System error! Restarting...");
  while (true) {
    // Halt execution
  }
}
```
✅ Freezes execution **until reset**.

---

### **4. Common Errors & Fixes**

🚨 **Issue:** `while` loop runs indefinitely.
💡 **Fix:** Ensure the **condition eventually becomes false**.
```cpp
while (i < 10) { // ✅ Correct
  i++;
}
```

🚨 **Issue:** No delay inside `while`, causing excessive CPU usage.
💡 **Fix:** Add a **delay** to prevent unnecessary processing.
```cpp
delay(500); // ✅ Avoids excessive CPU usage
```

🚨 **Issue:** `while` loop does not run.
💡 **Fix:** Ensure the condition **starts as true**.
```cpp
int i = 0;
while (i < 5) { // ✅ Correct
  i++;
}
```

---

### **5. Bonus: Using `while` Loops in Real Projects**

⭐ **Automatic LED Dimming**
```cpp
const int ledPin = 9;
void setup() {
  pinMode(ledPin, OUTPUT);
}
void loop() {
  int brightness = 0;
  while (brightness <= 255) {
    analogWrite(ledPin, brightness);
    brightness++;
    delay(10);
  }
}
```
✅ Gradually increases LED brightness.

⭐ **Waiting for a Button Press to Proceed**
```cpp
const int buttonPin = 2;
void setup() {
  pinMode(buttonPin, INPUT_PULLUP);
  Serial.begin(9600);
}
void loop() {
  Serial.println("Press the button to continue...");
  while (digitalRead(buttonPin) == HIGH) {
    // Wait for button press
  }
  Serial.println("Button pressed!");
}
```
✅ The program **pauses until** the button is pressed.

---

### **6. Final Check: Did You Master `while` Loops?**  
✅ Used `while` loops to create continuous processes  
✅ Controlled LEDs and sensors with looping conditions  
✅ Managed infinite loops with `break` statements  
✅ Debugged common issues with loop conditions  

