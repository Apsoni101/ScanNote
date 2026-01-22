import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    required this.iconPath,
    required this.isActive,
    super.key,
  });

  final String iconPath;
  final bool isActive;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        colorFilter: isActive
            ? ColorFilter.mode(
                context.appColors.primaryDefault,
                BlendMode.srcIn,
              )
            : null,
      ),
    );
  }
}
