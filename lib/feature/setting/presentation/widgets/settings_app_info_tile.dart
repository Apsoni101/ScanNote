import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class SettingsAppInfoTile extends StatelessWidget {
  const SettingsAppInfoTile({super.key});

  @override
  Widget build(final BuildContext context) {
    return ListTile(
      tileColor: context.appColors.appBarBackground,
      leading: ClipRRect(
        borderRadius: .circular(12),
        child: Image.asset(AppAssets.appLogoSmallIcon, width: 40, height: 40),
      ),
      title: Text(
        context.locale.appName,
        style: AppTextStyles.airbnbCerealW600S16Lh24Ls0.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),
      subtitle: Text(
        context.locale.version1,
        style: AppTextStyles.airbnbCerealW400S12Lh16Ls0.copyWith(
          color: context.appColors.textSecondary,
        ),
      ),
    );
  }
}
