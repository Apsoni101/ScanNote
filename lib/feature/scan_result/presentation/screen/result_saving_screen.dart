import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/result_type.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/core/extensions/string_extensions.dart';

import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/bloc/result_saving_bloc/result_saving_bloc.dart';

@RoutePage()
class ResultSavingScreen extends StatelessWidget {
  const ResultSavingScreen({
    required this.data,
    required this.comment,
    required this.resultType,
    super.key,
  });

  final String data;
  final String comment;
  final ResultType resultType;

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ResultSavingBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<ResultSavingBloc>(),
      child: _ResultSavingView(
        data: data,
        comment: comment,
        resultType: resultType,
      ),
    );
  }
}

class _ResultSavingView extends StatefulWidget {
  const _ResultSavingView({
    required this.data,
    required this.comment,
    required this.resultType,
  });

  final String data;
  final String comment;
  final ResultType resultType;

  @override
  State<_ResultSavingView> createState() => _ResultSavingViewState();
}

class _ResultSavingViewState extends State<_ResultSavingView> {
  late TextEditingController _sheetNameController;

  @override
  void initState() {
    super.initState();
    _sheetNameController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<ResultSavingBloc>().add(const OnConfirmationLoadSheets());
      }
    });
  }

  @override
  void dispose() {
    _sheetNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<ResultSavingBloc, ResultSavingState>(
      listener: (final BuildContext context, final ResultSavingState state) {
        if (state.scanSaveError != null) {
          _showSnackBar(context, state.scanSaveError!, context.appColors.red);
        } else if (state.isScanSaved) {
          _showSnackBar(
            context,
            context.locale.scanSavedSuccessfully,
            context.appColors.kellyGreen,
          );
          if (context.mounted) {
            context.router.maybePop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: context.appColors.white,
        appBar: _buildAppBar(context),
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            _ScanDetailsSection(
              data: widget.data,
              comment: widget.comment,
              resultType: widget.resultType,
            ),
            const SizedBox(height: 24),
            BlocSelector<ResultSavingBloc, ResultSavingState, bool>(
              selector: (final ResultSavingState state) =>
                  state.isCreatingNewSheet,
              builder:
                  (final BuildContext context, final bool isCreatingNewSheet) {
                    return isCreatingNewSheet
                        ? _CreateNewSheetSection(
                            controller: _sheetNameController,
                          )
                        : const _SelectSheetSection();
                  },
            ),
            const SizedBox(height: 24),
            const _ModeToggleButton(),
          ],
        ),
        bottomNavigationBar: SafeArea(
          child: _ConfirmationActionButtons(
            data: widget.data,
            comment: widget.comment,
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(final BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.white,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.appColors.black),
        onPressed: () => context.router.maybePop(),
      ),
      title: Text(
        context.locale.confirmAndSaveTitle,
        style: AppTextStyles.airbnbCerealW500S18Lh24Ls0.copyWith(
          color: context.appColors.black,
        ),
      ),
    );
  }

  void _showSnackBar(
    final BuildContext context,
    final String message,
    final Color bgColor,
  ) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: bgColor));
  }
}

/// ============================================================================
/// SCAN DETAILS SECTION
/// ============================================================================
class _ScanDetailsSection extends StatelessWidget {
  const _ScanDetailsSection({
    required this.data,
    required this.comment,
    required this.resultType,
  });

  final String data;
  final String comment;
  final ResultType resultType;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          resultType == ResultType.qr
              ? context.locale.scanDetailsTitle
              : context.locale.extractedText,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.black,
          ),
        ),
        const SizedBox(height: 16),
        _DetailRow(
          label: resultType == ResultType.qr
              ? context.locale.scannedDataTitle
              : context.locale.extractedText,
          value: data,
        ),
        const SizedBox(height: 12),
        _DetailRow(
          label: context.locale.addCommentTitle,
          value: comment.isEmpty ? context.locale.noCommentAdded : comment,
          isSubtle: comment.isEmpty,
        ),
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({
    required this.label,
    required this.value,
    this.isSubtle = false,
  });

  final String label;
  final String value;
  final bool isSubtle;

  @override
  Widget build(final BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
            color: context.appColors.slate,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: context.appColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
              color: isSubtle
                  ? context.appColors.slate
                  : context.appColors.black,
            ),
          ),
        ),
      ],
    );
  }
}

