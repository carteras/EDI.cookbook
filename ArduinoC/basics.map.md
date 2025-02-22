## **EDI Lesson: Introduction to the `map()` Function in Arduino (C++)**

🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Objective:** By the end of this lesson, students will understand how to use the `map()` function in Arduino to scale values and apply it to control multiple outputs using a potentiometer.

---

## **1. Learning Objective**  
  - Understanding how `map()` works.
  - Using `map()` to scale analog values.
  - Controlling multiple LEDs based on potentiometer position.

💡 **Why is this important?**  
- Sensors and inputs often give values in specific ranges. The `map()` function allows us to scale these values to control outputs like LEDs, motors, or displays.

---

## **2. What is the `map()` Function?**  
- The `map()` function **re-maps a number from one range to another**.

📌 **Syntax:**
```cpp
map(value, fromLow, fromHigh, toLow, toHigh);
```

**Parameters:**
- `value` → The number to map.
- `fromLow` → Lower bound of the input range.
- `fromHigh` → Upper bound of the input range.
- `toLow` → Lower bound of the output range.
- `toHigh` → Upper bound of the output range.

**Example:**
```cpp
int sensorValue = analogRead(A0); // 0 to 1023
int brightness = map(sensorValue, 0, 1023, 0, 255);
```
✅ This maps the potentiometer range **(0–1023)** to a PWM range **(0–255)**.

---

## **3. Using `map()` with Arduino**

### **1. Mapping Potentiometer Values to LED Brightness**
```cpp
const int potPin = A0;
const int ledPin = 9;

void setup() {
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int potValue = analogRead(potPin);               // 0 to 1023
  int brightness = map(potValue, 0, 1023, 0, 255); // Map to PWM range

  analogWrite(ledPin, brightness);                 // Control LED brightness
  Serial.println(brightness);                      // Print brightness
  delay(100);
}
```
✅ Turning the potentiometer changes the **LED brightness**.

---

### **2. Mapping to Control Servo Angle**
```cpp
#include <Servo.h>

Servo myServo;
const int potPin = A0;

void setup() {
  myServo.attach(9);
  Serial.begin(9600);
}

void loop() {
  int potValue = analogRead(potPin);                // 0 to 1023
  int angle = map(potValue, 0, 1023, 0, 180);       // Map to 0-180 degrees

  myServo.write(angle);                             // Set servo angle
  Serial.println(angle);
  delay(100);
}
```
✅ The potentiometer controls the **servo’s angle** from **0° to 180°**.

---

## **4. Circuit: Using `map()` to Select LEDs Based on Potentiometer Position**

### **Components Needed:**
- Arduino Uno
- Breadboard
- Potentiometer
- 3 LEDs (Red, Yellow, Green)
- 3 Resistors (220Ω)
- Jumper wires

### **Wiring Guide:**
1. **Potentiometer:**
   - VCC → **5V**
   - GND → **GND**
   - Signal → **A0**

2. **LEDs:**
   - **Red LED** → Pin **13**
   - **Yellow LED** → Pin **12**
   - **Green LED** → Pin **10**
   - Use **220Ω resistors** for each LED.

---

### **Code: Selecting LEDs Based on Potentiometer Position**
```cpp
const int potPin = A0;
const int redLED = 13;
const int yellowLED = 12;
const int greenLED = 10;

void setup() {
  pinMode(redLED, OUTPUT);
  pinMode(yellowLED, OUTPUT);
  pinMode(greenLED, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int potValue = analogRead(potPin);                  // Read potentiometer (0-1023)
  int ledSelector = map(potValue, 0, 1023, 0, 2);     // Map to 0-2

  // Turn off all LEDs before selecting one
  digitalWrite(redLED, LOW);
  digitalWrite(yellowLED, LOW);
  digitalWrite(greenLED, LOW);

  // Turn on the selected LED
  if (ledSelector == 0) {
    digitalWrite(redLED, HIGH);
    Serial.println("Red LED ON");
  } else if (ledSelector == 1) {
    digitalWrite(yellowLED, HIGH);
    Serial.println("Yellow LED ON");
  } else if (ledSelector == 2) {
    digitalWrite(greenLED, HIGH);
    Serial.println("Green LED ON");
  }

  delay(100);
}
```

✅ **Potentiometer Positions:**
- **Full Left → Red LED (Pin 13)**
- **Middle → Yellow LED (Pin 12)**
- **Full Right → Green LED (Pin 10)**

---

## **5. Common Errors & Fixes**

🚨 **Issue:** LED flickers when selecting.
💡 **Fix:** Ensure only one LED is on at a time by turning others off.

🚨 **Issue:** LED doesn’t light at full potentiometer turns.
💡 **Fix:** Confirm `map()` covers the full 0–1023 range.

🚨 **Issue:** No LED turns on.
💡 **Fix:** Check LED connections and resistor placements.

---

## **6. Bonus: Expanding the Project**

⭐ **Add More LEDs:** Increase the mapped range to select more LEDs.

⭐ **Variable Brightness:** Use `map()` to control both **which LED** lights and its **brightness**.

⭐ **Multi-Function Dial:** Map different sections of the potentiometer to control LEDs, buzzers, or servos.

---

## **7. Final Check: Did You Master `map()` in Arduino?**  
✅ Used `map()` to scale analog values  
✅ Controlled LEDs based on potentiometer position  
✅ Debugged common mapping issues  
✅ Applied `map()` to a multi-output system  

---

## **8. Check for Understanding**  

**📝 Quick Quiz:**  
1. What does the `map()` function do in Arduino?  
2. Why is it necessary to map analog values before using them?  
3. What would happen if the `map()` range didn’t match the potentiometer’s full range?  
4. How can you use `map()` for multi-output control?

---

## **9. Homework/Extension Activity**  
**Challenge:** Expand the LED selector circuit by adding **two more LEDs**. Adjust the `map()` function to evenly divide the potentiometer’s range among **five LEDs**, ensuring smooth transitions between them.