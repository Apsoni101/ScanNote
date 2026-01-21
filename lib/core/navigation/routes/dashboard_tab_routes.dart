import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

final List<AutoRoute> dashboardTabRoutes = <AutoRoute>[
  AutoRoute(page: HomeRoute.page, path: RoutePaths.home, initial: true),
  AutoRoute(page: QrScanningRoute.page, path: RoutePaths.qrScan),
  AutoRoute(page: ResultRoute.page, path: RoutePaths.result),
  AutoRoute(page: OcrRoute.page, path: RoutePaths.ocr),
  AutoRoute(page: ResultSavingRoute.page, path: RoutePaths.resultConfirm),
  AutoRoute(page: ViewScansHistoryRoute.page, path: RoutePaths.history),
];
