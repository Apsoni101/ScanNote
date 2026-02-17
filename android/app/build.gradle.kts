plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

val keystorePropertiesFile = rootProject.file("key.properties")

fun signingProp(propName: String, envName: String): String? {
    if (keystorePropertiesFile.exists()) {
        val match = keystorePropertiesFile
            .readLines()
            .find { it.trim().startsWith("$propName=") }
        if (match != null) {
            return match.trim().substringAfter("=").trim()
        }
    }
    return System.getenv(envName)
}

android {
    namespace = "com.scannote.app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = "29.0.14206865"

    flavorDimensions += "default"
    productFlavors {
        create("uat") {
            dimension = "default"
            resValue(type = "string", name = "app_name", value = "ScanNote UAT")
            applicationIdSuffix = ".uat"
        }
        create("dev") {
            dimension = "default"
            resValue(type = "string", name = "app_name", value = "ScanNote DEV")
            applicationIdSuffix = ".dev"
        }
        create("prod") {
            dimension = "default"
            resValue(type = "string", name = "app_name", value = "ScanNote")
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    signingConfigs {
        create("release") {
            val keystore = signingProp("storeFile", "KEYSTORE_FILE") ?: "keystore.jks"
            storeFile = file(keystore)
            storePassword = signingProp("storePassword", "KEYSTORE_PASSWORD")
            keyAlias = signingProp("keyAlias", "KEY_ALIAS")
            keyPassword = signingProp("keyPassword", "KEY_PASSWORD")
        }
    }

    defaultConfig {
        applicationId = "com.scannote.app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        debug {
            signingConfig = signingConfigs.getByName("debug")
        }
        release {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }

    buildFeatures {
        viewBinding = true
    }
}

dependencies {
    implementation("com.google.mlkit:text-recognition:16.0.0")
    implementation("com.google.mlkit:text-recognition-chinese:16.0.0")
    implementation("com.google.mlkit:text-recognition-devanagari:16.0.0")
    implementation("com.google.mlkit:text-recognition-japanese:16.0.0")
    implementation("com.google.mlkit:text-recognition-korean:16.0.0")
}

flutter {
    source = "../.."
}