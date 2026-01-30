import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';

class ScannedDataPreview extends StatelessWidget {
  const ScannedDataPreview({
    required this.scannedData,
    required this.userComment,
    required this.scanResultType,
    super.key,
  });

  final String scannedData;
  final String userComment;
  final ResultType scanResultType;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      child: ListView(
        shrinkWrap: true,
        padding: const .all(16),
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          Text(
            context.locale.reviewBeforeSaving,
            style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
              color: context.appColors.textPrimary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          _ReviewContentItemCard(
            fieldLabel: scanResultType == .qr
                ? context.locale.scannedContent
                : context.locale.extractedText,
            fieldValue: scannedData,
          ),
          const SizedBox(height: 12),
          if (userComment.isNotEmpty)
            _ReviewContentItemCard(
              fieldLabel: context.locale.addCommentTitle,
              fieldValue: userComment,
              isPlaceholder: userComment.isEmpty,
            ),
        ],
      ),
    );
  }
}

class _ReviewContentItemCard extends StatelessWidget {
  const _ReviewContentItemCard({
    required this.fieldLabel,
    required this.fieldValue,
    this.isPlaceholder = false,
  });

  final String fieldLabel;
  final String fieldValue;
  final bool isPlaceholder;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: .infinity,
      padding: const .all(12),
      decoration: BoxDecoration(
        color: context.appColors.surfaceL3,
        borderRadius: .circular(12),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: <Widget>[
          Text(
            fieldLabel,
            style: AppTextStyles.airbnbCerealW400S12Lh16Ls0.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            fieldValue,
            style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
              color: isPlaceholder
                  ? context.appColors.textSecondary
                  : context.appColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
