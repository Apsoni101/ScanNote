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
