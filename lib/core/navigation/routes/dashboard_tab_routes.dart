import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

final List<AutoRoute> dashboardTabRoutes = <AutoRoute>[
  AutoRoute(page: HomeRoute.page, path: RoutePaths.home,initial: true),
  AutoRoute(page: QrScanningRoute.page, path: RoutePaths.qrScan),
  AutoRoute(page: QrResultRoute.page, path: RoutePaths.qrResult),
  AutoRoute(page: QrResultConfirmationRoute.page, path: RoutePaths.qrResultConfirm),
  AutoRoute(page: HistoryRoute.page, path: RoutePaths.history),
];
