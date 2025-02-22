## **EDI Lesson: Using the HC-SR04 Ultrasonic Sensor with Arduino**

🕒 **Estimated Time:** 20-30 minutes  
🛠 **Skill Level:** Beginner  
🎯 **Objective:** By the end of this lesson, students will understand how to use the **HC-SR04 ultrasonic distance sensor** with Arduino to measure distances and control outputs like LEDs.

---

## **1. Learning Objective**  
  - Understanding the working principle of the HC-SR04.
  - Wiring the HC-SR04 to an Arduino.
  - Reading distance data using Arduino code.
  - Using the sensor to control LEDs based on measured distances.

💡 **Why is this important?**  
- Ultrasonic sensors are commonly used in robotics and automation for **object detection** and **distance measurement**.
- They enable projects like obstacle-avoiding robots, parking sensors, and interactive installations.

---

## **2. What is the HC-SR04 Ultrasonic Sensor?**

The **HC-SR04** is an ultrasonic sensor that measures distance using **sound waves**. It works by sending out an ultrasonic pulse and measuring the time it takes for the echo to return.

### **Key Features:**
- **Measuring Range:** 2 cm – 400 cm
- **Accuracy:** ±3 mm
- **Operating Voltage:** 5V
- **Frequency:** 40 kHz

### **Pinout:**
1. **VCC** → 5V Power Supply
2. **Trig** → Trigger Pin (to send the ultrasonic pulse)
3. **Echo** → Echo Pin (to receive the reflected pulse)
4. **GND** → Ground

### **How It Works:**
1. The **Trig pin** sends out an ultrasonic pulse.
2. The pulse bounces off an object and returns to the sensor.
3. The **Echo pin** reads the time it took for the pulse to return.
4. The Arduino calculates the distance using the speed of sound:

```cpp
Distance (cm) = (Time (microseconds) × 0.034) / 2
```

---

## **3. Circuit Setup: Connecting HC-SR04 to Arduino**

### **Components Needed:**
- Arduino Uno
- HC-SR04 Ultrasonic Sensor
- 4 LEDs (Red, Yellow, Yellow, Green)
- 4 Resistors (220Ω)
- Breadboard
- Jumper wires

### **Wiring Guide:**

#### **🔌 HC-SR04 Ultrasonic Sensor:**
- **VCC** → **5V** on Arduino
- **GND** → **GND** on Arduino
- **Trig** → **Pin 7** on Arduino
- **Echo** → **Pin 6** on Arduino

#### **💡 LEDs (Distance Indicators):**
- **Red LED** → Pin **13**
- **Yellow LED 1** → Pin **12**
- **Yellow LED 2** → Pin **11**
- **Green LED** → Pin **10**

**Each LED’s cathode is connected to GND via a 220Ω resistor.**

---

## **4. Arduino Code: Reading Distance and Controlling LEDs**

```cpp
const int trigPin = 7;
const int echoPin = 6;

const int redLED = 13;
const int yellowLED1 = 12;
const int yellowLED2 = 11;
const int greenLED = 10;

long duration;
int distance;

void setup() {
  pinMode(trigPin, OUTPUT);
  pinMode(echoPin, INPUT);

  pinMode(redLED, OUTPUT);
  pinMode(yellowLED1, OUTPUT);
  pinMode(yellowLED2, OUTPUT);
  pinMode(greenLED, OUTPUT);

  Serial.begin(9600);
}

void loop() {
  // Clear Trig Pin
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);

  // Send a 10 microsecond pulse
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);

  // Read the Echo pin
  duration = pulseIn(echoPin, HIGH);
  distance = duration * 0.034 / 2; // Convert to cm

  Serial.print("Distance: ");
  Serial.print(distance);
  Serial.println(" cm");

  // Turn off all LEDs
  digitalWrite(redLED, LOW);
  digitalWrite(yellowLED1, LOW);
  digitalWrite(yellowLED2, LOW);
  digitalWrite(greenLED, LOW);

  // Light up LEDs based on distance
  if (distance > 100) {
    digitalWrite(redLED, HIGH); // Far
  } else if (distance > 75) {
    digitalWrite(yellowLED1, HIGH); // Mid-Far
  } else if (distance > 40) {
    digitalWrite(yellowLED2, HIGH); // Mid-Near
  } else {
    digitalWrite(greenLED, HIGH); // Close
  }

  delay(200);
}
```

✅ **LED Behavior:**
- **Red LED (Pin 13)** → Object is **far** (>100 cm)
- **Yellow LED 1 (Pin 12)** → Object is at a **mid-far** distance (75–100 cm)
- **Yellow LED 2 (Pin 11)** → Object is at a **mid-near** distance (40–75 cm)
- **Green LED (Pin 10)** → Object is **close** (<40 cm)

---

## **5. Common Errors & Fixes**

🚨 **Issue:** HC-SR04 always returns 0 cm.  
💡 **Fix:** Ensure the **Trig** and **Echo** pins are correctly wired and the object is within range.

🚨 **Issue:** Incorrect or fluctuating distance readings.  
💡 **Fix:** Use a flat, hard surface for better echo reflection and add a delay between readings.

🚨 **Issue:** Multiple LEDs light up unexpectedly.  
💡 **Fix:** Make sure all LEDs are turned **off** before turning on the selected LED.

---

## **6. Bonus: Expanding the Project**

⭐ **Add a Buzzer:** Sound an alert when an object is too close.

⭐ **Integrate a Servo:** Rotate a motor based on distance.

⭐ **Display on LCD:** Show the measured distance on an LCD screen.

---

## **7. Final Check: Did You Master the HC-SR04?**  
✅ Understood how the HC-SR04 works  
✅ Wired the sensor and read distance data  
✅ Controlled LEDs based on measured distance  
✅ Debugged common ultrasonic sensor issues  

---

## **8. Check for Understanding**  

**📝 Quick Quiz:**  
1. How does the HC-SR04 measure distance?  
2. Why is it necessary to divide by 2 when calculating distance?  
3. What is the maximum range of the HC-SR04?  
4. How can you make the sensor more accurate?

---

## **9. Homework/Extension Activity**  
**Challenge:** Build a **parking assistant system** where:
- The HC-SR04 monitors distance.
- LEDs light up as the car gets closer.
- A buzzer sounds when the car is too close to an obstacle.

