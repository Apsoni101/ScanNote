import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

final List<AutoRoute> withBottomNavBarRoutes = <AutoRoute>[
  AutoRoute(
    page: DashboardRoute.page,
    initial: true,
    children: [
      AutoRoute(page: HomeRoute.page, path: RoutePaths.home, initial: true),
      AutoRoute(page: ViewScansHistoryRoute.page, path: RoutePaths.history),
    ],
  ),
];