/// ============================================================================
/// SELECT SHEET SECTION
/// ============================================================================
class _SelectSheetSection extends StatelessWidget {
  const _SelectSheetSection();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      ResultSavingBloc,
      ResultSavingState,
      ({bool isLoading, String? error, List<SheetEntity> sheets})
    >(
      selector: (final ResultSavingState state) => (
        isLoading: state.isLoadingSheets,
        error: state.sheetsLoadError,
        sheets: state.sheets,
      ),
      builder:
          (
            final BuildContext context,
            final ({String? error, bool isLoading, List<SheetEntity> sheets})
            data,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.locale.selectSheetTitle,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.slate,
                  ),
                ),
                const SizedBox(height: 12),
                if (data.isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      color: context.appColors.primaryBlue,
                    ),
                  )
                else if (data.error != null)
                  _ErrorContainer(message: data.error ?? '')
                else if (data.sheets.isEmpty)
                  _EmptyStateContainer(
                    message: context.locale.noSheetsAvailable,
                  )
                else
                  _SheetsList(sheets: data.sheets),
              ],
            );
          },
    );
  }
}

class _SheetsList extends StatelessWidget {
  const _SheetsList({required this.sheets});

  final List<SheetEntity> sheets;

  @override
  Widget build(final BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: context.appColors.lightGray),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: sheets.length,
        separatorBuilder: (final _, final __) =>
            Divider(height: 1, color: context.appColors.lightGray),
        itemBuilder: (final _, final int index) {
          final SheetEntity sheet = sheets[index];
          return _SheetItem(sheet: sheet);
        },
      ),
    );
  }
}

class _SheetItem extends StatelessWidget {
  const _SheetItem({required this.sheet});

  final SheetEntity sheet;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<ResultSavingBloc, ResultSavingState, String?>(
      selector: (final ResultSavingState state) => state.selectedSheetId,
      builder: (final BuildContext context, final String? selectedSheetId) {
        return RadioListTile<String>(
          value: sheet.id,
          groupValue: selectedSheetId,
          onChanged: (final String? value) {
            context.read<ResultSavingBloc>().add(
              OnConfirmationSheetSelected(sheet.id),
            );
          },
          activeColor: context.appColors.primaryBlue,
          title: Text(
            sheet.title,
            style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
              color: context.appColors.black,
            ),
          ),
          subtitle: sheet.modifiedTime != null
              ? Text(
                  context.locale.modified(sheet.modifiedTime.toFriendlyDate()),
                  style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                    color: context.appColors.slate,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          selected: selectedSheetId == sheet.id,
          selectedTileColor: Colors.transparent,
        );
      },
    );
  }
}

// ============================================================================
// CREATE NEW SHEET SECTION
// ============================================================================
class _CreateNewSheetSection extends StatelessWidget {
  const _CreateNewSheetSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      ResultSavingBloc,
      ResultSavingState,
      ({bool isCreating, String? error})
    >(
      selector: (final ResultSavingState state) =>
          (isCreating: state.isCreatingSheet, error: state.sheetCreationError),
      builder:
          (
            final BuildContext context,
            final ({String? error, bool isCreating}) data,
          ) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.locale.newSheetNameTitle,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.slate,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  enabled: !data.isCreating,
                  onChanged: (final String value) {
                    context.read<ResultSavingBloc>().add(
                      OnConfirmationSheetNameChanged(value),
                    );
                  },
                  style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
                    color: context.appColors.black,
                  ),
                  decoration: InputDecoration(
                    hintText: context.locale.sheetNameHint,
                    hintStyle: AppTextStyles.airbnbCerealW400S14Lh20Ls0
                        .copyWith(color: context.appColors.slate),
                    filled: true,
                    fillColor: context.appColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: context.appColors.lightGray,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: context.appColors.lightGray,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: context.appColors.primaryBlue,
                        width: 2,
                      ),
                    ),
                  ),
                ),
                if (data.error != null) ...<Widget>[
                  const SizedBox(height: 8),
                  _ErrorContainer(message: data.error ?? ''),
                ],
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: data.isCreating
                        ? null
                        : () {
                            context.read<ResultSavingBloc>().add(
                              const OnConfirmationCreateSheet(),
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.primaryBlue,
                    ),
                    child: data.isCreating
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                context.appColors.white,
                              ),
                            ),
                          )
                        : Text(
                            context.locale.createSheetButton,
                            style: AppTextStyles.airbnbCerealW500S14Lh20Ls0
                                .copyWith(color: context.appColors.white),
                          ),
                  ),
                ),
              ],
            );
          },
    );
  }
}

