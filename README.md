# 📱 QR Scanner Google sheets

A Flutter QR Scanner application that allows users to scan QR codes, view results, handle errors, and store scanned data in google sheets with scan data , device id , timestamp , userid .  
The app follows **Clean Architecture**, uses **BLoC** for state management, and supports **offline storage**. 

Note 1 :- when app has no internet it saves data locally and when connection restores it automatically syncs with remote google sheet in home screen also the list of google sheets is cached for offline access. 

Note 2 :- The app can only list the sheets that are created in app by user (done intentionally) .

---

## 📸 App Screenshots

| Home Screen | Scanner Screen | Scan Result Screen |
|------------|---------------|---------------|
| ![](https://github.com/user-attachments/assets/13654c40-ffea-4afa-bd6c-282c2c9448e4) | ![](https://github.com/user-attachments/assets/aa4691bc-d8ae-4903-b885-aa4d3ee5fc1d) | ![](https://github.com/user-attachments/assets/ae3a04fa-ceca-4524-956b-65210aff1ba0) |

| Confirmation and sheet selection for save screen | Create new Sheets | QR History |
|-------------|-------------|---------|
| ![](https://github.com/user-attachments/assets/f7c8a066-57e7-4309-9f7f-8c1ac773e1fc) | ![](https://github.com/user-attachments/assets/6bb2be65-8e71-436c-b7f3-0c716a6075da) | ![](https://github.com/user-attachments/assets/00504736-081c-4b86-95a1-a86772301064)  |

---

## 🚀 App Flow (Step by Step)

### 🏠 1. Home Screen
This is the **first screen** when the app opens.

**What the user sees**
- A title
- A **Scan QR Code** button

**UI example**
- Scan Button: `300 × 60 px`
- Centered on the screen

🧒 *Example:*  
Like a big green button saying “Start” in a game.

---

### 📷 2. QR Scanner Screen
This screen opens the **camera**.

**What happens**
- Camera starts automatically
- A square box shows where to place the QR code

**UI sizes**
- Camera: Full screen
- QR Scan Box: `270 × 270 px`
- Instruction text above the box

🧒 *Example:*  
Like placing a paper inside a square frame so the camera can read it.

---

### ✅ 3. Scan Result / Confirmation Screen
After scanning, the app shows the result.

**What the user can do**
- See scanned QR data
- Add a comment
- Choose a sheet
- Save the scan

**UI sizes**
- Result card: `match width`
- Save button: `250 × 55 px`

🧒 *Example:*  
Like reading a message and deciding where to store it in a notebook.

---

### 📄 4. Sheets Screen
This screen shows all saved sheets.

**Features**
- Create new sheet
- Select existing sheet
- View QR history per sheet

🧒 *Example:*  
Like folders in a school bag, each folder has many notes inside.

---

### ❌ 5. Error Handling
If something goes wrong:

- Camera permission denied
- QR unreadable
- No internet (if needed)

The app shows:
- Error message
- Retry button

🧒 *Example:*  
Like saying “Oops! Try again” if you make a mistake.

---

## 🧠 Architecture Used

The app follows **Clean Architecture**:
![Screenshot_2026-01-16-04-16-27-422_com example qr_scanner_practice](https://github.com/user-attachments/assets/ae3a04fa-ceca-4524-956b-65210aff1ba0)
![Screenshot_2026-01-16-03-58-32-668_com example qr_scanner_practice](https://github.com/user-attachments/assets/13654c40-ffea-4afa-bd6c-282c2c9448e4)

