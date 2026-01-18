import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

final List<AutoRoute> dashboardTabRoutes = <AutoRoute>[
  AutoRoute(page: HomeRoute.page, path: RoutePaths.home,initial: true),
  AutoRoute(page: ResultScanningRoute.page, path: RoutePaths.qrScan),
  AutoRoute(page: ResultRoute.page, path: RoutePaths.result),
  AutoRoute(page: OcrRoute.page, path: RoutePaths.ocr),
  AutoRoute(page: ResultConfirmationRoute.page, path: RoutePaths.resultConfirm),
  AutoRoute(page: HistoryRoute.page, path: RoutePaths.history),
];
