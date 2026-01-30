import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    required this.iconPath,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    super.key,
  });

  final String iconPath;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const .symmetric(vertical: 2),
      child: SvgPicture.asset(
        iconPath,
        width: 24,
        height: 24,
        colorFilter: .mode(isActive ? activeColor : inactiveColor, .srcIn),
      ),
    );
  }
}