// ============================================================================
// MODE TOGGLE BUTTON
// ============================================================================
class _ModeToggleButton extends StatelessWidget {
  const _ModeToggleButton();

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<ResultSavingBloc, ResultSavingState, bool>(
      selector: (final ResultSavingState state) => state.isCreatingNewSheet,
      builder: (final BuildContext context, final bool isCreatingNewSheet) {
        return InkWell(
          onTap: () {
            context.read<ResultSavingBloc>().add(
              OnConfirmationModeToggled(!isCreatingNewSheet),
            );
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.appColors.lightGray.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Icon(
                  isCreatingNewSheet ? Icons.add_circle : Icons.list,
                  color: context.appColors.primaryBlue,
                ),
                const SizedBox(width: 12),
                Text(
                  isCreatingNewSheet
                      ? context.locale.switchToSelectSheet
                      : context.locale.createNewSheet,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.primaryBlue,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ============================================================================
// CONFIRMATION ACTION BUTTONS
// ============================================================================
class _ConfirmationActionButtons extends StatelessWidget {
  const _ConfirmationActionButtons({required this.data, required this.comment});

  final String data;
  final String comment;

  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      ResultSavingBloc,
      ResultSavingState,
      ({bool isLoading, bool canSave, bool isSaving})
    >(
      selector: (final ResultSavingState state) {
        final bool isLoading =
            state.isSavingScan ||
            state.isCreatingSheet ||
            state.isLoadingSheets;

        final bool canSave =
            !isLoading &&
            state.selectedSheetId != null &&
            state.sheetsLoadError == null;

        return (
          isLoading: isLoading,
          canSave: canSave,
          isSaving: state.isSavingScan,
        );
      },
      builder:
          (
            final BuildContext context,
            final ({bool canSave, bool isLoading, bool isSaving}) selectorData,
          ) {
            return Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  OutlinedButton(
                    onPressed: selectorData.isLoading
                        ? null
                        : () => context.router.maybePop(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: context.appColors.lightGray),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      context.locale.cancelButton,
                      style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                        color: context.appColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  BlocSelector<
                    ResultSavingBloc,
                    ResultSavingState,
                    ({String? selectedSheetId, List<SheetEntity> sheets})
                  >(
                    selector: (final ResultSavingState state) => (
                      selectedSheetId: state.selectedSheetId,
                      sheets: state.sheets,
                    ),
                    builder:
                        (
                          final BuildContext context,
                          final ({
                            String? selectedSheetId,
                            List<SheetEntity> sheets,
                          })
                          sheetData,
                        ) {
                          final String selectedSheetTitle =
                              sheetData.sheets
                                  .where(
                                    (final SheetEntity sheet) =>
                                        sheet.id == sheetData.selectedSheetId,
                                  )
                                  .firstOrNull
                                  ?.title ??
                              '';

                          return ElevatedButton(
                            onPressed: selectorData.canSave
                                ? () {
                                    final ScanResultEntity scanEntity =
                                        ScanResultEntity(
                                          data: data,
                                          comment: comment,
                                          timestamp: DateTime.now(),
                                        );

                                    context.read<ResultSavingBloc>().add(
                                      OnConfirmationSaveScan(
                                        scanEntity,
                                        sheetData.selectedSheetId ?? '',
                                        selectedSheetTitle,
                                      ),
                                    );
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: context.appColors.primaryBlue,
                              disabledBackgroundColor: context.appColors.slate
                                  .withValues(alpha: 0.3),
                            ),
                            child: selectorData.isSaving
                                ? SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        context.appColors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    context.locale.confirm,
                                    style: AppTextStyles
                                        .airbnbCerealW500S14Lh20Ls0
                                        .copyWith(
                                          color: context.appColors.white,
                                        ),
                                  ),
                          );
                        },
                  ),
                ],
              ),
            );
          },
    );
  }
}

/// ============================================================================
/// ERROR & EMPTY STATE CONTAINERS
/// ============================================================================
class _ErrorContainer extends StatelessWidget {
  const _ErrorContainer({required this.message});

  final String message;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
          color: context.appColors.red,
        ),
      ),
    );
  }
}

class _EmptyStateContainer extends StatelessWidget {
  const _EmptyStateContainer({required this.message});

  final String message;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.appColors.lightGray,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        message,
        style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
          color: context.appColors.slate,
        ),
      ),
    );
  }
}
