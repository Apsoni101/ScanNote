plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.scannote.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14206865"
    flavorDimensions += "default"
    productFlavors {
        create("uat") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "ScanNote UAT"
            )
            applicationIdSuffix = ".uat"
        }
        create("dev") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "ScanNote DEV"
            )
            applicationIdSuffix = ".dev"
        }
        create("prod") {
            dimension = "default"
            resValue(
                type = "string",
                name = "app_name",
                value = "ScanNote"
            )
        }
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.scannote.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
    buildFeatures {
        viewBinding = true
    }
}
dependencies {
    // Core text recognition
    implementation("com.google.mlkit:text-recognition:16.0.0")

    // Language modules required by ML Kit internally
    implementation("com.google.mlkit:text-recognition-chinese:16.0.0")
    implementation("com.google.mlkit:text-recognition-devanagari:16.0.0")
    implementation("com.google.mlkit:text-recognition-japanese:16.0.0")
    implementation("com.google.mlkit:text-recognition-korean:16.0.0")
}
flutter {
    source = "../.."
}
