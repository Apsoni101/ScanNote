// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:qr_scanner_practice/core/navigation/router/auth_router.dart'
    as _i1;
import 'package:qr_scanner_practice/core/navigation/router/dashboard_router.dart'
    as _i2;
import 'package:qr_scanner_practice/feature/auth/presentation/screens/sign_in_screen.dart'
    as _i9;
import 'package:qr_scanner_practice/feature/history/presentation/screen/history_screen.dart'
    as _i3;
import 'package:qr_scanner_practice/feature/home/presentation/screen/home_screen.dart'
    as _i4;
import 'package:qr_scanner_practice/feature/ocr/presentation/screen/ocr_screen.dart'
    as _i5;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/presentation/qr_scanner_screen.dart'
    as _i6;
import 'package:qr_scanner_practice/feature/result_scan/presentation/presentation/result_confirmation_screen.dart'
    as _i7;
import 'package:qr_scanner_practice/feature/result_scan/presentation/presentation/result_screen.dart'
    as _i8;
import 'package:qr_scanner_practice/feature/splash/presentation/screens/splash_screen.dart'
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
/// [_i3.HistoryScreen]
class HistoryRoute extends _i11.PageRouteInfo<void> {
  const HistoryRoute({List<_i11.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.HistoryScreen();
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
/// [_i7.ResultConfirmationScreen]
class ResultConfirmationRoute
    extends _i11.PageRouteInfo<ResultConfirmationRouteArgs> {
  ResultConfirmationRoute({
    required String data,
    required String comment,
    required _i8.ResultType resultType,
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ResultConfirmationRoute.name,
         args: ResultConfirmationRouteArgs(
           data: data,
           comment: comment,
           resultType: resultType,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'ResultConfirmationRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResultConfirmationRouteArgs>();
      return _i7.ResultConfirmationScreen(
        data: args.data,
        comment: args.comment,
        resultType: args.resultType,
        key: args.key,
      );
    },
  );
}

class ResultConfirmationRouteArgs {
  const ResultConfirmationRouteArgs({
    required this.data,
    required this.comment,
    required this.resultType,
    this.key,
  });

  final String data;

  final String comment;

  final _i8.ResultType resultType;

  final _i12.Key? key;

  @override
  String toString() {
    return 'ResultConfirmationRouteArgs{data: $data, comment: $comment, resultType: $resultType, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ResultConfirmationRouteArgs) return false;
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
    required _i8.ResultType resultType,
    _i12.Key? key,
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

  final _i8.ResultType resultType;

  final _i12.Key? key;

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
/// [_i9.SignInScreen]
class SignInRoute extends _i11.PageRouteInfo<void> {
  const SignInRoute({List<_i11.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SignInScreen();
    },
  );
}

/// generated route for
/// [_i10.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.SplashScreen();
    },
  );
}
