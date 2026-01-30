import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';

import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/widgets/section_title.dart';

class ScanResultSection extends StatelessWidget {
  const ScanResultSection({
    required this.scannedResult,
    required this.resultType,
    super.key,
  });

  final String scannedResult;
  final ResultType resultType;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: SectionTitle(
                label: resultType == .qr
                    ? context.locale.scannedContent
                    : context.locale.extractedText,
              ),
              trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: scannedResult));
                  ToastUtils.showToast(
                    context,
                    context.locale.copiedToClipboard,
                    isSuccess: true,
                  );
                },
                iconSize: 20,
                style: IconButton.styleFrom(padding: EdgeInsets.zero),
                icon: SvgPicture.asset(AppAssets.copyIc, width: 20, height: 20),
              ),
            ),
            const SizedBox(height: 8),
            _ScannedDataBox(
              child: Text(
                scannedResult,
                style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                  color: context.appColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScannedDataBox extends StatelessWidget {
  const _ScannedDataBox({required this.child});

  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.surfaceL3,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
