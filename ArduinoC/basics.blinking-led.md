### **Blinking Lights with Arduino (C++)**

---

## **Overview: Controlling LEDs with Arduino**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Goal:** Learn how to make an LED blink using Arduino.

---

### **1. Understanding LED Blinking in Arduino**  
Blinking an LED is one of the simplest Arduino projects, demonstrating **digital output control**.

👀 **Basic Circuit:**
- **LED (Light Emitting Diode)**
- **Resistor (220Ω - 1kΩ recommended)**
- **Arduino Board**
- **Breadboard & Jumper Wires**

---

### **2. Wiring the LED**

#### **Components & Pin Connections**
- **Anode (+, Long Leg)** → Connect to **Digital Pin** (e.g., `pin 13`).
- **Cathode (-, Short Leg)** → Connect to **GND** via a resistor.

📌 **Simple Wiring Example:**
```
[Arduino Pin 13] --- [LED Anode (+)]
                          |
                        [Resistor 220Ω - 1kΩ]
                          |
                         [GND]
```

---

### **3. Blinking LED Code**

```cpp
const int ledPin = 13; // Define LED pin

void setup() {
  pinMode(ledPin, OUTPUT); // Set LED pin as an output
}

void loop() {
  digitalWrite(ledPin, HIGH); // Turn LED ON
  delay(1000); // Wait 1 second
  digitalWrite(ledPin, LOW); // Turn LED OFF
  delay(1000); // Wait 1 second
}
```
✅ This turns the LED on and off every second.

---

### **4. Modifying the Blink Rate**
To change the blink speed, modify the `delay()` values:
```cpp
  delay(500); // Faster blinking (0.5s ON, 0.5s OFF)
  delay(2000); // Slower blinking (2s ON, 2s OFF)
```
✅ Adjust delay times for different effects.

---

### **5. Using Multiple LEDs**
To blink **multiple LEDs**, define additional pins and modify `loop()`:
```cpp
const int led1 = 9;
const int led2 = 10;

void setup() {
  pinMode(led1, OUTPUT);
  pinMode(led2, OUTPUT);
}

void loop() {
  digitalWrite(led1, HIGH);
  digitalWrite(led2, LOW);
  delay(1000);
  digitalWrite(led1, LOW);
  digitalWrite(led2, HIGH);
  delay(1000);
}
```
✅ This alternates blinking between two LEDs.

---

### **6. Common Errors & Fixes**

🚨 **Issue:** LED does not blink.
💡 **Fix:** Ensure the correct pin is used and connections are secure.

🚨 **Issue:** LED is always ON or OFF.
💡 **Fix:** Verify `pinMode()` and `digitalWrite()` logic.

🚨 **Issue:** LED is too dim.
💡 **Fix:** Use a lower resistor value (e.g., `220Ω` instead of `1kΩ`).

---

### **7. Bonus: Advanced LED Blinking**

⭐ **Using `millis()` Instead of `delay()`**
```cpp
const int ledPin = 13;
unsigned long previousMillis = 0;
const long interval = 1000;

void setup() {
  pinMode(ledPin, OUTPUT);
}

void loop() {
  unsigned long currentMillis = millis();
  if (currentMillis - previousMillis >= interval) {
    previousMillis = currentMillis;
    digitalWrite(ledPin, !digitalRead(ledPin));
  }
}
```
✅ `millis()` allows blinking **without blocking other tasks**.

---

### **8. Final Check: Did You Master Blinking LEDs?**  
✅ Blinking a single LED  
✅ Adjusting blink speed  
✅ Controlling multiple LEDs  
✅ Debugging common issues  

