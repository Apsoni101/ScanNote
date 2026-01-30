import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/navigation/route_paths.dart';
import 'package:qr_scanner_practice/core/services/widget_url_service.dart';
import 'package:qr_scanner_practice/feature/splash/presentation/widgets/splash_appear_animation.dart';
import 'package:qr_scanner_practice/feature/splash/presentation/widgets/splash_logo_container.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  final WidgetUrlService _widgetUrlService = WidgetUrlService();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);

    _startFlow();
  }

  Future<void> _startFlow() async {
    await _controller.forward();

    if (!mounted) {
      return;
    }

    await _handleNavigation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleNavigation() async {
    final String? widgetUrlString = await _widgetUrlService.getWidgetUrl();

    if (widgetUrlString != null) {
      final Uri? widgetUri = Uri.tryParse(widgetUrlString);

      if (widgetUri?.scheme == RoutePaths.qrScan) {
        await _widgetUrlService.clearWidgetUrl();

        if (!mounted) {
          return;
        }
        await context.router.replaceAll(<PageRouteInfo<Object?>>[
          const DashboardRouter(
            children: <PageRouteInfo<Object?>>[QrScanningRoute()],
          ),
        ]);
        return;
      }
    }

    if (!mounted) {
      return;
    }

    await context.router.replaceAll(<PageRouteInfo<Object?>>[
      const DashboardRouter(),
    ]);
  }

  @override
  Widget build(final BuildContext context) {
    return ColoredBox(
      color: context.appColors.splashBackground,
      child: SplashAppearAnimation(
        animation: _animation,
        child: Column(
          mainAxisAlignment: .center,
          children: <Widget>[
            const SplashLogoContainer(),
            const SizedBox(height: 24),
            Text(
              context.locale.appName,
              style: AppTextStyles.interW600S36Lh48Ls0.copyWith(
                color: context.appColors.textInversePrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              context.locale.scanExtractSave,
              style: AppTextStyles.interW400S14Lh21Ls0.copyWith(
                color: context.appColors.textInversePrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
