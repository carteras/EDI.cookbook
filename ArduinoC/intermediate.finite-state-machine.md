### **Using the Finite State Machine (FSM) Pattern in Arduino (C++)**

---

## **Overview: Implementing FSM for Embedded Systems**  
🕒 **Estimated Time:** 20-30 minutes  
🛠 **Skill Level:** Intermediate  
🎯 **Goal:** Learn how to implement a **Finite State Machine (FSM)** to manage system behaviour efficiently in Arduino programming.

---

### **1. Understanding the FSM Pattern in Arduino**  
A **Finite State Machine (FSM)** helps structure code for **predictable behaviour and easy debugging**.

👀 **FSM Core Concepts:**  
1. **State Representation:**
   - The `STATE` variable tracks the system's current behaviour.
   - It determines what the program should do in each loop iteration.

2. **State Transition Logic:**
   - The program continuously checks `STATE` inside `loop()`.
   - Based on the state, the relevant function (`ledLeftToRight()` or `ledRightToLeft()`) executes.

3. **Event-Driven Transitions:**
   - Functions detect button presses (`leftButton` or `rightButton`).
   - If pressed, they return a **new state**, causing a state change.

4. **Loop-Based Execution:**
   - `loop()` acts as the **state evaluator** and executes the correct function.
   - Ensures smooth and **predictable transitions** in an infinite loop.

---

### **2. FSM Code Implementation in Arduino**  

#### 🔍 **1. Defining States & Variables**
```cpp
const int LED_LOW = 3;  // First LED in sequence
const int LED_HIGH = 7; // Last LED in sequence
const int btn1 = 8; // Button to switch left-to-right
const int btn2 = 9; // Button to switch right-to-left

const int LED_LEFT_TO_RIGHT = 1;
const int RIGHT_TO_LEFT = 2;
int STATE = LED_LEFT_TO_RIGHT;
```
✅ Declares **LED pin range** and **buttons** for FSM transitions.

#### 📑 **2. LED Animation Functions**
```cpp
int ledLeftToRight(int delaySpeed, int rightButton){
  if (rightButton) return RIGHT_TO_LEFT;
  for (int pin = LED_LOW; pin <= LED_HIGH; pin++){
    digitalWrite(pin, HIGH);
    delay(delaySpeed);
    digitalWrite(pin, LOW);
  }
  return LED_LEFT_TO_RIGHT;
}

int ledRightToLeft(int delaySpeed, int leftButton){
  if (leftButton) return LED_LEFT_TO_RIGHT;
  for (int pin = LED_HIGH; pin >= LED_LOW; pin--){
    digitalWrite(pin, HIGH);
    delay(delaySpeed);
    digitalWrite(pin, LOW);
  }
  return RIGHT_TO_LEFT;
}
```
✅ `ledLeftToRight()` and `ledRightToLeft()` execute **LED sequences**.
✅ If a button is pressed, they return a **new state**.

#### 🔄 **3. FSM Execution in `loop()`**
```cpp
void setup() {
  for (int pin = LED_LOW; pin <= LED_HIGH; pin++){
    pinMode(pin, OUTPUT);
  }
  pinMode(btn1, INPUT_PULLUP);
  pinMode(btn2, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  int delaySpeed = 200;  // Set LED delay time
  int leftButton = digitalRead(btn1) == LOW;
  int rightButton = digitalRead(btn2) == LOW;

  if (STATE == LED_LEFT_TO_RIGHT){
    STATE = ledLeftToRight(delaySpeed, rightButton);
  } else if (STATE == RIGHT_TO_LEFT){
    STATE = ledRightToLeft(delaySpeed, leftButton);
  }
}
```
✅ `loop()` executes the correct function based on the `STATE` variable.
✅ **Button presses change the state**, altering LED movement direction.

---

### **3. Common FSM Use Cases in Embedded Programming**

✅ **LED Sequences & Animations:** Like this example, controlling **LED patterns** based on user input.
✅ **Robotics:** Handling **motion states** (e.g., IDLE, MOVING_FORWARD, TURNING_LEFT).
✅ **IoT Devices:** Switching between **sleep mode, active mode, and error handling**.
✅ **Industrial Control Systems:** Managing **conveyor belts, traffic lights, or alarms**.

---

### **4. Common Errors & Fixes**

🚨 **Issue:** `STATE` is not updating.
💡 **Fix:** Ensure **button presses are correctly detected**.
```cpp
int leftButton = digitalRead(btn1) == LOW; // ✅ Checks if pressed
```

🚨 **Issue:** LED sequence runs once and stops.
💡 **Fix:** Make sure the **FSM loop continuously executes**.

🚨 **Issue:** Undefined variable `i` in loops.
💡 **Fix:** Use `pin` instead of `i`.
```cpp
for (int pin = LED_LOW; pin <= LED_HIGH; pin++) { // ✅ Correct variable usage
```

---

### **5. Bonus: Expanding the FSM**

⭐ **Adding More States (IDLE, BLINKING, MOVING)**
```cpp
const int IDLE = 0;
const int LED_LEFT_TO_RIGHT = 1;
const int RIGHT_TO_LEFT = 2;

if (STATE == IDLE && startButtonPressed) {
  STATE = LED_LEFT_TO_RIGHT;
}
```
✅ Can add **more states** for **advanced control**.

⭐ **Handling Serial Input to Change FSM States**
```cpp
if (Serial.available()) {
  char command = Serial.read();
  if (command == 'L') STATE = LED_LEFT_TO_RIGHT;
  if (command == 'R') STATE = RIGHT_TO_LEFT;
}
```
✅ Enables FSM **state changes via serial commands**.

---

### **6. Final Check: Did You Master FSM in Arduino?**  
✅ Used `STATE` to track system behaviour  
✅ Created event-driven state transitions  
✅ Applied `loop()` for efficient execution  
✅ Debugged FSM logic for predictable behaviour  


