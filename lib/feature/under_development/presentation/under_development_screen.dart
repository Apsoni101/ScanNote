import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

@RoutePage()
class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.scaffoldBackground,
      body: Column(
        mainAxisAlignment: .center,
        children: <Widget>[
          CircleAvatar(
            radius: 56,
            backgroundColor: context.appColors.primaryDefault.withValues(
              alpha: 0.05,
            ),
            child: SvgPicture.asset(
              AppAssets.developmentToolIcon,
              width: 42,
              height: 42,
              colorFilter: .mode(context.appColors.primaryDefault, .srcIn),
            ),
          ),
          const SizedBox(height: 24),

          Text(
            context.locale.underDevelopment,
            style: AppTextStyles.airbnbCerealW600S20Lh28Ls0,
          ),
          const SizedBox(height: 16),

          Text(
            context
                .locale
                .thisSectionIsCurrentlyBeingBuiltWellMakeItAvailableSoon,
            textAlign: TextAlign.center,
            style: AppTextStyles.airbnbCerealW400S16Lh24Ls0,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              context.router.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.appColors.primaryDefault,
              elevation: 4,
              padding: const .symmetric(horizontal: 32),
              shape: RoundedRectangleBorder(borderRadius: .circular(12)),
            ),
            child: Text(
              context.locale.goBack,
              style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                color: context.appColors.textInversePrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
