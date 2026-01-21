import 'package:flutter/material.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({
    required this.backgroundColor,
    required this.borderColor,
    required this.child,
    super.key,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}
