import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_app_bar.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/widgets/comment_input_card.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/widgets/ocr_preview_image.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/widgets/scan_result_section.dart';

@RoutePage()
class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({
    required this.scanResult,
    required this.resultType,
    this.previewImage,

    super.key,
  });

  final String scanResult;
  final ImageProvider? previewImage;
  final ResultType resultType;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ResultBloc>(
      create: (final BuildContext context) => AppInjector.getIt<ResultBloc>(),
      child: _ResultView(
        scanResult: scanResult,
        resultType: resultType,
        previewImage: previewImage,
      ),
    );
  }
}

class _ResultView extends StatefulWidget {
  const _ResultView({
    required this.scanResult,
    required this.resultType,
    this.previewImage,
  });

  final String scanResult;
  final ResultType resultType;
  final ImageProvider? previewImage;

  @override
  State<_ResultView> createState() => _ResultViewState();
}

class _ResultViewState extends State<_ResultView> {
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final ImageProvider<Object>? imagePreview = widget.previewImage;
    return Scaffold(
      backgroundColor: context.appColors.scaffoldBackground,
      appBar: CommonAppBar(
        title: widget.resultType == .qr
            ? context.locale.qrResult
            : context.locale.extractedText,
        showBottomDivider: true,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appColors.surfaceL1,
          border: Border.symmetric(
            horizontal: BorderSide(color: context.appColors.separator),
          ),
        ),
        child: _SelectGoogleSheetButton(
          commentController: _commentController,
          data: widget.scanResult,
          resultType: widget.resultType,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: <Widget>[
          if (imagePreview != null) ...<Widget>[
            OcrImagePreview(image: imagePreview),
            const SizedBox(height: 24),
          ],
          ScanResultSection(
            scannedResult: widget.scanResult,
            resultType: widget.resultType,
          ),
          const SizedBox(height: 24),
          CommentInputCard(commentController: _commentController),
        ],
      ),
    );
  }
}

class _SelectGoogleSheetButton extends StatelessWidget {
  const _SelectGoogleSheetButton({
    required this.commentController,
    required this.data,
    required this.resultType,
  });

  final TextEditingController commentController;
  final String data;
  final ResultType resultType;

  @override
  Widget build(final BuildContext context) {
    return BlocBuilder<ResultBloc, ResultState>(
      builder: (final BuildContext context, final ResultState state) {
        return ElevatedButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            final String comment = state.comment;
            context.router.push(
              SheetSelectionRoute(
                scannedData: data,
                userComment: comment,
                scanResultType: resultType,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: context.appColors.primaryDefault,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
          ),
          child: Text(
            context.locale.selectGoogleSheet,
            style: AppTextStyles.airbnbCerealW600S16Lh24Ls0.copyWith(
              color: context.appColors.textInverseSecondary,
            ),
          ),
        );
      },
    );
  }
}
