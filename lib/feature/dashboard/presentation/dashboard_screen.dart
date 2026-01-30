import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/dashboard/widgets/bottom_nav_icon.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/home_screen_app_bar.dart';

@RoutePage()
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo<Object?>>[
        HomeRoute(),
        ViewScansHistoryRoute(),
      ],
      appBarBuilder: (final BuildContext context, final TabsRouter tabsRouter) {
        return const HomeScreenAppBar();
      },
      bottomNavigationBuilder: (_, final TabsRouter tabsRouter) {
        return Column(
          mainAxisSize: .min,
          children: <Widget>[
            Divider(height: 1, color: context.appColors.separator),
            BottomNavigationBar(
              onTap: tabsRouter.setActiveIndex,
              type: .fixed,
              currentIndex: tabsRouter.activeIndex,
              selectedFontSize: 12,
              backgroundColor: context.appColors.bottomNavBackground,
              selectedItemColor: context.appColors.primaryDefault,
              unselectedItemColor: context.appColors.textSecondary,
              selectedLabelStyle: AppTextStyles.interW700S12Lh16,
              unselectedLabelStyle: AppTextStyles.interW700S12Lh16,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  label: context.locale.home,
                  icon: BottomNavIcon(
                    iconPath: AppAssets.homeIc,
                    isActive: tabsRouter.activeIndex == 0,
                    activeColor: context.appColors.primaryDefault,
                    inactiveColor: context.appColors.textSecondary,
                  ),
                ),
                BottomNavigationBarItem(
                  label: context.locale.history,
                  icon: BottomNavIcon(
                    iconPath: AppAssets.viewHistoryIc,
                    isActive: tabsRouter.activeIndex == 1,
                    activeColor: context.appColors.primaryDefault,
                    inactiveColor: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
