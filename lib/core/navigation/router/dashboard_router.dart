import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/auth_guard.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';
import 'package:qr_scanner_practice/core/navigation/routes/no_bottom_nav_bar_routes.dart';
import 'package:qr_scanner_practice/core/navigation/routes/with_bottom_nav_bar_routes.dart';

@RoutePage(name: 'DashboardRouter')
class DashboardRouterPage extends AutoRouter {
  const DashboardRouterPage({super.key});
}

AutoRoute dashboardRoute(final AuthGuard authGuard) => AutoRoute(
  page: DashboardRouter.page,
  path: RoutePaths.dashboard,
  guards: <AutoRouteGuard>[authGuard],
  children: <AutoRoute>[...withBottomNavBarRoutes, ...noBottomNavBarRoutes],
);
