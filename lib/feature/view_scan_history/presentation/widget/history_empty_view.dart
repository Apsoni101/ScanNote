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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.history,
          size: iconSize,
          color: context.appColors.textSecondary,
        ),
        Text(
          isSearchActive
              ? context.locale.noResultsFound
              : context.locale.noScansYet,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
