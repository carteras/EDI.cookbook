### 🚀 Arduino Challenge: LED Sequencing with Buttons

#### **Task:**  
You have an **Arduino Uno** connected to a breadboard with **five LEDs** and **two push buttons**. Your goal is to write a program that follows these conditions:

1. When **button 1** is pressed, the LEDs should turn **on one by one** in a sequence, with a **200ms delay** between each.
2. When **button 2** is pressed, the LEDs should turn **off one by one** in reverse order, also with a **200ms delay** between each.
3. If **neither button is pressed**, the LEDs should stay in their current state.

---

#### **Requirements:**
✅ Use a **for loop** to control the LEDs.  
✅ Use a **function** to handle turning LEDs on and off.  
✅ Use **variables** to store the LED and button pin numbers.  
✅ Use **conditions** (`if` statements) to check button states.

---

#### **🎨 Bonus Challenge:**  
Modify your program so that holding **button 1** continuously will cause the LEDs to repeat the sequence **in a loop**, and holding **button 2** will do the same but in reverse.

---

#### **👉 Hint:**  
Use `digitalRead()` to check the button state and `digitalWrite()` to control the LEDs. The `delay()` function will help you create the necessary timing.

Good luck! 🚀