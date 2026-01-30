import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_app_bar.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/bloc/sheet_selection_bloc.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/widget/create_new_sheet_button_and_form.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/widget/existing_sheets_view_builder_and_selector.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/widget/save_to_sheet_button.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/widget/scanned_data_preview.dart';

@RoutePage()
class SheetSelectionScreen extends StatelessWidget {
  const SheetSelectionScreen({
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
    return BlocProvider<SheetSelectionBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<SheetSelectionBloc>(),
      child: _SheetSelectionContent(
        scannedData: scannedData,
        userComment: userComment,
        scanResultType: scanResultType,
      ),
    );
  }
}

class _SheetSelectionContent extends StatefulWidget {
  const _SheetSelectionContent({
    required this.scannedData,
    required this.userComment,
    required this.scanResultType,
  });

  final String scannedData;
  final String userComment;
  final ResultType scanResultType;

  @override
  State<_SheetSelectionContent> createState() => _SheetSelectionContentState();
}

class _SheetSelectionContentState extends State<_SheetSelectionContent> {
  late TextEditingController _newSheetNameController;

  @override
  void initState() {
    super.initState();
    _newSheetNameController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SheetSelectionBloc>().add(
          const OnConfirmationLoadSheets(),
        );
      }
    });
  }

  @override
  void dispose() {
    _newSheetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<SheetSelectionBloc, SheetSelectionState>(
      listener: (final BuildContext context, final SheetSelectionState state) {
        if (state.scanSaveError != null) {
          _displayFeedbackMessage(context, state.scanSaveError!, false);
        } else if (state.isScanSaved) {
          _displayFeedbackMessage(
            context,
            context.locale.scanSavedSuccessfully,
            true,
          );
          if (context.mounted) {
            context.router.popUntilRoot();
          }
        }
      },
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBackground,
        appBar: CommonAppBar(
          title: context.locale.selectSheet,
          showBottomDivider: true,
        ),
        bottomNavigationBar: SafeArea(
          child: SaveToSheetButton(
            scannedData: widget.scannedData,
            userComment: widget.userComment,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            /// this create a new sheet button and form with textfield and buttons for creating one
            BlocSelector<
              SheetSelectionBloc,
              SheetSelectionState,
              ({bool isCreatingSheet, String? sheetCreationError})
            >(
              selector: (final SheetSelectionState state) => (
                isCreatingSheet: state.isCreatingSheet,
                sheetCreationError: state.sheetCreationError,
              ),
              builder:
                  (
                    final BuildContext context,
                    final ({bool isCreatingSheet, String? sheetCreationError})
                    creationData,
                  ) {
                    return CreateNewSheetButtonAndForm(
                      isCreatingSheet: creationData.isCreatingSheet,
                      sheetCreationError: creationData.sheetCreationError,
                      onCreateSheet: () {
                        context.read<SheetSelectionBloc>().add(
                          const OnConfirmationCreateSheet(),
                        );
                      },
                      onSheetNameChanged: (final String value) {
                        context.read<SheetSelectionBloc>().add(
                          OnConfirmationSheetNameChanged(value),
                        );
                      },
                    );
                  },
            ),
            const SizedBox(height: 16),
            const ExistingSheetsViewBuilderAndSelector(),
            const SizedBox(height: 24),
            ScannedDataPreview(
              scannedData: widget.scannedData,
              userComment: widget.userComment,
              scanResultType: widget.scanResultType,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _displayFeedbackMessage(
    final BuildContext context,
    final String feedbackMessage,
    final bool isSuccess,
  ) {
    ToastUtils.showToast(context, feedbackMessage, isSuccess: isSuccess);
  }
}
