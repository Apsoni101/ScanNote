import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _handleNavigation();
  }

  Future<void> _handleNavigation() async {

    if (!mounted) return;

    final Uri? uri = await HomeWidget.initiallyLaunchedFromHomeWidget();

    if (uri?.scheme == 'qrscan') {
      await context.router.replaceAll(<PageRouteInfo<Object?>>[
        const DashboardRouter(children: <PageRouteInfo<Object?>>[
          QrScanningRoute(),
        ]),
      ]);
    } else {
      await context.router.replaceAll(<PageRouteInfo<Object?>>[
        const DashboardRouter(),
      ]);
    }
  }

  @override
  Widget build(final BuildContext context) => Stack(
    children: <Widget>[
      Positioned.fill(child: ColoredBox(color: context.appColors.white)),
      Align(
        child: Icon(
          Icons.qr_code_scanner,
          size: 120,
          color: context.appColors.primaryBlue,
        ),
      ),
    ],
  );
}