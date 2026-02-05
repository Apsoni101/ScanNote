import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  const PermissionService();

  /// Ask storage permission
  /// For Android 13+ (API 33+), Downloads folder doesn't need explicit permission
  /// For Android 10-12, we need WRITE_EXTERNAL_STORAGE
  /// For Android 9 and below, we need both READ and WRITE
  Future<bool> requestStoragePermission() async {
    if (!Platform.isAndroid) {
      return true;
    }

    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final int sdkInt = androidInfo.version.sdkInt;

    /// Android 13+ (API 33+) - Downloads folder accessible without permission
    if (sdkInt >= 33) {
      return true;
    }

    /// Android 10-12 (API 29-32) - Request storage permission
    if (sdkInt >= 29) {
      final PermissionStatus status = await Permission.storage.status;

      if (status.isGranted) {
        return true;
      }

      if (status.isPermanentlyDenied) {
        return false;
      }

      final PermissionStatus result = await Permission.storage.request();
      return result.isGranted;
    }

    /// Android 9 and below (API 28 and below) because above androids give permission to download files in download folder
    final PermissionStatus status = await Permission.storage.status;

    if (status.isGranted) {
      return true;
    }

    if (status.isPermanentlyDenied) {
      return false;
    }

    final PermissionStatus result = await Permission.storage.request();
    return result.isGranted;
  }

  /// Open app settings
  Future<void> openSettings() async {
    await openAppSettings();
  }
}
