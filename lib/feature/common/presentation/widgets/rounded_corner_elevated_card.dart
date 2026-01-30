import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class RoundedCornerElevatedCard extends StatelessWidget {
  const RoundedCornerElevatedCard({
    required this.child,
    this.elevation,
    super.key,
  });

  final Widget child;
  final double? elevation;

  @override
  Widget build(final BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: .circular(14)),
      color: context.appColors.cardBackground,
      elevation: elevation ?? 1,
      child: child,
    );
  }
}
