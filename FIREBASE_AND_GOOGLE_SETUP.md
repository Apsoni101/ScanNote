# Google API & Firebase Setup for CodiScan

Multi-environment (dev / uat / prod) + Firebase CLI

This document explains, step-by-step, how to configure Firebase and Google Cloud for Flutter app so it can:
- Sign users in with Google (via Firebase Authentication + google_sign_in), and
- Use the returned OAuth access token to call Google Sheets and Google Drive REST APIs (create spreadsheets, list spreadsheets, append rows).

## Contents

- [Overview & Prerequisites](#overview--prerequisites)
- [Firebase-First Workflow](#firebase-first-workflow)
- [Google Cloud (APIs Enabling)](#google-cloud-apis-enabling)
- [Platform Configuration](#platform-configuration)
- [Flutter Configuration](#flutter-configuration)
- [Sheets & Drive API Examples](#sheets--drive-api-examples)
- [Checklist & Testing Steps](#checklist--testing-steps)

## Overview & Prerequisites

You need:
- A Firebase project
- The app `applicationId` (Android) and `bundle identifier` (iOS)
- Android SHA-1 fingerprints (debug and release)
- Basic familiarity with Flutter project structure and adding Firebase config files

Tools / commands you will use:
- `keytool` (for Android SHA)
- `flutter pub get` and `pod install` (iOS)
- Google Cloud Console and Firebase Console UI

---

## 1) Create the Firebase Project

1. Go to https://console.firebase.google.com/
2. Click "Add project" and create a project (follow prompts)
   - This will create a Google Cloud project under the hood — we will use that same Cloud project for enabling APIs and consent screen

---

## 2) Enable APIs

Even though you started in Firebase, you still must enable the APIs in the underlying Google Cloud project for Sheets/Drive to accept requests from your OAuth client.

1. Open Google Cloud Console for the same project: https://console.cloud.google.com/ (select the same project used by your Firebase project)
2. Go to **APIs & Services** → **Library**
3. Enable:
   - Google Sheets API
   - Google Drive API

**Why:** If these APIs are not enabled on the Cloud Project that owns the OAuth clients, calls will return 403 / API not enabled.

---

## 3) OAuth Consent Screen (Cloud Console)

Because your app requests the Sheets & Drive scopes (sensitive scopes), OAuth consent screen configuration is required.

1. In Cloud Console → **APIs & Services** → **OAuth consent screen**:
   - **User Type:** External (typical) or Internal (only within G Suite org)
   - App name, support email, developer contact email
   - **Add Scopes:**
     - `https://www.googleapis.com/auth/spreadsheets`
     - `https://www.googleapis.com/auth/drive`
2. Save configuration

---

## 4) Add Android & iOS Apps in Firebase

Firebase Console → **Project settings** → **General** → **Your apps**

You will add **6 apps total**:
- 3 Android apps (DEV / UAT / PROD)
- 3 iOS apps (DEV / UAT / PROD)

### Android Apps

Firebase Console → Project settings → General → "Your apps":
- Add Android app:
  - Enter package name (different for uat, dev and prod)
    - DEV: `com.example.qr_scanner_practice.dev`
    - UAT: `com.example.qr_scanner_practice.uat`
    - PROD: `com.example.qr_scanner_practice`
  - Add at least the debug SHA-1 or SHA-256 (add release SHA before generating release apk)
  - Download `google-services.json`

### iOS Apps

- Add iOS app:
  - Enter bundle id (different for uat, dev and prod)
    - DEV: `com.example.qr_scanner_practice.dev`
    - UAT: `com.example.qr_scanner_practice.uat`
    - PROD: `com.example.qr_scanner_practice`
  - Download `GoogleService-Info.plist`

### Place Files

**Android:**
```
android/app/src/dev/google-services.json
android/app/src/uat/google-services.json
android/app/src/prod/google-services.json
```

**iOS:**
```
ios/config/dev/GoogleService-Info.plist
ios/config/uat/GoogleService-Info.plist
ios/config/prod/GoogleService-Info.plist
```
(Create `config` directory in `ios` if it doesn't exist)

---

## 7) Flutter Dependencies and pubspec

Add / verify dependencies in `pubspec.yaml`. Minimal relevant ones:

```yaml
dependencies:
  firebase_core: ^2.0.0
  firebase_auth: ^4.0.0
  google_sign_in: ^6.0.0
  dio: ^5.0.0
  dartz: ^0.10.1
```

Run:
```bash
flutter pub get
```

---

## 9) Using the Access Token with Dio

Your code builds Options with Authorization header:

```dart
Options(
  headers: <String, dynamic>{
    'Authorization': 'Bearer $token',
    'Content-Type': 'application/json',
  },
)
```

---

## 10) API Request Examples (curl + JSON)



### 1) List Owned Spreadsheets (Drive Query)

```bash
curl -H "Authorization: Bearer <ACCESS_TOKEN>" \
 "https://www.googleapis.com/drive/v3/files?q=mimeType%3D%27application%2Fvnd.google-apps.spreadsheet%27%20and%20%27me%27%20in%20owners%20and%20trashed%3Dfalse&fields=files(id,name,createdTime,modifiedTime,description,properties)&pageSize=100&orderBy=modifiedTime%20desc"
```

### 2) Create a New Spreadsheet (Sheets API)

The body matches your `createSheet()` payload:

```bash
curl -X POST -H "Authorization: Bearer <ACCESS_TOKEN>" -H "Content-Type: application/json" \
  -d '{
    "properties": {"title":"My App Sheet"},
    "sheets": [
      {
        "properties": {
          "sheetId": 0,
          "title": "Sheet1"
        },
        "data": [
          {
            "rowData":[
              {
                "values":[
                  {"userEnteredValue":{"stringValue":"TIMESTAMP"}},
                  {"userEnteredValue":{"stringValue":"QR_DATA"}},
                  {"userEnteredValue":{"stringValue":"COMMENT"}},
                  {"userEnteredValue":{"stringValue":"DEVICE_ID"}},
                  {"userEnteredValue":{"stringValue":"USER_ID"}}
                ]
              }
            ]
          }
        ]
      }
    ]
  }' \
  "https://sheets.googleapis.com/v4/spreadsheets"
```

This returns `spreadsheetId`.

### 3) Mark Spreadsheet in Drive File Properties (Patch)

Sets `properties.appCreated` and `description`:

```bash
curl -X PATCH -H "Authorization: Bearer <ACCESS_TOKEN>" -H "Content-Type: application/json" \
  -d '{
    "properties": {"appCreated":"CodiScan"},
    "description": "Created by CodiScan"
  }' \
  "https://www.googleapis.com/drive/v3/files/<SPREADSHEET_ID>?fields=properties"
```

### 4) Append a Row to the Sheet (Sheets API Append)

```bash
curl -X POST -H "Authorization: Bearer <ACCESS_TOKEN>" -H "Content-Type: application/json" \
  -d '{
    "values":[["2026-01-27T12:00:00Z","https://example.com","My comment","device-123","user-123"]]
  }' \
  "https://sheets.googleapis.com/v4/spreadsheets/<SHEET_ID>/values/Sheet1!A:E:append?valueInputOption=RAW"
```

---
## 11) Checklist (Firebase-first)

- [ ] Created Firebase project
- [ ] Added Android app (package name) in Firebase and uploaded debug & release SHA(s)
- [ ] Added iOS app (bundle id) in Firebase and added GoogleService-Info.plist to iOS project
- [ ] Downloaded and placed `google-services.json` into `android/app/`
- [ ] Downloaded and placed `GoogleService-Info.plist` into `ios/Runner/` and added to target
- [ ] Enabled Google Sign-In provider in Firebase Authentication (Auth → Sign-in method → Google)
- [ ] Enabled Google Sheets API and Google Drive API in the Google Cloud project linked to Firebase
- [ ] Configured OAuth consent screen (added Sheets & Drive scopes) and added your Google test accounts as Test users
- [ ] Confirmed OAuth client IDs exist in Cloud Console → APIs & Services → Credentials
- [ ] In app: `GoogleSignIn` configured with scopes:
  - `https://www.googleapis.com/auth/spreadsheets`
  - `https://www.googleapis.com/auth/drive`
- [ ] Code uses `Authorization: Bearer <ACCESS_TOKEN>` header for Sheets/Drive calls
- [ ] Tested create-sheet, list-sheets, and append row flows with test account

---
