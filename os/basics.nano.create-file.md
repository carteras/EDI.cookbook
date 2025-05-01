# Editing Text Files with Nano

## Overview

Nano is a simple, user-friendly terminal text editor. You can create, view, and edit text files without leaving the command line. This tutorial covers opening files, typing, saving, exiting, and basic navigation.

---

## What You Need

- Access to a Linux terminal.  
- Familiarity with basic commands (`ls`, `cd`).

---

## Opening Nano

1. To create or open a file named `notes.txt`, type:

   ```bash
   nano notes.txt
   ```

2. If `notes.txt` doesn’t exist, Nano creates it. If it exists, Nano opens it for editing.

---

## Basic Editing

- **Typing text:** Just start typing at the cursor.  
- **New line:** Press <kbd>Enter</kbd> to move to a new line.

---

## Saving Your Work

1. Press <kbd>Ctrl</kbd>+<kbd>O</kbd> (Write Out).  
2. Nano prompts: `File Name to Write: notes.txt`.  
3. Press <kbd>Enter</kbd> to confirm.

---

## Exiting Nano

- After saving, press <kbd>Ctrl</kbd>+<kbd>X</kbd> to exit Nano and return to the shell.

---

## Navigation Shortcuts

| Action                     | Shortcut                |
|----------------------------|-------------------------|
| Move cursor up/down/left/right | <kbd>↑</kbd> / <kbd>↓</kbd> / <kbd>←</kbd> / <kbd>→</kbd> |
| Jump to line N                | <kbd>Ctrl</kbd>+<kbd>_</kbd>, then type N and <kbd>Enter</kbd> |
| Search for text               | <kbd>Ctrl</kbd>+<kbd>W</kbd> |
| Repeat search                 | <kbd>Ctrl</kbd>+<kbd>W</kbd>, then <kbd>Enter</kbd> |

---

## Cutting, Copying, and Pasting

1. **Set mark (start selection):** <kbd>Ctrl</kbd>+<kbd>^</kbd>  
2. **Move cursor to end** of text to select.  
3. **Cut selected text:** <kbd>Ctrl</kbd>+<kbd>K</kbd>  
4. **Paste text:** <kbd>Ctrl</kbd>+<kbd>U</kbd>

---

## Practice Tasks

1. Open a new file:

   ```bash
   nano diary.txt
   ```

2. Type three lines of text.  
3. Save with <kbd>Ctrl</kbd>+<kbd>O</kbd>, then exit with <kbd>Ctrl</kbd>+<kbd>X</kbd>.
4. Re-open `diary.txt`:

   ```bash
   nano diary.txt
   ```

5. Search for a word: <kbd>Ctrl</kbd>+<kbd>W</kbd>, enter the word, <kbd>Enter</kbd>.
6. Cut the first line: set mark (<kbd>Ctrl</kbd>+<kbd>^</kbd>), move to line end, cut (<kbd>Ctrl</kbd>+<kbd>K</kbd>), then paste at bottom (<kbd>Ctrl</kbd>+<kbd>U</kbd>).

---

## Tips & Troubleshooting

- Nano shows shortcuts at the bottom: `^` stands for <kbd>Ctrl</kbd>.  
- If you make a mistake, you can always exit without saving by pressing <kbd>Ctrl</kbd>+<kbd>X</kbd> and answering **N** to the save prompt.

---

**Explore further**: View help inside Nano with <kbd>Ctrl</kbd>+<kbd>G</kbd> for a full list of commands.
