### **Using Variables in Arduino (C++)**

---

## **Overview: Understanding Variables in Arduino**  
🕒 **Estimated Time:** 15-20 minutes  
🛠 **Skill Level:** Beginner to Intermediate  
🎯 **Goal:** Learn how to declare, initialize, and use variables in Arduino programming.

---

### **1. What Are Variables in Arduino?**  
A **variable** is a named storage location in memory that holds a value. Variables allow programs to store, retrieve, and modify data dynamically.

👀 **Basic Syntax:**  
```cpp
type variableName = value;
```
- **type** → Defines the data type (e.g., `int`, `float`, `char`).
- **variableName** → The name of the variable.
- **value** → The initial value assigned to the variable (optional).

📌 **Example:** Declaring and assigning a variable
```cpp
int ledPin = 13; // Stores the pin number for the LED
```
✅ The variable `ledPin` stores the number `13`.

---

### **2. Variable Data Types in Arduino**  

#### 📌 **1. Integer (`int`)**
```cpp
int sensorValue = 1023;
```
✅ Stores whole numbers from **-32,768 to 32,767**.

#### 📌 **2. Floating Point (`float`)**
```cpp
float temperature = 36.5;
```
✅ Stores decimal numbers (e.g., **3.14, -0.001**).

#### 📌 **3. Character (`char`)**
```cpp
char grade = 'A';
```
✅ Stores a **single character** (e.g., `'A'`, `'B'`).

#### 📌 **4. Boolean (`bool`)**
```cpp
bool isPressed = true;
```
✅ Stores **true (1)** or **false (0)** values.

#### 📌 **5. String (`String`)**
```cpp
String name = "Arduino";
```
✅ Stores text as a sequence of characters.

---

### **3. Scope and Lifetime of Variables**

#### 📂 **1. Global Variables**
Declared **outside** `setup()` and `loop()`, accessible from anywhere.
```cpp
int counter = 0;
void setup() {
  Serial.begin(9600);
}
void loop() {
  counter++; // Accessible inside loop
  Serial.println(counter);
}
```
✅ `counter` retains its value between iterations.

#### 🔄 **2. Local Variables**
Declared **inside** functions, accessible only within that function.
```cpp
void setup() {
  int x = 10; // Local to setup()
}
void loop() {
  // x is not accessible here
}
```
✅ `x` is only valid inside `setup()`.

#### ♻ **3. Static Variables**
Retain their value between function calls.
```cpp
void count() {
  static int count = 0;
  count++;
  Serial.println(count);
}
```
✅ Useful for maintaining state inside a function.

---

### **4. Constants and `#define` Macros**

#### 🔗 **1. Defining Constants with `const`**
```cpp
const int ledPin = 13;
```
✅ `ledPin` cannot be modified later.

#### 🔄 **2. Using `#define` for Macros**
```cpp
#define BAUD_RATE 9600
Serial.begin(BAUD_RATE);
```
✅ `#define` is replaced by the compiler before execution.

---

### **5. Using Variables in Arduino Programs**

#### 🚀 **1. Blinking an LED with a Variable**
```cpp
const int ledPin = 13;
void setup() {
  pinMode(ledPin, OUTPUT);
}
void loop() {
  digitalWrite(ledPin, HIGH);
  delay(1000);
  digitalWrite(ledPin, LOW);
  delay(1000);
}
```
✅ Uses a variable to store the LED pin number.

#### 🔍 **2. Reading Sensor Values**
```cpp
int sensorPin = A0;
void setup() {
  Serial.begin(9600);
}
void loop() {
  int sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  delay(500);
}
```
✅ Reads and prints an **analog sensor** value.

---

### **6. Common Errors & Fixes**

🚨 **Issue:** `expected ';' before '}' token`
💡 **Fix:** Ensure every statement ends with a semicolon (`;`).
```cpp
int x = 10 // ❌ Missing semicolon
int x = 10; // ✅ Correct
```

🚨 **Issue:** `was not declared in this scope`
💡 **Fix:** Declare the variable **before using it**.
```cpp
x = 5; // ❌ Variable 'x' not declared
int x = 5; // ✅ Correct
```

🚨 **Issue:** `redefinition of 'variableName'`
💡 **Fix:** Avoid declaring the same variable twice.
```cpp
int value = 10;
int value = 20; // ❌ Duplicate declaration
```

---

### **7. Bonus: Advanced Variable Techniques**

⭐ **Using Arrays to Store Multiple Values**
```cpp
int values[3] = {10, 20, 30};
```
✅ Stores multiple values in a single variable.

⭐ **Using Pointers for Memory Efficiency**
```cpp
int num = 42;
int *ptr = &num;
```
✅ `ptr` stores the **memory address** of `num`.

⭐ **Passing Variables to Functions**
```cpp
void multiply(int x) {
  Serial.println(x * 2);
}
void setup() {
  Serial.begin(9600);
  multiply(5);
}
```
✅ Sends a variable to a function.

---

### **8. Final Check: Did You Master Arduino Variables?**  
✅ Declared and initialized variables correctly  
✅ Understood variable scope and data types  
✅ Used constants and macros effectively  
✅ Resolved common coding errors  
