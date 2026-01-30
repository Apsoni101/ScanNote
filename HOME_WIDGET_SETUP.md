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
| Create | `res/layout/qr_scan_widget.xml` | Defines Home Screen widget UI |
| Create | `res/xml/qr_scan_widget_info.xml` | Defines your Home Screen widget configuration (adjust dimensions or name here) |
| Create | `java/com/scanote/app/QrScanWidget.kt` | Contains Kotlin code to add functionality to your widget |

---

## Setting Up QR Scanner Widget (Advanced Android)

### 1. Create Widget Provider Class

**Location:** `android/app/src/main/java/com/scannote/app/QrScanWidget.kt`

#### Key Components Explained

- **`onUpdate()`** - Called when the widget needs to be updated (on creation, on interval, or manually)
- **`Intent.ACTION_VIEW`** - Creates an intent to open a specific URL scheme
- **`RemoteViews`** - Creates the UI for the widget using the layout file
- **`Uri.parse("qrscan://open?action=scan")`** - Deep link that will be handled by MainActivity
- **`setOnClickPendingIntent()`** - Makes the entire widget clickable with the defined intent
- **`PendingIntent.FLAG_IMMUTABLE`** - Required for Android 12+ (API 31+) for security

#### Code Implementation

```kotlin
package com.scannote.app

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.widget.RemoteViews

class QrScanWidget : AppWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    private fun updateAppWidget(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetId: Int
    ) {
        val views = RemoteViews(context.packageName, R.layout.qr_scan_widget)

        val intent = Intent(Intent.ACTION_VIEW).apply {
            data = Uri.parse("qrscan://open?action=scan")
            flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
            setClass(context, MainActivity::class.java)
        }

        val pendingIntent = PendingIntent.getActivity(
            context,
            0,
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        views.setOnClickPendingIntent(R.id.widget_root, pendingIntent)

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }
}
```

---

### 2. Update MainActivity with MethodChannel

**Location:** `android/app/src/main/java/com/scannote/app/MainActivity.kt`

#### Key Components Explained

- **`companion object`** - Static storage for widgetUrl accessible across activity instances
- **`handleIntent()`** - Extracts the deep link URL from the intent
- **`onNewIntent()`** - Called when the app is already running and a new intent arrives
- **`MethodChannel`** - Bridge between Flutter and Android native code
- **`setMethodCallHandler`** - Handles method calls from Flutter side

#### Code Implementation

```kotlin
package com.scannote.app

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.scannote.app/widget"

    companion object {
        var widgetUrl: String? = null
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        handleIntent(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        handleIntent(intent)
    }

    private fun handleIntent(intent: Intent?) {
        val data = intent?.data
        if (data != null) {
            widgetUrl = data.toString()
        }
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "getWidgetUrl" -> {
                    result.success(widgetUrl)
                }

                "clearWidgetUrl" -> {
                    widgetUrl = null
                    result.success(null)
                }

                else -> result.notImplemented()
            }
        }
    }
}
```

---

### 3. Add Deep Link Intent Filter to AndroidManifest.xml

**Location:** `android/app/src/main/AndroidManifest.xml`

Add the following inside the `<activity>` tag for MainActivity:

```xml
<intent-filter>
    <action android:name="android.intent.action.VIEW" />
    <category android:name="android.intent.category.DEFAULT" />
    <category android:name="android.intent.category.BROWSABLE" />
    
    <data
        android:scheme="qrscan"
        android:host="open" />
</intent-filter>
```

Also add the widget receiver inside the `<application>` tag:

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

### 4. Create Widget Info XML

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

### 5. Create Widget Layout

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

### 6. Required Resources

Ensure you have the following drawable resources in `android/app/src/main/res/drawable/`:

- `app_widget_bg.xml` or `app_widget_bg.png` - Widget background
- `bg_qr_circle.xml` - Circular background for QR icon
- `qr_code.xml` or `qr_code.png` - QR code icon
- `app_logo.xml` or `app_logo.png` - App logo

---

### 7. Add String Resource

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

<img width="2025" height="1153" alt="Screenshot 2026-01-28 at 10 30 29 AM" src="https://github.com/user-attachments/assets/f4b4c90f-a663-4359-91d4-80ce2a171978" />

---

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

