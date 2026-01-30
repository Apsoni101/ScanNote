import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    required this.title,
    this.showBottomDivider = false,
    super.key,
  });

  final String title;
  final bool showBottomDivider;

  @override
  Widget build(final BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      backgroundColor: context.appColors.appBarBackground,
      title: Text(
        title,
        style: AppTextStyles.airbnbCerealW600S20Lh28Ls0.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),

      bottom: showBottomDivider
          ? PreferredSize(
              preferredSize: const .fromHeight(2),
              child: Divider(height: 2, color: context.appColors.separator),
            )
          : null,
    );
  }

  @override
  Size get preferredSize =>
      .fromHeight(kToolbarHeight + (showBottomDivider ? 2 : 0));
}
