import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class QrIconSection extends StatelessWidget {
  const QrIconSection({super.key});

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.appColors.cloudBlue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.qr_code_scanner,
        size: 64,
        color: context.appColors.primaryBlue,
      ),
    );
  }
}
