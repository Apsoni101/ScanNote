# 📑 Index

- [📱 ScanNote](#-ScanNote)
- [Project Info 📱](#project-info-)
  - [Environments](#environments)
  - [Platform Support](#platform-support)
- [Setup & Configuration 🔧](#setup--configuration-)
  - [Firebase & Google Console Setup](#firebase--google-console-setup)
  - [Home Widget Setup](#home-widget-setup)

- [Installation Prerequisites ⚙️](#installation-prerequisites-)
  - [Development Tool Versions](#development-tool-versions)
  - [Quick Setup](#quick-setup)
  - [Running the App](#running-the-app)
- [Supported Versions](#supported-versions)
  - [Platform Version Requirements](#platform-version-requirements)
  - [Version Details](#version-details)
- [📸 App Screenshots](#-app-screenshots)
- [Features](#features)
- [Folder Structure Convention](#folder-structure-convention)
  - [Top-level directory layout](#top-level-directory-layout)
  - [Source files](#source-files)
- [Dependencies 📚](#dependencies-)


# 📱 ScanNote

A Flutter QR Scanner application that allows users to scan QR codes, view results, handle errors, and store scanned data in google sheets with scan data , device id , timestamp , userid .  
The app follows **Clean Architecture**, uses **BLoC** for state management, and supports **offline storage**. 

Note 1 :- when app has no internet it saves data locally and when connection restores it automatically syncs with remote google sheet in home screen also the list of google sheets is cached for offline access. 

Note 2 :- The app can only list the sheets that are created in app by user (done intentionally) .

---

# Project Info 📱

## Environments

The project operates in three environments:

| Environment | Description |
|-------------|-------------|
| **DEV** | Development environment |
| **UAT** | User Acceptance Testing environment |
| **PROD** | Production environment |

## Platform Support

The app is currently deployed on the following platforms:

- ✅ **iOS**
- ✅ **Android**

---
# Setup & Configuration 🔧

## Firebase & Google Console Setup

Before running the app, you need to configure Firebase and Google Console services. Follow the detailed setup guide:

📖 **[Firebase & Google Console Setup Guide](https://github.com/Apsoni101/qr_scanner_google_sheets/blob/main/FIREBASE_AND_GOOGLE_CONSOLE_SETUP.md)**

This guide covers:
- Firebase project setup
- Google Sheets API configuration
- Google Sign-In setup
- Platform-specific configurations (Android & iOS)

## Home Widget Setup 🧩

📖 **[Home Widget Setup Guide](https://github.com/Apsoni101/qr_scanner_google_sheets/blob/main/HOME_WIDGET_SETUP.md)**


---
# Installation Prerequisites ⚙️

Ensure you have the following installed:

- **Flutter SDK**
- **Android Studio** or **Visual Studio Code**
- **Xcode** (for iOS development)

## Development Tool Versions

| Tool | Version |
|------|---------|
| **JDK** | openjdk 17.0.17 |
| **Flutter** | 3.38.7 |
| **Dart** | 3.10.7 |
| **DevTools** | 2.51.1 |

## Quick Setup
```bash
# Verify Flutter installation
flutter --version

# Check Flutter doctor
flutter doctor

# Get dependencies
flutter pub get

# Run code generation
dart run build_runner build --delete-conflicting-outputs
```

## Running the App
```bash
# Run in DEV environment
flutter run --flavor dev

# Run in UAT environment
flutter run --flavor uat

# Run in PROD environment
flutter run --flavor prod
```

# Supported Versions

## Platform Version Requirements

| OS | Min Supported Version | Max Supported Version | Compile Version |
|----|----------------------|----------------------|-----------------|
| **Android** | 24 | 36 | 36 |
| **iOS** | 15.5 | 17.0 | 17.0 |

## Version Details

### Android
- **Minimum SDK**: 24 
- **Target SDK**: 36
- **Compile SDK**: 36

### iOS
- **Minimum Deployment Target**: 15.5
- **Maximum Supported**: 17.0
- **Xcode Compile Version**: 17.0


## 📸 App Screenshots

| Splash Screen | Auth Screen | Home Screen |
|------------|---------------|---------------|
| ![](https://github.com/user-attachments/assets/69f5acba-8f60-499f-87f5-791ad97e7dfd)  | ![](https://github.com/user-attachments/assets/0fa1559e-d5e8-4879-a948-4c75ba339b4c) | ![](https://github.com/user-attachments/assets/867e1d24-ac4f-48f2-891a-5043123d675d)|

| History Screen | Scanner Screen | Scan Result QR Screen |
|------------|---------------|---------------|
| ![](https://github.com/user-attachments/assets/6d1c520c-4a21-4614-b57d-219e99f26b40) | ![](https://github.com/user-attachments/assets/e9080c8f-5645-4b8d-836b-ebbde9d53f0b) | ![](https://github.com/user-attachments/assets/6592d89a-9561-48a0-aa39-bb4b7bef954b)|

| Ocr Screen | Scan Result OCR Screen | Scan Result OCR Screen |
|-------------|-------------|---------|
|  ![](https://github.com/user-attachments/assets/5bfcc2c1-e8cf-44b9-8d94-29d03134f9e9) | ![](https://github.com/user-attachments/assets/633ea649-b5f0-4a8d-8d3e-286875f407e7) | ![](https://github.com/user-attachments/assets/d728c5cb-c211-41dd-ac0b-e6c3753a41f1) | 


| Sheet Selection Screen | Sheet Selection Screen | Sheet Selection Screen |
|-------------|-------------|---------|
| ![](https://github.com/user-attachments/assets/0bfc2b43-63a6-4156-923f-52f41a7d733f)| ![](https://github.com/user-attachments/assets/d9d8bc2f-ca2e-42f3-a036-03763c694946) | ![](https://github.com/user-attachments/assets/6ebc197f-cf68-48ca-90c9-ce3ccb2dfe6f) |



| Sheet Selection Screen | Settings Screen | Settings Screen |
|-------------|-------------|---------|
| ![](https://github.com/user-attachments/assets/b5b6c779-910a-4ef0-b9e5-8b2d207a1d01)| ![](https://github.com/user-attachments/assets/90a8c5f7-6473-4773-87b8-844c39a17f5d) | ![](https://github.com/user-attachments/assets/ed5122f0-db2e-4035-9b87-1e9f705976bc) |


### Home Widget 

<p align="center">
  <img src="https://github.com/user-attachments/assets/4649e40c-c639-434a-9bf0-3ad2d6706a45"
       width="360"
       height="780"
       alt="Sheet Selection Screen" />
</p>

---


# Features

| Feature | Sub Features | Status |
|---------|-------------|--------|
| **Authentication** | • Google Sign In/Sign Up scren<br>• User Session Management | ✅ |
| **Home Dashboard** | • Sync Status Banner<br>• Choose option qr scan or extract text(ocr)<br>• Recent Activity Overview<br>• Sync Management | ✅ |
| **QR Code Scanner** | • Real-time QR Scanning<br>• Flash Toggle<br>• Image Picker for QR<br>• Scanner Overlay | ✅ |
| **OCR (Text Recognition)** | • Image to Text Conversion<br>• Camera Capture<br>• Image Selection<br>• Text Extraction | ✅ |
| **Scan Results** | • View Scanned Data<br>• Add Comments<br>• Preview Images<br> | ✅ |
| **Sheet Selection and creation** | • Create New Sheets<br>• Select Existing Sheets<br>• View Sheet List<br>• Save Scanned Data to Sheets<br>• Google Sheets Integration | ✅ |
| **Scan History** | • View All Scans history<br> | ✅ |
| **Settings** | • Theme Toggle (Light/Dark)<br>• Language Selection (English/Hindi)<br>• User Profile Management<br>• App Information<br>• About Section(Privacy policy , terms of service , help and support) | ✅ |
| **Localization** | • Multi-language Support<br>• English & Hindi Languages<br>• Dynamic Language Switching | ✅ |
| **Offline Support** | • Local Data Storage (Hive)<br>• Pending Sync Queue<br>• Offline Mode Detection<br>• Auto-sync on Connection | ✅ |
| **Theming** | • Light Theme<br>• Dark Theme<br>• Theme Persistence | ✅ |








# Folder Structure Convention

## Top-level directory layout
```
.
├── android/
├── assets/
├── build/
├── ios/
├── lib/
└── test/
```






# Source files 
```
lib/
├── core/
│   ├── app_theming/
│   │   ├── app_color_theme_extension.dart
│   │   ├── app_dark_theme_colors.dart
│   │   └── app_light_theme_colors.dart
│   ├── constants/
│   │   ├── app_constants.dart
│   │   ├── app_textstyles.dart
│   │   └── asset_constants.dart
│   ├── controller/
│   │   └── app_settings_controller.dart
│   ├── di/
│   │   └── app_injector.dart
│   ├── enums/
│   │   ├── language_enum.dart
│   │   └── result_type.dart
│   ├── extensions/
│   │   ├── context_extensions.dart
│   │   ├── date_time_extension.dart
│   │   ├── string_extensions.dart
│   │   └── theme_extensions.dart
│   ├── firebase/
│   │   └── firebase_auth_service.dart
│   ├── local_storage/
│   │   ├── hive_key_constants.dart
│   │   └── hive_service.dart
│   ├── localisation/
│   │   ├── app_localizations.dart
│   │   ├── app_localizations_en.dart
│   │   ├── app_localizations_hi.dart
│   │   ├── intl_en.arb
│   │   └── intl_hi.arb
│   ├── navigation/
│   │   ├── router/
│   │   │   ├── auth_router.dart
│   │   │   └── dashboard_router.dart
│   │   ├── routes/
│   │   │   ├── no_bottom_nav_bar_routes.dart
│   │   │   └── with_bottom_nav_bar_routes.dart
│   │   ├── app_router.dart
│   │   ├── app_router.gr.dart
│   │   ├── auth_guard.dart
│   │   └── route_paths.dart
│   └── network/
│       ├── constants/
│       │   └── network_constants.dart
│       └── interceptors/
│           ├── api_log_interceptor.dart
│           ├── failure.dart
│           ├── http_api_client.dart
│           ├── http_method.dart
│           └── http_network_service.dart
├── services/
│   ├── connectivity_service.dart
│   ├── device_info_service.dart
│   ├── image_picker_service.dart
│   └── ocr_service.dart
└── feature/
    ├── auth/
    │   ├── data/
    │   │   ├── data_sources/
    │   │   │   └── google_sign_in_sign_up_remote_datasource.dart
    │   │   ├── models/
    │   │   │   └── user_model.dart
    │   │   └── repositories/
    │   │       └── google_sign_in_sign_up_remote_repo_impl.dart
    │   ├── domain/
    │   │   ├── entities/
    │   │   │   └── user_entity.dart
    │   │   ├── repositories/
    │   │   │   └── google_sign_in_sign_up_remote_repo.dart
    │   │   └── use_cases/
    │   │       └── google_sign_in_sign_up_remote_usecase.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── google_sign_in_sign_up_bloc.dart
    │       │   ├── google_sign_in_sign_up_event.dart
    │       │   └── google_sign_in_sign_up_state.dart
    │       └── screens/
    │           └── google_sign_in_sign_up_screen.dart
    ├── dashboard/
    │   └── presentation/
    │       ├── screens/
    │       │   └── dashboard_screen.dart
    │       └── widgets/
    │           └── bottom_nav_icon.dart
    ├── home/
    │   ├── data/
    │   │   ├── data_source/
    │   │   │   ├── home_screen_local_data_source.dart
    │   │   │   └── home_screen_remote_data_source.dart
    │   │   └── repo_impl/
    │   │       └── home_screen_repository_impl.dart
    │   ├── domain/
    │   │   ├── repo/
    │   │   │   └── home_screen_repository.dart
    │   │   └── use_case/
    │   │       └── home_screen_use_case.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── home_screen_bloc.dart
    │       │   ├── home_screen_event.dart
    │       │   └── home_screen_state.dart
    │       ├── screen/
    │       │   └── home_screen.dart
    │       └── widgets/
    │           ├── banner_container.dart
    │           ├── home_screen_app_bar.dart
    │           ├── sync_button.dart
    │           └── sync_status_banner.dart
    ├── ocr/
    │   ├── data/
    │   │   ├── data_source/
    │   │   │   └── ocr_data_source.dart
    │   │   ├── model/
    │   │   │   └── ocr_result_model.dart
    │   │   └── repo_impl/
    │   │       └── ocr_repo_impl.dart
    │   ├── domain/
    │   │   ├── entity/
    │   │   │   └── ocr_result_entity.dart
    │   │   ├── repo/
    │   │   │   └── ocr_repo.dart
    │   │   └── use_case/
    │   │       └── ocr_use_case.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── ocr_bloc.dart
    │       │   ├── ocr_event.dart
    │       │   └── ocr_state.dart
    │       ├── screen/
    │       │   └── ocr_screen.dart
    │       └── widgets/
    │           └── ocr_screen_content_view.dart
    ├── qr_scan/
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── qr_scanning_bloc.dart
    │       │   ├── qr_scanning_event.dart
    │       │   └── qr_scanning_state.dart
    │       ├── screen/
    │       │   └── qr_scanner_screen.dart
    │       └── widgets/
    │           ├── qr_flash_toggle_button.dart
    │           ├── qr_image_picker_button.dart
    │           ├── qr_scan_instruction_text.dart
    │           ├── qr_scanner_app_bar.dart
    │           └── qr_scanner_overlay.dart
    ├── scan_result/
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── result_bloc.dart
    │       │   ├── result_event.dart
    │       │   └── result_state.dart
    │       ├── screen/
    │       │   └── scan_result_screen.dart
    │       └── widgets/
    │           ├── comment_input_card.dart
    │           ├── ocr_preview_image.dart
    │           ├── scan_result_section.dart
    │           └── section_title.dart
    ├── settings/
    │   ├── data/
    │   │   ├── data_source/
    │   │   │   ├── settings_local_data_source.dart
    │   │   │   └── settings_remote_data_source.dart
    │   │   └── repo_impl/
    │   │       └── settings_repository_impl.dart
    │   ├── domain/
    │   │   ├── repo/
    │   │   │   └── settings_repository.dart
    │   │   └── use_case/
    │   │       └── settings_usecase.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── settings_bloc.dart
    │       │   ├── settings_event.dart
    │       │   └── settings_state.dart
    │       ├── screen/
    │       │   └── settings_screen.dart
    │       └── widgets/
    │           ├── language_selection_dialog.dart
    │           ├── settings_about_text_button_tile.dart
    │           ├── settings_action_tile.dart
    │           ├── settings_app_info_tile.dart
    │           ├── settings_theme_switch.dart
    │           └── settings_user_info_tile.dart
    ├── sheet_selection/
    │   ├── data/
    │   │   ├── data_source/
    │   │   │   ├── sheet_selection_local_data_source.dart
    │   │   │   └── sheet_selection_remote_data_source.dart
    │   │   ├── model/
    │   │   │   ├── pending_sync_model.dart
    │   │   │   ├── pending_sync_model.g.dart
    │   │   │   ├── scan_result_model.dart
    │   │   │   ├── scan_result_model.g.dart
    │   │   │   ├── sheet_model.dart
    │   │   │   └── sheet_model.g.dart
    │   │   └── repo_impl/
    │   │       └── sheet_selection_repository_impl.dart
    │   ├── domain/
    │   │   ├── entity/
    │   │   │   ├── pending_sync_entity.dart
    │   │   │   ├── result_scan_entity.dart
    │   │   │   └── sheet_entity.dart
    │   │   ├── repo/
    │   │   │   └── sheet_selection_repository.dart
    │   │   └── use_case/
    │   │       └── sheet_selection_use_case.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── sheet_selection_bloc.dart
    │       │   ├── sheet_selection_event.dart
    │       │   └── sheet_selection_state.dart
    │       ├── screen/
    │       │   └── sheet_selection_screen.dart
    │       └── widget/
    │           ├── create_new_sheet_button_and_form.dart
    │           ├── existing_sheets_view_builder_and_selector.dart
    │           ├── save_to_sheet_button.dart
    │           └── scanned_data_preview.dart
    ├── splash/
    │   └── presentation/
    │       ├── screens/
    │       │   └── splash_screen.dart
    │       └── widgets/
    │           ├── splash_appear_animation.dart
    │           └── splash_logo_container.dart
    ├── view_scan_history/
    │   ├── data/
    │   │   ├── data_source/
    │   │   │   └── view_scans_history_remote_data_source.dart
    │   │   └── repo_impl/
    │   │       └── view_scans_history_remote_repository_impl.dart
    │   ├── domain/
    │   │   ├── repo/
    │   │   │   └── view_scans_history_remote_repository.dart
    │   │   └── use_case/
    │   │       └── view_scans_history_remote_use_case.dart
    │   └── presentation/
    │       ├── bloc/
    │       │   ├── view_scans_history_screen_bloc.dart
    │       │   ├── view_scans_history_screen_event.dart
    │       │   └── view_scans_history_screen_state.dart
    │       ├── screen/
    │       │   └── view_scans_history_screen.dart
    │       └── widget/
    │           ├── history_card_item.dart
    │           ├── history_empty_view.dart
    │           ├── history_error_view.dart
    │           └── history_search_bar.dart
    └── common/
        └── presentation/
            └── widgets/
                ├── common_app_bar.dart
                ├── common_loading_view.dart
                ├── decorated_svg_asset_icon_container.dart
                ├── elevated_icon_button.dart
                ├── elevated_svg_icon_button.dart
                ├── error_or_empty_message_container.dart
                ├── on_screen_option_item_card.dart
                ├── outlined_icon_button.dart
                ├── padded_text.dart
                └── rounded_corner_elevated_card.dart
```












## Dependencies 📚

Below is the list of main dependencies used in this project along with their purpose.

- [Flutter Bloc](https://pub.dev/packages/flutter_bloc)  State management solution for Flutter using the BLoC pattern used in app.

- [Auto Route](https://pub.dev/packages/auto_route)  Type-safe and declarative routing for Flutter apps and  Flutter navigation with strongly-typed argument passing used in app.

- [Dio](https://pub.dev/packages/dio)  Powerful HTTP networking package for Dart/Flutter used for making API requests.

- [Dartz](https://pub.dev/packages/dartz)  Functional programming helpers like `Either` for better error handling in app.

- [Equatable](https://pub.dev/packages/equatable)  Simplifies value comparison for Dart objects in apps .

- [Get It](https://pub.dev/packages/get_it)  Dependency injection for managing app-wide services.

- [Firebase Core](https://pub.dev/packages/firebase_core)  Initializes Firebase services in the Flutter app.

- [Firebase Auth](https://pub.dev/packages/firebase_auth)  User authentication using Firebase for google auth in app.

- [Google Sign In](https://pub.dev/packages/google_sign_in)  Enables Google authentication in app provides credentials.

- [Device Info Plus](https://pub.dev/packages/device_info_plus)  Fetches device-related information and used for getting device id in app.

- [Connectivity Plus](https://pub.dev/packages/connectivity_plus)  Checks network connectivity status in Flutter apps.

- [Hive Flutter](https://pub.dev/packages/hive_flutter)  Lightweight and fast local database better than sqlite faster access stores in key value pairs.

- [Flutter SVG](https://pub.dev/packages/flutter_svg)  Renders SVG images in Flutter.

- [Image Picker](https://pub.dev/packages/image_picker)  Picks images from gallery or camera.

- [Mobile Scanner](https://pub.dev/packages/mobile_scanner)  Barcode and QR code scanning in app .

- [Google ML Kit – Text Recognition](https://pub.dev/packages/google_mlkit_text_recognition)  Extracts text from images using ML Kit for ocr feature in app.






