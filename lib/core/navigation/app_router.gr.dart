// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:qr_scanner_practice/core/navigation/router/auth_router.dart'
    as _i1;
import 'package:qr_scanner_practice/core/navigation/router/dashboard_router.dart'
    as _i2;
import 'package:qr_scanner_practice/feature/auth/presentation/screens/sign_in_screen.dart'
    as _i8;
import 'package:qr_scanner_practice/feature/history/presentation/screen/history_screen.dart'
    as _i3;
import 'package:qr_scanner_practice/feature/home/presentation/screen/home_screen.dart'
    as _i4;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/presentation/qr_result_confirmation_screen.dart'
    as _i5;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/presentation/qr_result_screen.dart'
    as _i6;
import 'package:qr_scanner_practice/feature/qr_scan/presentation/presentation/qr_scanner_screen.dart'
    as _i7;
import 'package:qr_scanner_practice/feature/splash/presentation/screens/splash_screen.dart'
    as _i9;

/// generated route for
/// [_i1.AuthRouterPage]
class AuthRouter extends _i10.PageRouteInfo<void> {
  const AuthRouter({List<_i10.PageRouteInfo>? children})
    : super(AuthRouter.name, initialChildren: children);

  static const String name = 'AuthRouter';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthRouterPage();
    },
  );
}

/// generated route for
/// [_i2.DashboardRouterPage]
class DashboardRouter extends _i10.PageRouteInfo<void> {
  const DashboardRouter({List<_i10.PageRouteInfo>? children})
    : super(DashboardRouter.name, initialChildren: children);

  static const String name = 'DashboardRouter';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i2.DashboardRouterPage();
    },
  );
}

/// generated route for
/// [_i3.HistoryScreen]
class HistoryRoute extends _i10.PageRouteInfo<void> {
  const HistoryRoute({List<_i10.PageRouteInfo>? children})
    : super(HistoryRoute.name, initialChildren: children);

  static const String name = 'HistoryRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.HistoryScreen();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.QrResultConfirmationScreen]
class QrResultConfirmationRoute
    extends _i10.PageRouteInfo<QrResultConfirmationRouteArgs> {
  QrResultConfirmationRoute({
    required String qrData,
    required String comment,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         QrResultConfirmationRoute.name,
         args: QrResultConfirmationRouteArgs(
           qrData: qrData,
           comment: comment,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'QrResultConfirmationRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QrResultConfirmationRouteArgs>();
      return _i5.QrResultConfirmationScreen(
        qrData: args.qrData,
        comment: args.comment,
        key: args.key,
      );
    },
  );
}

class QrResultConfirmationRouteArgs {
  const QrResultConfirmationRouteArgs({
    required this.qrData,
    required this.comment,
    this.key,
  });

  final String qrData;

  final String comment;

  final _i11.Key? key;

  @override
  String toString() {
    return 'QrResultConfirmationRouteArgs{qrData: $qrData, comment: $comment, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QrResultConfirmationRouteArgs) return false;
    return qrData == other.qrData &&
        comment == other.comment &&
        key == other.key;
  }

  @override
  int get hashCode => qrData.hashCode ^ comment.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i6.QrResultScreen]
class QrResultRoute extends _i10.PageRouteInfo<QrResultRouteArgs> {
  QrResultRoute({
    required String qrData,
    _i11.Key? key,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         QrResultRoute.name,
         args: QrResultRouteArgs(qrData: qrData, key: key),
         initialChildren: children,
       );

  static const String name = 'QrResultRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QrResultRouteArgs>();
      return _i6.QrResultScreen(qrData: args.qrData, key: args.key);
    },
  );
}

class QrResultRouteArgs {
  const QrResultRouteArgs({required this.qrData, this.key});

  final String qrData;

  final _i11.Key? key;

  @override
  String toString() {
    return 'QrResultRouteArgs{qrData: $qrData, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! QrResultRouteArgs) return false;
    return qrData == other.qrData && key == other.key;
  }

  @override
  int get hashCode => qrData.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i7.QrScanningScreen]
class QrScanningRoute extends _i10.PageRouteInfo<void> {
  const QrScanningRoute({List<_i10.PageRouteInfo>? children})
    : super(QrScanningRoute.name, initialChildren: children);

  static const String name = 'QrScanningRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.QrScanningScreen();
    },
  );
}

/// generated route for
/// [_i8.SignInScreen]
class SignInRoute extends _i10.PageRouteInfo<void> {
  const SignInRoute({List<_i10.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SignInScreen();
    },
  );
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i10.PageRouteInfo<void> {
  const SplashRoute({List<_i10.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}
