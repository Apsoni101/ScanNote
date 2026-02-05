import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

enum ExportFormat {
  pdf(icon: '📄', mimeType: 'application/pdf'),
  excel(
    icon: '📊',
    mimeType:
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
  ),
  csv(icon: '📋', mimeType: 'text/csv');

  const ExportFormat({required this.icon, required this.mimeType});

  final String icon;
  final String mimeType;
}

extension ExportFormatExtension on ExportFormat {
  String title(final BuildContext context) {
    return switch (this) {
      ExportFormat.pdf => context.locale.pdfDocument,
      ExportFormat.excel => context.locale.excelSpreadsheet,
      ExportFormat.csv => context.locale.csvFile,
    };
  }

  String subtitle(final BuildContext context) {
    return switch (this) {
      ExportFormat.pdf => context.locale.formattedAndPrintablePdfFile,
      ExportFormat.excel => context.locale.editableXlsxFileWithFormulas,
      ExportFormat.csv => context.locale.commaSeparatedValuesForDataTransfer,
    };
  }

  Color backgroundColor(final BuildContext context) {
    return switch (this) {
      ExportFormat.pdf => context.appColors.pdfIconBackground,
      ExportFormat.excel => context.appColors.excelIconBackground,
      ExportFormat.csv => context.appColors.csvIconBackground,
    };
  }

  Color textColor(final BuildContext context) {
    return switch (this) {
      ExportFormat.pdf => context.appColors.pdfTextBackground,
      ExportFormat.excel => context.appColors.excelTextBackground,
      ExportFormat.csv => context.appColors.csvTextBackground,
    };
  }
}
