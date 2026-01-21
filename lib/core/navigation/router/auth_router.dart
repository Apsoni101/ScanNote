import 'package:auto_route/auto_route.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';

@RoutePage(name: 'AuthRouter')
class AuthRouterPage extends AutoRouter {
  const AuthRouterPage({super.key});
}

final AutoRoute authRoute = AutoRoute(
  page: AuthRouter.page,
  path: RoutePaths.auth,
  children: <AutoRoute>[
    AutoRoute(page: GoogleSignInSignUpRoute.page, initial: true),
  ],
);
