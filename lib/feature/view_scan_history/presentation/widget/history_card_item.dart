import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/core/extensions/date_time_extension.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/decorated_svg_asset_icon_container.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';

/// Reusable scan card component
class HistoryCardItem extends StatelessWidget {
  const HistoryCardItem({
    required this.data,
    required this.sheetTitle,
    required this.timestamp,
    super.key,
    this.comment,
  });

  final String data;
  final String sheetTitle;
  final DateTime timestamp;
  final String? comment;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      elevation: 2,
      child: ListTile(
        title: Column(
          crossAxisAlignment: .start,
          spacing: 4,
          mainAxisSize: .min,
          children: <Widget>[
            Text(
              data,
              maxLines: 1,
              overflow: .ellipsis,
              style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                color: context.appColors.textPrimary,
              ),
            ),
            Text(
              '${context.locale.savedTo}$sheetTitle',
              maxLines: 1,
              overflow: .ellipsis,
              style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                color: context.appColors.textTertiary,
              ),
            ),
          ],
        ),
        leading: DecoratedSvgAssetIconContainer(
          assetPath: AppAssets.timeIc,
          backgroundColor: context.appColors.primaryDefault.withValues(
            alpha: 0.12,
          ),
          iconColor: context.appColors.primaryDefault,
        ),
        subtitle: _TimestampText(timestamp: timestamp),
        trailing: _QrDataWithCopyButton(data: data),
      ),
    );
  }
}

/// QR data display with copy button
class _QrDataWithCopyButton extends StatelessWidget {
  const _QrDataWithCopyButton({required this.data});

  final String data;

  void _copyToClipboard(final BuildContext context) {
    Clipboard.setData(ClipboardData(text: data));
    ToastUtils.showToast(
      context,
      context.locale.copiedToClipboard,
      isSuccess: true,
    );
  }

  @override
  Widget build(final BuildContext context) {
    return IconButton(
      icon: Icon(Icons.copy, color: context.appColors.iconPrimary, size: 20),
      onPressed: () => _copyToClipboard(context),
      padding: .zero,
    );
  }
}

/// Timestamp text component with smart formatting
class _TimestampText extends StatelessWidget {
  const _TimestampText({required this.timestamp});

  final DateTime timestamp;

  @override
  Widget build(final BuildContext context) {
    return Text(
      timestamp.toRelativeFormat(context),
      style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
        color: context.appColors.textSecondary,
      ),
    );
  }
}
