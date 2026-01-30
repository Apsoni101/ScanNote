import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';

class HomeScreenAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeScreenAppBar({super.key});

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.surfaceL1,
      elevation: 1,
      shadowColor: context.appColors.separator,
      leading: Container(
        margin: const .symmetric(vertical: 8, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: .circular(14),
          image: const DecorationImage(
            image: AssetImage(AppAssets.appLogoSmallIcon),
            fit: .cover,
          ),
        ),
      ),
      titleSpacing: 0,
      leadingWidth: 70,
      title: Text(
        context.locale.appName,
        style: AppTextStyles.interW700S22Lh28Ls0.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            AppAssets.settingsIc,
            width: 26,
            height: 26,
            colorFilter: .mode(context.appColors.iconPrimary, .srcIn),
          ),
          onPressed: () => context.router.push(const SettingsRoute()),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const .fromHeight(kToolbarHeight);
}
