import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';

class DeviceInfoService {
  DeviceInfoService();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<Either<Failure, String>> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
        return Right<Failure, String>(androidInfo.id);
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
        return Right<Failure, String>(iosInfo.identifierForVendor ?? '');
      } else {
        return const Left<Failure, String>(
          Failure(message: 'Unsupported platform'),
        );
      }
    } catch (e) {
      return Left<Failure, String>(
        Failure(message: 'Failed to get device ID: $e'),
      );
    }
  }
}
