import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

enum QuickActionItem {
  scanQr(icon: 'qr_code', type: 'scan_qr'),
  extractText(icon: 'ocr_ic', type: 'extract_text'),
  history(icon: 'scan_history_ic', type: 'history');

  const QuickActionItem({required this.icon, required this.type});

  final String icon;
  final String type;
}

extension QuickActionItemEnumExtension on QuickActionItem {
  String title(final BuildContext context) {
    switch (this) {
      case QuickActionItem.scanQr:
        return context.locale.scanQrCode;
      case QuickActionItem.extractText:
        return context.locale.extractTextOcr;
      case QuickActionItem.history:
        return context.locale.viewHistory;
    }
  }
}