### 3. Configure URL Scheme in Widget's Info.plist

**Location:** `ios/QrScanWidget/Info.plist`

Add the URL scheme configuration:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>NSExtension</key>
        <dict>
            <key>NSExtensionPointIdentifier</key>
            <string>com.apple.widgetkit-extension</string>
        </dict>
        <key>CFBundleURLTypes</key>
        <array>
            <dict>
                <key>CFBundleTypeRole</key>
                <string>Editor</string>
                <key>CFBundleURLName</key>
                <string>com.scannote.app</string>
                <key>CFBundleURLSchemes</key>
                <array>
                    <string>qrscan</string>
                </array>
            </dict>
        </array>
    </dict>
</plist>
```

---

### 4. Update AppDelegate with MethodChannel

**Location:** `ios/Runner/AppDelegate.swift`

#### Key Components Explained

- **`didFinishLaunchingWithOptions`** - Called when app launches, captures initial URL if launched from widget
- **`open url`** - Called when app receives a URL while running
- **`setupMethodChannel()`** - Creates the Flutter-iOS communication bridge
- **`FlutterMethodChannel`** - Handles method calls from Flutter
- **`[weak self]`** - Prevents memory leaks in closures

#### Code Implementation

```swift
import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var widgetUrl: String?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        GeneratedPluginRegistrant.register(with: self)

        setupMethodChannel()

        if let url = launchOptions?[.url] as? URL {
            widgetUrl = url.absoluteString
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func application(
        _ application: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {

        widgetUrl = url.absoluteString

        return true
    }

    private func setupMethodChannel() {
        guard let controller = window?.rootViewController as? FlutterViewController else {
            return
        }

        let channel = FlutterMethodChannel(
            name: "com.scannote.app/widget",
            binaryMessenger: controller.binaryMessenger
        )

        channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
            guard let self = self else {
                result(FlutterError(code: "UNAVAILABLE", message: "Self is nil", details: nil))
                return
            }

            switch call.method {
            case "getWidgetUrl":
                result(self.widgetUrl)

            case "clearWidgetUrl":
                self.widgetUrl = nil
                result(nil)

            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }
}
```

---

### 5. Configure URL Scheme in Runner's Info.plist

**Location:** `ios/Runner/Info.plist`

Ensure the `CFBundleURLTypes` array includes the `qrscan` scheme. If you already have Google Sign-In schemes, add the `qrscan` scheme to a new dictionary in the array:

```xml
<key>CFBundleURLTypes</key>
<array>
    <!-- Existing Google Sign-In schemes -->
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>com.googleusercontent.apps.597710711272-mslilj7vkikreht7ibp5q0vt7c11imu0</string>
            <string>com.googleusercontent.apps.597710711272-bs501ppddi6o1v2d9hdtijf2vaed707m</string>
            <string>com.googleusercontent.apps.597710711272-7s6pm0i034p5j1337vcga6hid38bjuih</string>
        </array>
    </dict>
    
    <!-- QR Scan Widget Deep Link -->
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>qrscan</string>
        </array>
    </dict>
</array>
```

---

### 6. Required Assets for iOS Widget

Add assets to your widget's asset catalog (`Assets.xcassets`):

- **app_logo** - Your app's logo image (recommended size: 44x44 points @2x, 66x66 points @3x)

> **Note:** For system icons, use SF Symbols (e.g., `Image(systemName: "qrcode")`) which are built into iOS.

---

### 7. Widget Configuration Properties

Set these properties in your `Widget` body:

| Property | Example Value | Purpose |
|----------|---------------|---------|
| `.configurationDisplayName()` | "QR Scanner" | Name shown in widget gallery |
| `.description()` | "Scan QR codes and store them securely" | Description in widget gallery |
| `.supportedFamilies()` | `[.systemSmall]` | Supported widget sizes |
| `.contentMarginsDisabled()` | N/A | Removes default widget padding |

---

### 8. Design Customization Tips

When customizing your widget view, consider:

- **Background** - Use `LinearGradient` or solid colors
- **Layout** - Use `ZStack`, `VStack`, `HStack` for positioning
- **Icons** - Use SF Symbols (`Image(systemName:)`) and custom image appLogo
- **Text** - Customize with `.font()`, `.foregroundColor()`, `.lineLimit()`
- **Shapes** - Add visual effects with `Circle()`, `RoundedRectangle()`, etc.
- **Corner Radius** - Use `.clipShape(RoundedRectangle(cornerRadius: 16))` for rounded widget
- **Spacing** - Control with `.padding()` and `spacing` parameters

---

### 9. iOS Version Compatibility

Handle different iOS versions in your widget configuration:

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

### 1. Create Widget URL Service

**Location:** `lib/core/services/widget_url_service.dart`

#### Key Components Explained

- **`MethodChannel`** - Creates communication channel with native code
- **`invokeMethod<String>`** - Calls native method and expects String return type
- **`getWidgetUrl()`** - Retrieves the deep link URL from native side
- **`clearWidgetUrl()`** - Clears the stored URL after handling

#### Code Implementation

```dart
import 'package:flutter/services.dart';

class WidgetUrlService {
  static const MethodChannel _channel = MethodChannel(
    'com.scannote.app/widget',
  );

  Future<String?> getWidgetUrl() async {
    try {
      final String? url = await _channel.invokeMethod<String>('getWidgetUrl');
      return url;
    } catch (e) {
      return null;
    }
  }

  Future<void> clearWidgetUrl() async {
    try {
      await _channel.invokeMethod<void>('clearWidgetUrl');
    } catch (e) {
      return;
    }
  }
}
```

---

### 2. Create Route Paths Constant

**Location:** `lib/core/navigation/route_paths.dart`

```dart
class RoutePaths {
  static const String qrScan = 'qrscan';
  // ... other route paths
}
```

---

### 3. Handle Widget Launch in Splash Screen

**Location:** `lib/feature/splash/presentation/splash_screen.dart`

#### Key Components Explained

- **`_widgetUrlService.getWidgetUrl()`** - Retrieves URL from native side via MethodChannel
- **`Uri.tryParse()`** - Safely parses URL string into Uri object
- **`widgetUri?.scheme`** - Extracts the URL scheme (e.g., "qrscan")
- **`_widgetUrlService.clearWidgetUrl()`** - Clears URL to prevent repeated navigation
- **`context.router.replaceAll()`** - Navigates to QR scanning screen

#### Code Implementation

```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';
import 'package:qr_scanner_practice/core/services/widget_url_service.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  
  final WidgetUrlService _widgetUrlService = WidgetUrlService();

  @override
  void initState() {
    super.initState();
    _startFlow();
  }

  Future<void> _startFlow() async {
    // Your splash animation or initialization

    if (!mounted) {
      return;
    }

    await _handleNavigation();
  }

  Future<void> _handleNavigation() async {
    final String? widgetUrlString = await _widgetUrlService.getWidgetUrl();

    if (widgetUrlString != null) {
      final Uri? widgetUri = Uri.tryParse(widgetUrlString);

      if (widgetUri?.scheme == RoutePaths.qrScan) {
        await _widgetUrlService.clearWidgetUrl();

        if (!mounted) {
          return;
        }
        
        await context.router.replaceAll(<PageRouteInfo<Object?>>[
          const DashboardRouter(
            children: <PageRouteInfo<Object?>>[QrScanningRoute()],
          ),
        ]);
        return;
      }
    }

    if (!mounted) {
      return;
    }

    await context.router.replaceAll(<PageRouteInfo<Object?>>[
      const DashboardRouter(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    // Your splash screen UI
  }
}
```

---

### 4. How the Widget Launch Flow Works

#### Android Flow

1. **User Action** - User taps the home screen widget
2. **Widget Click** - `QrScanWidget` triggers PendingIntent with deep link `qrscan://open?action=scan`
3. **MainActivity Launch** - Intent launches MainActivity (or brings it to foreground)
4. **Intent Handling** - `handleIntent()` in MainActivity extracts URL and stores in `companion object`
5. **Flutter Request** - Flutter calls `getWidgetUrl()` via MethodChannel
6. **URL Retrieved** - MethodChannel returns stored URL to Flutter
7. **Navigation** - Flutter navigates to QR scanning screen
8. **Clear URL** - Flutter calls `clearWidgetUrl()` to prevent repeated navigation

#### iOS Flow

1. **User Action** - User taps the home screen widget
2. **Widget Click** - Widget's `.widgetURL()` triggers deep link `qrscan://open`
3. **AppDelegate Launch** - URL handled by `application(_:open:options:)` or `didFinishLaunchingWithOptions`
4. **URL Storage** - AppDelegate stores URL in `widgetUrl` property
5. **Flutter Request** - Flutter calls `getWidgetUrl()` via MethodChannel
6. **URL Retrieved** - MethodChannel returns stored URL to Flutter
7. **Navigation** - Flutter navigates to QR scanning screen
8. **Clear URL** - Flutter calls `clearWidgetUrl()` to prevent repeated navigation

---

## MethodChannel Communication

### Channel Name Convention

Both platforms use the same channel name:
```
com.scannote.app/widget
```

This ensures Flutter can communicate with both iOS and Android using the same service class.

---

### Available Methods

| Method | Parameters | Return Type | Purpose |
|--------|-----------|-------------|---------|
| `getWidgetUrl` | None | `String?` | Retrieves the deep link URL that launched the app |
| `clearWidgetUrl` | None | `void` | Clears the stored URL to prevent repeated handling |

---

### Error Handling

The `WidgetUrlService` includes try-catch blocks to handle:
- Platform method call failures
- Null return values
- Communication errors

All errors are gracefully handled by returning `null` or doing nothing, preventing app crashes.

---

## Testing the Widget

### Android Testing Steps

1. **Build and Install** - Run `flutter run` to install the app
2. **Add Widget** - Long-press home screen → Widgets → Find your app → Drag widget to home screen
3. **Test Click** - Tap the widget
4. **Verify Navigation** - App should open and navigate to QR scanning screen
5. **Test Repeated Clicks** - Ensure URL is cleared and doesn't cause repeated navigation

### iOS Testing Steps

1. **Build and Install** - Run `flutter run` to install the app
2. **Add Widget** - Long-press home screen → Tap '+' → Search for your app → Add widget
3. **Test Click** - Tap the widget
4. **Verify Navigation** - App should open and navigate to QR scanning screen
5. **Test Repeated Clicks** - Ensure URL is cleared and doesn't cause repeated navigation

---

## Troubleshooting

### Android Issues

**Widget not appearing:**
- Check `AndroidManifest.xml` has the receiver registered
- Verify `qr_scan_widget_info.xml` exists in `res/xml/`
- Check widget layout file exists in `res/layout/`

**Deep link not working:**
- Verify intent filter in `AndroidManifest.xml`
- Check scheme matches in widget and MainActivity
- Ensure `FLAG_ACTIVITY_NEW_TASK` and `FLAG_ACTIVITY_CLEAR_TOP` are set

**MethodChannel not working:**
- Verify channel name matches in MainActivity and Flutter
- Check `configureFlutterEngine` is called
- Ensure MainActivity extends `FlutterActivity`

### iOS Issues

**Widget not appearing:**
- Ensure widget extension target is added to project
- Verify widget is included in app's scheme
- Check widget's Info.plist is configured correctly

**Deep link not working:**
- Verify URL scheme in Runner's Info.plist
- Check widget's `.widgetURL()` modifier
- Ensure AppDelegate handles `application(_:open:options:)`

**MethodChannel not working:**
- Verify channel name matches in AppDelegate and Flutter
- Check `setupMethodChannel()` is called in `didFinishLaunchingWithOptions`
- Ensure FlutterViewController is accessible

---

## Summary

This guide covers the complete setup for both iOS and Android home screen widgets using **MethodChannel** for native-Flutter communication:

✅ **Android Setup:**
- Widget Provider class with PendingIntent
- MainActivity with MethodChannel handler
- Deep link intent filter configuration
- Widget layouts and resources

✅ **iOS Setup:**
- Widget extension with SwiftUI
- AppDelegate with MethodChannel handler
- URL scheme configuration
- Deep link handling

✅ **Flutter Integration:**
- WidgetUrlService for platform communication
- Splash screen navigation handling
- Deep link URL parsing and routing

✅ **Key Advantages of MethodChannel Approach:**
- No third-party package dependencies
- Full control over implementation
- Direct native code integration
- Easy to debug and maintain
- Consistent API across platforms

Make sure to test the widget on both platforms after implementation to ensure proper functionality.
