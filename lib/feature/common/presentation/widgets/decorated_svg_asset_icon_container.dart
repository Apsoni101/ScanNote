import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DecoratedSvgAssetIconContainer extends StatelessWidget {
  const DecoratedSvgAssetIconContainer({
    required this.assetPath,
    required this.backgroundColor,
    required this.iconColor,
    this.padding = const .all(8),
    this.borderRadius = 12,
    super.key,
  });

  final String assetPath;
  final Color backgroundColor;
  final Color iconColor;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: .circular(borderRadius),
      ),
      child: SvgPicture.asset(assetPath, colorFilter: .mode(iconColor, .srcIn)),
    );
  }
}
