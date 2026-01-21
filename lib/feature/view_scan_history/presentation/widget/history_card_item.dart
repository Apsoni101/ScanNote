import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/core/extensions/date_time_extension.dart';

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
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.appColors.cloudBlue),
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SheetTitleBadge(title: sheetTitle),
          _QrDataWithCopyButton(data: data),
          if (comment != null && comment!.isNotEmpty)
            _CommentSection(comment: comment!),
          _TimestampText(timestamp: timestamp),
        ],
      ),
    );
  }
}

/// Sheet title badge component
class _SheetTitleBadge extends StatelessWidget {
  const _SheetTitleBadge({required this.title});

  final String title;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: context.appColors.primaryBlue.withAlpha(26),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
          color: context.appColors.primaryBlue,
        ),
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.copiedToClipboard),
        duration: const Duration(seconds: 1),
        backgroundColor: context.appColors.kellyGreen,
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Text(
            data,
            style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
              color: context.appColors.black,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: Icon(
            Icons.copy,
            color: context.appColors.primaryBlue,
            size: 20,
          ),
          onPressed: () => _copyToClipboard(context),
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

/// Comment section component
class _CommentSection extends StatelessWidget {
  const _CommentSection({required this.comment});

  final String comment;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          context.locale.commentLabel,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.slate,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          comment,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.black,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
      ],
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
        color: context.appColors.slate,
      ),
    );
  }
}
