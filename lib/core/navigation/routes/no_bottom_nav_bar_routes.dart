import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

final List<AutoRoute> noBottomNavBarRoutes = <AutoRoute>[
  AutoRoute(page: QrScanningRoute.page, path: RoutePaths.qrScan),
  AutoRoute(page: SettingsRoute.page, path: RoutePaths.settings),
  AutoRoute(page: ScanResultRoute.page, path: RoutePaths.result),
  AutoRoute(page: OcrRoute.page, path: RoutePaths.ocr),
  AutoRoute(page: SheetSelectionRoute.page, path: RoutePaths.resultConfirm),
  AutoRoute(page: ExportSheetRoute.page, path: RoutePaths.exportSheet),
];
