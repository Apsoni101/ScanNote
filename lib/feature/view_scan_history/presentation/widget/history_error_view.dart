import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

/// Reusable error state component
class HistoryErrorState extends StatelessWidget {
  const HistoryErrorState({
    required this.errorMessage,
    super.key,
    this.iconSize = 48,
  });

  final String errorMessage;
  final double iconSize;

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .center,
      children: <Widget>[
        Icon(
          Icons.error_outline,
          size: iconSize,
          color: context.appColors.semanticsIconError,
        ),
        Text(
          errorMessage,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0,
          textAlign: .center,
          maxLines: 3,
          overflow: .ellipsis,
        ),
      ],
    );
  }
}
