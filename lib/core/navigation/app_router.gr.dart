// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i13;
import 'package:qr_scanner_practice/core/enums/result_type.dart' as _i12;
import 'package:qr_scanner_practice/core/navigation/router/auth_router.dart'
    as _i1;
import 'package:qr_scanner_practice/core/navigation/router/dashboard_router.dart'
    as _i2;
import 'package:qr_scanner_practice/feature/auth/presentation/screens/google_sign_in_sign_up_screen.dart'
    as _i3;
import 'package:qr_scanner_practice/feature/home/presentation/screen/home_screen.dart'
    as _i4;
import 'package:qr_scanner_practice/feature/ocr/presentation/screen/ocr_screen.dart'
    as _i5;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/presentation/qr_scanner_screen.dart'
    as _i6;
import 'package:qr_scanner_practice/feature/scan_result/presentation/presentation/result_saving_screen.dart'
    as _i7;
import 'package:qr_scanner_practice/feature/scan_result/presentation/presentation/result_screen.dart'
    as _i8;
import 'package:qr_scanner_practice/feature/splash/presentation/screens/splash_screen.dart'
    as _i9;
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/screen/view_scans_history_screen.dart'
    as _i10;

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i11.PageRouteInfo<void> {
  const AuthRouter({List<_i11.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardRouterPage]
class DashboardRouter extends _i11.PageRouteInfo<void> {
  const DashboardRouter({List<_i11.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i3.GoogleSignInSignUpScreen]
class GoogleSignInSignUpRoute extends _i11.PageRouteInfo<void> {
  const GoogleSignInSignUpRoute({List<_i11.PageRouteInfo>? children})
    : super(GoogleSignInSignUpRoute.name, initialChildren: children);

  static const String name = 'GoogleSignInSignUpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.GoogleSignInSignUpScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.OcrScreen]
class OcrRoute extends _i11.PageRouteInfo<void> {
  const OcrRoute({List<_i11.PageRouteInfo>? children})
    : super(OcrRoute.name, initialChildren: children);

  static const String name = 'OcrRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.OcrScreen();
    },
  );
}

/// generated route for
/// [_i6.QrScanningScreen]
class QrScanningRoute extends _i11.PageRouteInfo<void> {
  const QrScanningRoute({List<_i11.PageRouteInfo>? children})
    : super(QrScanningRoute.name, initialChildren: children);

  static const String name = 'QrScanningRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.QrScanningScreen();
    },
  );
}

/// generated route for
/// [_i7.ResultSavingScreen]
class ResultSavingRoute extends _i11.PageRouteInfo<ResultSavingRouteArgs> {
  ResultSavingRoute({
    required String data,
    required String comment,
    required _i12.ResultType resultType,
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ResultSavingRoute.name,
         args: ResultSavingRouteArgs(
           data: data,
           comment: comment,
           resultType: resultType,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ResultSavingRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultSavingRouteArgs>();
      return _i7.ResultSavingScreen(
        data: args.data,
        comment: args.comment,
        resultType: args.resultType,
        key: args.key,
      );
    },
  );
}

class ResultSavingRouteArgs {
  const ResultSavingRouteArgs({
    required this.data,
    required this.comment,
    required this.resultType,
    this.key,
  });

  final String data;

  final String comment;

  final _i12.ResultType resultType;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ResultSavingRouteArgs{data: $data, comment: $comment, resultType: $resultType, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResultSavingRouteArgs) return false;
    return data == other.data &&
        comment == other.comment &&
        resultType == other.resultType &&
        key == other.key;
  }

  @override
  int get hashCode =>
      data.hashCode ^ comment.hashCode ^ resultType.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i8.ResultScreen]
class ResultRoute extends _i11.PageRouteInfo<ResultRouteArgs> {
  ResultRoute({
    required String data,
    required _i12.ResultType resultType,
    _i13.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ResultRoute.name,
         args: ResultRouteArgs(data: data, resultType: resultType, key: key),
         initialChildren: children,
       );

  static const String name = 'ResultRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultRouteArgs>();
      return _i8.ResultScreen(
        data: args.data,
        resultType: args.resultType,
        key: args.key,
      );
    },
  );
}

class ResultRouteArgs {
  const ResultRouteArgs({
    required this.data,
    required this.resultType,
    this.key,
  });

  final String data;

  final _i12.ResultType resultType;

  final _i13.Key? key;

  @override
  String toString() {
    return 'ResultRouteArgs{data: $data, resultType: $resultType, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResultRouteArgs) return false;
    return data == other.data &&
        resultType == other.resultType &&
        key == other.key;
  }

  @override
  int get hashCode => data.hashCode ^ resultType.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}

/// generated route for
/// [_i10.ViewScansHistoryScreen]
class ViewScansHistoryRoute extends _i11.PageRouteInfo<void> {
  const ViewScansHistoryRoute({List<_i11.PageRouteInfo>? children})
    : super(ViewScansHistoryRoute.name, initialChildren: children);

  static const String name = 'ViewScansHistoryRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.ViewScansHistoryScreen();
    },
  );
}
