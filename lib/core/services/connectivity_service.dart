// lib/core/services/connectivity/connectivity_service.dart
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  ConnectivityService({final Connectivity? connectivity})
    : _connectivity = connectivity ?? Connectivity();
  final Connectivity _connectivity;

  /// Check if device has internet connection
  Future<bool> hasInternetConnection() async {
    try {
      final List<ConnectivityResult> result = await _connectivity
          .checkConnectivity();
      final bool hasConnection = !result.contains(ConnectivityResult.none);
      return hasConnection;
    } catch (e) {
      return false;
    }
  }

  /// Listen to connectivity status changes
  Stream<bool> onConnectivityChanged() {
    return _connectivity.onConnectivityChanged.map((
      final List<ConnectivityResult> result,
    ) {
      final bool hasConnection = !result.contains(ConnectivityResult.none);
      return hasConnection;
    });
  }
}
