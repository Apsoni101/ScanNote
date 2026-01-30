import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

/// Reusable empty state component
class HistoryEmptyState extends StatelessWidget {
  const HistoryEmptyState({
    required this.isSearchActive,
    super.key,
    this.iconSize = 48,
  });

  final bool isSearchActive;
  final double iconSize;

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 16,
      mainAxisAlignment: .center,
      crossAxisAlignment: .stretch,
      children: <Widget>[
        Container(
          padding: const .all(24),
          decoration: BoxDecoration(
            shape: .circle,
            color: context.appColors.surfaceL3,
          ),
          child: Icon(
            Icons.access_time,
            size: iconSize,
            color: context.appColors.textSecondary,
          ),
        ),
        Text(
          context.locale.noScanHistoryYet,
          style: AppTextStyles.airbnbCerealW400S16Lh24Ls0.copyWith(
            color: context.appColors.textSecondary,
          ),
          textAlign: .center,
        ),
        Text(
          context.locale.yourSavedScansWillAppearHere,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
            color: context.appColors.textTertiary,
          ),
          textAlign: .center,
        ),
      ],
    );
  }
}
