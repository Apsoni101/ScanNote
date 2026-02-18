// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i15;
import 'package:flutter/material.dart' as _i17;
import 'package:qr_scanner_practice/core/enums/result_type.dart' as _i16;
import 'package:qr_scanner_practice/core/navigation/router/auth_router.dart'
    as _i1;
import 'package:qr_scanner_practice/core/navigation/router/dashboard_router.dart'
    as _i2;
import 'package:qr_scanner_practice/feature/auth/presentation/screens/google_sign_in_sign_up_screen.dart'
    as _i5;
import 'package:qr_scanner_practice/feature/dashboard/presentation/dashboard_screen.dart'
    as _i3;
import 'package:qr_scanner_practice/feature/export_sheet/presentation/screen/export_sheet_screen.dart'
    as _i4;
import 'package:qr_scanner_practice/feature/home/presentation/screen/home_screen.dart'
    as _i6;
import 'package:qr_scanner_practice/feature/ocr/presentation/screen/ocr_screen.dart'
    as _i7;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/screen/qr_scanner_screen.dart'
    as _i8;
import 'package:qr_scanner_practice/feature/scan_result/presentation/screen/scan_result_screen.dart'
    as _i9;
import 'package:qr_scanner_practice/feature/setting/presentation/screen/settings_screen.dart'
    as _i10;
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/screen/sheet_selection_screen.dart'
    as _i11;
import 'package:qr_scanner_practice/feature/splash/presentation/screens/splash_screen.dart'
    as _i12;
import 'package:qr_scanner_practice/feature/under_development/presentation/under_development_screen.dart'
    as _i13;
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/screen/view_scans_history_screen.dart'
    as _i14;

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i15.PageRouteInfo<void> {
  const AuthRouter({List<_i15.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardRouterPage]
class DashboardRouter extends _i15.PageRouteInfo<void> {
  const DashboardRouter({List<_i15.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i3.DashboardScreen]
class DashboardRoute extends _i15.PageRouteInfo<void> {
  const DashboardRoute({List<_i15.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.ExportSheetScreen]
class ExportSheetRoute extends _i15.PageRouteInfo<void> {
  const ExportSheetRoute({List<_i15.PageRouteInfo>? children})
    : super(ExportSheetRoute.name, initialChildren: children);

  static const String name = 'ExportSheetRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i4.ExportSheetScreen();
    },
  );
}

/// generated route for
/// [_i5.GoogleSignInSignUpScreen]
class GoogleSignInSignUpRoute extends _i15.PageRouteInfo<void> {
  const GoogleSignInSignUpRoute({List<_i15.PageRouteInfo>? children})
    : super(GoogleSignInSignUpRoute.name, initialChildren: children);

  static const String name = 'GoogleSignInSignUpRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i5.GoogleSignInSignUpScreen();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i15.PageRouteInfo<void> {
  const HomeRoute({List<_i15.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.OcrScreen]
class OcrRoute extends _i15.PageRouteInfo<void> {
  const OcrRoute({List<_i15.PageRouteInfo>? children})
    : super(OcrRoute.name, initialChildren: children);

  static const String name = 'OcrRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i7.OcrScreen();
    },
  );
}

/// generated route for
/// [_i8.QrScanningScreen]
class QrScanningRoute extends _i15.PageRouteInfo<void> {
  const QrScanningRoute({List<_i15.PageRouteInfo>? children})
    : super(QrScanningRoute.name, initialChildren: children);

  static const String name = 'QrScanningRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i8.QrScanningScreen();
    },
  );
}

/// generated route for
/// [_i9.ScanResultScreen]
class ScanResultRoute extends _i15.PageRouteInfo<ScanResultRouteArgs> {
  ScanResultRoute({
    required String scanResult,
    required _i16.ResultType resultType,
    _i17.ImageProvider<Object>? previewImage,
    _i17.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         ScanResultRoute.name,
         args: ScanResultRouteArgs(
           scanResult: scanResult,
           resultType: resultType,
           previewImage: previewImage,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ScanResultRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ScanResultRouteArgs>();
      return _i9.ScanResultScreen(
        scanResult: args.scanResult,
        resultType: args.resultType,
        previewImage: args.previewImage,
        key: args.key,
      );
    },
  );
}

class ScanResultRouteArgs {
  const ScanResultRouteArgs({
    required this.scanResult,
    required this.resultType,
    this.previewImage,
    this.key,
  });

  final String scanResult;

  final _i16.ResultType resultType;

  final _i17.ImageProvider<Object>? previewImage;

  final _i17.Key? key;

  @override
  String toString() {
    return 'ScanResultRouteArgs{scanResult: $scanResult, resultType: $resultType, previewImage: $previewImage, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ScanResultRouteArgs) return false;
    return scanResult == other.scanResult &&
        resultType == other.resultType &&
        previewImage == other.previewImage &&
        key == other.key;
  }

  @override
  int get hashCode =>
      scanResult.hashCode ^
      resultType.hashCode ^
      previewImage.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i10.SettingsScreen]
class SettingsRoute extends _i15.PageRouteInfo<void> {
  const SettingsRoute({List<_i15.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i10.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i11.SheetSelectionScreen]
class SheetSelectionRoute extends _i15.PageRouteInfo<SheetSelectionRouteArgs> {
  SheetSelectionRoute({
    required String scannedData,
    required String userComment,
    required _i16.ResultType scanResultType,
    _i17.Key? key,
    List<_i15.PageRouteInfo>? children,
  }) : super(
         SheetSelectionRoute.name,
         args: SheetSelectionRouteArgs(
           scannedData: scannedData,
           userComment: userComment,
           scanResultType: scanResultType,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'SheetSelectionRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SheetSelectionRouteArgs>();
      return _i11.SheetSelectionScreen(
        scannedData: args.scannedData,
        userComment: args.userComment,
        scanResultType: args.scanResultType,
        key: args.key,
      );
    },
  );
}

class SheetSelectionRouteArgs {
  const SheetSelectionRouteArgs({
    required this.scannedData,
    required this.userComment,
    required this.scanResultType,
    this.key,
  });

  final String scannedData;

  final String userComment;

  final _i16.ResultType scanResultType;

  final _i17.Key? key;

  @override
  String toString() {
    return 'SheetSelectionRouteArgs{scannedData: $scannedData, userComment: $userComment, scanResultType: $scanResultType, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SheetSelectionRouteArgs) return false;
    return scannedData == other.scannedData &&
        userComment == other.userComment &&
        scanResultType == other.scanResultType &&
        key == other.key;
  }

  @override
  int get hashCode =>
      scannedData.hashCode ^
      userComment.hashCode ^
      scanResultType.hashCode ^
      key.hashCode;
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i15.PageRouteInfo<void> {
  const SplashRoute({List<_i15.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashScreen();
    },
  );
}

/// generated route for
/// [_i13.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i15.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i15.PageRouteInfo>? children})
    : super(UnderDevelopmentRoute.name, initialChildren: children);

  static const String name = 'UnderDevelopmentRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i13.UnderDevelopmentScreen();
    },
  );
}

/// generated route for
/// [_i14.ViewScansHistoryScreen]
class ViewScansHistoryRoute extends _i15.PageRouteInfo<void> {
  const ViewScansHistoryRoute({List<_i15.PageRouteInfo>? children})
    : super(ViewScansHistoryRoute.name, initialChildren: children);

  static const String name = 'ViewScansHistoryRoute';

  static _i15.PageInfo page = _i15.PageInfo(
    name,
    builder: (data) {
      return const _i14.ViewScansHistoryScreen();
    },
  );
}
