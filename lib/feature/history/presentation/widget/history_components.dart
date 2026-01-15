import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/date_time_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';

/// Reusable search bar component for history screen
class HistorySearchBar extends StatefulWidget {
  const HistorySearchBar({
    required this.onSearchChanged,
    super.key,
    this.hintText,
  });

  final void Function(String) onSearchChanged;
  final String? hintText;

  @override
  State<HistorySearchBar> createState() => _HistorySearchBarState();
}

class _HistorySearchBarState extends State<HistorySearchBar> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _controller,
        onChanged: widget.onSearchChanged,
        decoration: InputDecoration(
          hintText: widget.hintText ?? context.locale.searchScans,
          prefixIcon: Icon(Icons.search, color: context.appColors.slate),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: context.appColors.slate),
                  onPressed: () {
                    _controller.clear();
                    widget.onSearchChanged('');
                  },
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.appColors.cEBECFF),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: context.appColors.cEBECFF),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}

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
        Icon(Icons.history, size: iconSize, color: context.appColors.slate),
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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.error_outline, size: iconSize, color: context.appColors.red),
        Text(
          errorMessage,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// Reusable scan card component
class HistoryScanCard extends StatelessWidget {
  const HistoryScanCard({
    required this.qrData,
    required this.sheetTitle,
    required this.timestamp,
    super.key,
    this.comment,
  });

  final String qrData;
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
        border: Border.all(color: context.appColors.cEBECFF),
      ),
      child: Column(
        spacing: 12,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _SheetTitleBadge(title: sheetTitle),
          _QrDataWithCopyButton(qrData: qrData),
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
  const _QrDataWithCopyButton({required this.qrData});

  final String qrData;

  void _copyToClipboard(final BuildContext context) {
    Clipboard.setData(ClipboardData(text: qrData));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.locale.copiedToClipboard),
        duration: const Duration(seconds: 1),
        backgroundColor: context.appColors.c3BA935,
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
            qrData,
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
