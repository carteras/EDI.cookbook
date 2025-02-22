## **EDI Lesson: Using a Potentiometer with Arduino (C++)**

🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Objective:** By the end of this lesson, students will understand how to read analog values from a potentiometer using Arduino and use it to control LEDs.

---

## **1. Learning Objective**  

  - Connecting a potentiometer to an Arduino.
  - Reading analog values using `analogRead()`.
  - Using the potentiometer to control LED behaviour.

💡 **Why is this important?**  
- Potentiometers allow users to create **variable inputs** for brightness, speed, or volume controls.
- Understanding analog inputs is essential for creating interactive hardware projects.

---

## **2. What is a Potentiometer?**  
- A **potentiometer** is a variable resistor that can adjust voltage.
- It has **three pins**:
  - **VCC (Power)** → Connects to **5V**.
  - **GND (Ground)** → Connects to **GND**.
  - **Signal (Wiper)** → Connects to an **analog pin (A0)** to read the voltage.

👀 **Voltage Range:**  
- The potentiometer outputs a voltage between **0V and 5V**.
- Arduino converts this to a value between **0 and 1023** using its **10-bit ADC (Analog-to-Digital Converter)**.

---

## **3. Circuit Setup**

### **Components Needed:**
- Arduino Uno
- Breadboard
- Potentiometer
- 3 LEDs (Red, Yellow, Green)
- 3 Resistors (220Ω)
- Jumper wires

### **Wiring Guide:**
1. **Potentiometer:**
   - Connect **VCC** to **5V** on Arduino.
   - Connect **GND** to **GND** on Arduino.
   - Connect **Signal** (middle pin) to **A0** on Arduino.

2. **LEDs:**
   - Connect the **Red LED** to **pin 9**.
   - Connect the **Yellow LED** to **pin 10**.
   - Connect the **Green LED** to **pin 11**.
   - Use **220Ω resistors** for each LED to limit current.

---

## **4. Arduino Code: Reading Potentiometer & Controlling LEDs**

### **1. Basic Code to Read Potentiometer Value**
```cpp
const int potPin = A0;
int potValue = 0;

void setup() {
  Serial.begin(9600);
}

void loop() {
  potValue = analogRead(potPin);  // Read potentiometer value
  Serial.println(potValue);       // Print value to Serial Monitor
  delay(100);
}
```
✅ Open the **Serial Monitor** to see values between **0 and 1023**.

---

### **2. Controlling LED Brightness Using PWM**
```cpp
const int potPin = A0;
const int ledPin = 9;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int potValue = analogRead(potPin);            // 0 to 1023
  int brightness = map(potValue, 0, 1023, 0, 255); // Map to PWM range

  analogWrite(ledPin, brightness);              // Control LED brightness
  Serial.println(brightness);                   // Print brightness value
  delay(100);
}
```
✅ Turning the potentiometer changes the **LED brightness**.

---

### **3. Turning On LEDs Based on Potentiometer Position**
```cpp
const int potPin = A0;
const int redLED = 9;
const int yellowLED = 10;
const int greenLED = 11;

void setup() {
  pinMode(redLED, OUTPUT);
  pinMode(yellowLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int potValue = analogRead(potPin);
  Serial.println(potValue);

  if (potValue < 341) {
    digitalWrite(redLED, HIGH);
    digitalWrite(yellowLED, LOW);
    digitalWrite(greenLED, LOW);
  } else if (potValue < 682) {
    digitalWrite(redLED, LOW);
    digitalWrite(yellowLED, HIGH);
    digitalWrite(greenLED, LOW);
  } else {
    digitalWrite(redLED, LOW);
    digitalWrite(yellowLED, LOW);
    digitalWrite(greenLED, HIGH);
  }
  delay(100);
}
```
✅ The LEDs light up based on the potentiometer position:  
- **0–340:** Red LED  
- **341–681:** Yellow LED  
- **682–1023:** Green LED

---

## **5. Common Errors & Fixes**

🚨 **Issue:** Serial Monitor shows only 0 or 1023.
💡 **Fix:** Check potentiometer wiring—ensure **middle pin** is connected to **A0**.

🚨 **Issue:** LED doesn’t respond to potentiometer.
💡 **Fix:** Confirm the use of `map()` and `analogWrite()` for PWM control.

🚨 **Issue:** Potentiometer values fluctuate.
💡 **Fix:** Add a small delay in the loop or use **averaging** to smooth readings.

---

## **6. Bonus: Expanding the Project**

⭐ **Use the potentiometer to control motor speed.**  
⭐ **Implement a volume control for a buzzer.**  
⭐ **Use two potentiometers to control an RGB LED (hue & brightness).**

---

## **7. Final Check: Did You Master Potentiometers in Arduino?**  
✅ Read analog values using `analogRead()`  
✅ Controlled LED brightness with PWM  
✅ Used potentiometer values for decision-making  
✅ Debugged common potentiometer issues  

---

## **8. Check for Understanding**  

**📝 Quick Quiz:**  
1. What range of values does `analogRead()` return?  
2. How do you map potentiometer values to PWM?  
3. What happens if the potentiometer’s middle pin is disconnected?  
4. How can you use potentiometer values to control multiple outputs?

---

## **9. Homework/Extension Activity**  
**Challenge:** Design a **traffic light system** where:
- The potentiometer controls the **speed** at which lights change.
- At the lowest speed, each light stays on for 5 seconds.
- At the highest speed, lights change every second.

