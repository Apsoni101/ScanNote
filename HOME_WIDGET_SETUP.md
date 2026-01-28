# iOS & Android Widget Setup Guide

## Table of Contents
- [Android Home Screen Widget Setup](#android-home-screen-widget-setup)
- [iOS Home Screen Widget Setup](#ios-home-screen-widget-setup)
- [Flutter Integration](#flutter-integration)

---

## Android Home Screen Widget Setup

### Creating a Basic Android Widget

To add a Home Screen widget in Android, open the project's build file in Android Studio.

#### Initial Setup Steps

1. **Open Android Studio**
   - Locate and open `android/build.gradle`
   - Alternatively, right-click on the `android` folder from VSCode and select **Open in Android Studio**

2. **Add Widget to App Directory**
   - After the project builds, locate the `app` directory in the top-left corner
   - Right-click the directory
   - Select **New → Widget → App Widget**

3. **Configure Widget**
   - Android Studio displays a new form
   - Add basic information about your Home Screen widget:
     - Class name
     - Placement
     - Size
     - Source language

<img width="1152" height="977" alt="image" src="https://github.com/user-attachments/assets/36e61e88-25c0-4b5f-9200-0e110bce9366" />


#### Files Modified by Android Studio

| Action | Target File | Change |
|--------|-------------|--------|
| Update | `AndroidManifest.xml` | Adds a new receiver which registers the NewsWidget |
| Create | `res/layout/news_widget.xml` | Defines Home Screen widget UI |
| Create | `res/xml/news_widget_info.xml` | Defines your Home Screen widget configuration (adjust dimensions or name here) |
| Create | `java/com/example/homescreen_widgets/NewsWidget.kt` | Contains Kotlin code to add functionality to your widget |

---

## Setting Up QR Scanner Widget (Advanced Android used in codiscan)

### 1. Create Widget Provider Class

**Location:** `android/app/src/main/java/com/example/qr_scanner_practice/QrScanWidget.kt`

#### Key Components Explained

- **`onUpdate()`** - Called when the widget needs to be updated (on creation, on interval, or manually)
- **`HomeWidgetLaunchIntent.getActivity()`** - Creates an intent to launch your Flutter app when widget is clicked
- **`RemoteViews`** - Creates the UI for the widget using the layout file
- **`Uri.parse("qrScan://open")`** - Deep link that can be handled in your Flutter app to open specific screen
- **`setOnClickPendingIntent()`** - Makes the entire widget clickable with the defined intent

#### Code Implementation

```kotlin
package com.example.qr_scanner_practice

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.widget.RemoteViews
import android.net.Uri
import es.antonborri.home_widget.HomeWidgetLaunchIntent

class QrScanWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {

            val views = RemoteViews(
                context.packageName,
                R.layout.qr_scan_widget
            )

            // Make entire widget clickable
            val intent = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse("qrScan://open")
            )
            views.setOnClickPendingIntent(R.id.widget_root, intent)

            appWidgetManager.updateAppWidget(appWidgetId, views)
        }
    }
}
```

---

### 2. Create Widget Info XML

**Location:** `android/app/src/main/res/xml/qr_scan_widget_info.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<appwidget-provider xmlns:android="http://schemas.android.com/apk/res/android"
    android:description="@string/app_widget_description"
    android:initialLayout="@layout/qr_scan_widget"
    android:minWidth="110dp"
    android:minHeight="110dp"
    android:resizeMode="horizontal|vertical"
    android:targetCellWidth="2"
    android:targetCellHeight="2"
    android:updatePeriodMillis="0"
    android:widgetCategory="home_screen" />
```

---

### 3. Create Widget Layout

**Location:** `android/app/src/main/res/layout/qr_scan_widget.xml`

```xml
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/widget_root"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="@drawable/app_widget_bg"
    android:padding="16dp">


    <!-- QR SCAN ICON -->
    <ImageView
        android:id="@+id/imgScan"
        android:layout_width="48dp"
        android:layout_height="48dp"
        android:layout_gravity="start|top"
        android:padding="10dp"
        android:background="@drawable/bg_qr_circle"
        android:src="@drawable/qr_code"
        android:tint="@android:color/white" />

    <!-- APP LOGO -->
    <ImageView
        android:id="@+id/imgAppLogo"
        android:layout_width="44dp"
        android:layout_height="44dp"
        android:layout_gravity="end|top"
        android:src="@drawable/app_logo"
        android:tint="@android:color/transparent" />


    <!-- TEXT CONTAINER -->
    <LinearLayout
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:layout_gravity="start|bottom"
        android:orientation="vertical">

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Scan QR Codes."
            android:textColor="#CCFFFFFF"
            android:textSize="12sp" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Store Securely."
            android:textColor="#CCFFFFFF"
            android:textSize="12sp" />

        <TextView
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Google Sheets Ready."
            android:textColor="@android:color/white"
            android:textSize="13sp"
            android:textStyle="bold" />
    </LinearLayout>

</FrameLayout>
```

---

### 4. Update AndroidManifest.xml

> **Note:** This will be added automatically if you add the `QrScanWidget` class using **New → Widget → App Widget** in the Android directory.

Add the widget receiver inside the `<application>` tag:

```xml
<receiver
    android:name=".QrScanWidget"
    android:exported="true">
    <intent-filter>
        <action android:name="android.appwidget.action.APPWIDGET_UPDATE" />
    </intent-filter>
    <meta-data
        android:name="android.appwidget.provider"
        android:resource="@xml/qr_scan_widget_info" />
</receiver>
```

---

### 5. Required Resources

Ensure you have the following drawable resources in `android/app/src/main/res/drawable/`:

- `app_widget_bg.xml` or `app_widget_bg.png` - Widget background
- `bg_qr_circle.xml` - Circular background for QR icon
- `qr_code.xml` or `qr_code.png` - QR code icon
- `app_logo.xml` or `app_logo.png` - App logo

---

### 6. Add String Resource

Add to `android/app/src/main/res/values/strings.xml`:

```xml
<string name="app_widget_description">Quick access to QR Scanner</string>
```

---

## iOS Home Screen Widget Setup

### Creating a Basic iOS Home Screen Widget

Adding an app extension to your Flutter iOS app is similar to adding an app extension to a SwiftUI or UIKit app.

#### Steps to Create Widget Extension

1. **Open Xcode Workspace**
   - Run `open ios/Runner.xcworkspace` in a terminal window from your Flutter project directory
   - Alternatively, right-click on the `ios` folder from VSCode and select **Open in Xcode**
   - This opens the default Xcode workspace in your Flutter project

2. **Add New Target**
   - Select **File → New → Target** from the menu
   - This adds a new target to the project

3. **Select Widget Template**
   - A list of templates appears
   - Select **Widget Extension**

4. **Configure Widget**
   - Type "QrScanWidget" into the **Product Name** box for this widget
   - Clear the following checkboxes:
     - **Include Live Activity**
     - **Include Control**
     - **Include Configuration Intent**

<img width="2025" height="1153" alt="Screenshot 2026-01-28 at 10 30 29 AM" src="https://github.com/user-attachments/assets/f4b4c90f-a663-4359-91d4-80ce2a171978" />


## Setting Up QR Scanner Widget (Advanced iOS)

### 1. Understanding the Widget Structure

**Location:** `ios/QrScanWidget/QrScanWidget.swift`

> **Boilerplate you'll get:** When you create a widget extension in Xcode, you'll automatically receive a template file with the basic widget structure. You need to customize this to handle interactions and design.

#### Key Components to Customize

**Provider (TimelineProvider Protocol)**
- `placeholder()` - Shows a placeholder view while the widget is loading
- `getSnapshot()` - Provides a snapshot for the widget gallery
- `getTimeline()` - Defines when and how the widget should update

**SimpleEntry**
- Conforms to `TimelineEntry` protocol
- Contains data that the widget view will display
- Must include a `date` property

**QrScanWidgetEntryView**
- SwiftUI view that defines the widget's visual appearance
- This is where you design your widget UI
- Add `.widgetURL()` modifier to enable deep linking

**Widget Configuration**
- Use `StaticConfiguration` for non-configurable widgets
- Set `.configurationDisplayName()` - shown in widget gallery
- Set `.description()` - describes widget functionality
- Set `.supportedFamilies()` - defines widget sizes (`.systemSmall`, `.systemMedium`, `.systemLarge`)
- Use `.contentMarginsDisabled()` to remove default padding

---

### 2. Implementing Deep Linking

Add the `.widgetURL()` modifier to your widget view:

```swift
.widgetURL(URL(string: "qrscan://open"))
```

This enables the entire widget to be tappable and will launch your Flutter app with the deep link URL.

---

### 3. Required Assets for iOS Widget

Add assets to your widget's asset catalog (`Assets.xcassets`):

- **app_logo** - Your app's logo image (recommended size: 44x44 points @2x, 66x66 points @3x)

> **Note:** For system icons, use SF Symbols (e.g., `Image(systemName: "qrcode")`) which are built into iOS.

---

### 4. Widget Configuration Properties

Set these properties in your `Widget` body:

| Property | Example Value | Purpose |
|----------|---------------|---------|
| `.configurationDisplayName()` | "QR Scanner" | Name shown in widget gallery |
| `.description()` | "Scan QR codes and store them securely" | Description in widget gallery |
| `.supportedFamilies()` | `[.systemSmall]` | Supported widget sizes |
| `.contentMarginsDisabled()` | N/A | Removes default widget padding |

---

### 5. Design Customization Tips

When customizing your widget view, consider:

- **Background** - Use `LinearGradient` or solid colors
- **Layout** - Use `ZStack`, `VStack`, `HStack` for positioning
- **Icons** - Use SF Symbols (`Image(systemName:)`) and  custom image appLogo
- **Text** - Customize with `.font()`, `.foregroundColor()`, `.lineLimit()`
- **Shapes** - Add visual effects with `Circle()`, `RoundedRectangle()`, etc.
- **Corner Radius** - Use `.clipShape(RoundedRectangle(cornerRadius: 16))` for rounded widget
- **Spacing** - Control with `.padding()` and `spacing` parameters

---

### 6. iOS Version Compatibility

Handle different iOS versions in your widget configuration because less than ios 17 doesnt support preview :

```swift
if #available(iOS 17.0, *) {
    YourWidgetView(entry: entry)
        .containerBackground(.fill.secondary, for: .widget)
} else {
    YourWidgetView(entry: entry)
        .padding()
        .background()
}
```

---

## Flutter Integration

### Listening for Widget Launches

**Purpose:** Detect if the app was launched from a home screen widget and handle navigation.

#### Setup in Initial Screen

Add this method to your initial screen (e.g., SplashScreen or main screen):

```dart
Future<void> _handleWidgetLaunch() async {
  final Uri? uri = await HomeWidget.initiallyLaunchedFromHomeWidget();

  if (uri?.scheme == 'qrScan' && mounted) {
    // Navigate to QR scanning screen
    // Example: context.router.push(const QrScanningRoute());
  }
}
```

> **Important:** Call this method in `initState()` or after initial setup.

---

### Create Route Paths Constant

**Location:** `lib/core/navigation/route_paths.dart`

```dart
class RoutePaths {
  static const String qrScan = 'qrScan';
  // ... other route paths
}
```

---

### How the Widget Launch Flow Works

1. **User Action** - User taps the home screen widget
2. **Deep Link Sent** - Android widget sends deep link: `qrScan://open`
3. **App Launches** - Flutter app launches
4. **URI Retrieved** - `HomeWidget.initiallyLaunchedFromHomeWidget()` returns the URI
5. **Scheme Check** - App checks if `uri.scheme == 'qrScan'`
6. **Navigation** - Navigate to appropriate screen based on the URI scheme

---

## Summary

This guide covers the complete setup for both iOS and Android home screen widgets, including:

- Basic widget creation steps for both platforms
- Advanced QR Scanner widget implementation for Android
- Flutter integration for handling widget launches
- Deep linking configuration
- Required resources and configurations

Make sure to test the widget on both platforms after implementation to ensure proper functionality.
