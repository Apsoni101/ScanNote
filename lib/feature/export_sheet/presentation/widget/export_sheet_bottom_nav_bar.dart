import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_svg_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/outline_svg_icon_button.dart';
import 'package:qr_scanner_practice/feature/export_sheet/presentation/bloc/export_sheet_bloc.dart';

class ExportSheetBottomNavBar extends StatelessWidget {
  const ExportSheetBottomNavBar({
    required this.isEnabled,
    required this.isDownloading,
    required this.isSharing,
    super.key,
  });

  final bool isEnabled;
  final bool isDownloading;
  final bool isSharing;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.appColors.surfaceL1,
        border: Border.symmetric(
          horizontal: BorderSide(color: context.appColors.separator),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ///sharing button
          OutlineSvgIconButton(
            icon: AppAssets.shareIc,
            label: context.locale.share,
            isEnabled: isEnabled,
            isLoading: isSharing,
            onPressed: () {
              context.read<ExportSheetBloc>().add(const ShareSheetEvent());
            },
            outlineColor: context.appColors.primaryDefault,
            iconColor: context.appColors.primaryDefault,
          ),

          ///download button
          ElevatedSvgIconButton(
            icon: AppAssets.exportIc,
            label: context.locale.download,
            onPressed: () {
              context.read<ExportSheetBloc>().add(const DownloadSheetEvent());
            },
            isLoading: isDownloading,
            isEnabled: isEnabled,
            backgroundColor: context.appColors.primaryDefault,
            iconColor: context.appColors.textInversePrimary,
          ),
        ],
      ),
    );
  }
}
