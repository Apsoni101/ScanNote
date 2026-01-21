import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class CommonLoadingView extends StatelessWidget {
  const CommonLoadingView({super.key});

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          context.appColors.primaryBlue,
        ),
      ),
    );
  }
}
