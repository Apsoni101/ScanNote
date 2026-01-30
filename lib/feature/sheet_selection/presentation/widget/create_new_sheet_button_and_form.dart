import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/error_or_empty_message_container.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/presentation/bloc/sheet_selection_bloc.dart';

class CreateNewSheetButtonAndForm extends StatefulWidget {
  const CreateNewSheetButtonAndForm({
    required this.isCreatingSheet,
    required this.sheetCreationError,
    required this.onCreateSheet,
    required this.onSheetNameChanged,
    super.key,
  });

  final bool isCreatingSheet;
  final String? sheetCreationError;
  final VoidCallback onCreateSheet;
  final ValueChanged<String> onSheetNameChanged;

  @override
  State<CreateNewSheetButtonAndForm> createState() =>
      _CreateNewSheetButtonAndFormState();
}

class _CreateNewSheetButtonAndFormState
    extends State<CreateNewSheetButtonAndForm> {
  late TextEditingController _sheetNameController;

  @override
  void initState() {
    super.initState();
    _sheetNameController = TextEditingController();
  }

  @override
  void dispose() {
    _sheetNameController.dispose();
    super.dispose();
  }

  void _toggleFormVisibility(
    final BuildContext context,
    final bool isCreating,
  ) {
    context.read<SheetSelectionBloc>().add(
      OnConfirmationModeToggled(isCreating: !isCreating),
    );
    if (isCreating) {
      _sheetNameController.clear();
    }
  }

  void _handleCreateSheet() {
    widget.onCreateSheet();
  }

  void _handleCancel(final BuildContext context) {
    _sheetNameController.clear();
    context.read<SheetSelectionBloc>().add(
      const OnConfirmationModeToggled(isCreating: false),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return BlocConsumer<SheetSelectionBloc, SheetSelectionState>(
      listener: (final BuildContext context, final SheetSelectionState state) {
        final bool hasJustFinishedCreating = !state.isCreatingSheet;
        final bool hasSelectedSheet = state.selectedSheetId != null;
        final bool noError = state.sheetCreationError == null;
        final bool formIsOpen = state.isCreatingNewSheet;

        if (hasJustFinishedCreating &&
            hasSelectedSheet &&
            noError &&
            formIsOpen) {
          _sheetNameController.clear();
          context.read<SheetSelectionBloc>().add(
            const OnConfirmationModeToggled(isCreating: false),
          );
        }
      },
      listenWhen:
          (
            final SheetSelectionState previous,
            final SheetSelectionState current,
          ) {
            final bool wasCreating = previous.isCreatingSheet;
            final bool isNotCreating = !current.isCreatingSheet;
            return wasCreating && isNotCreating;
          },
      buildWhen:
          (
            final SheetSelectionState previous,
            final SheetSelectionState current,
          ) {
            return previous.isCreatingNewSheet != current.isCreatingNewSheet ||
                previous.isCreatingSheet != current.isCreatingSheet ||
                previous.sheetCreationError != current.sheetCreationError;
          },
      builder: (final BuildContext context, final SheetSelectionState state) {
        if (state.isCreatingNewSheet) {
          return _CreateSheetForm(
            controller: _sheetNameController,
            isCreatingSheet: widget.isCreatingSheet,
            sheetCreationError: widget.sheetCreationError,
            onSheetNameChanged: widget.onSheetNameChanged,
            onCreateSheet: _handleCreateSheet,
            onCancel: () => _handleCancel(context),
          );
        }
        return _CreateSheetButton(
          onPressed: () =>
              _toggleFormVisibility(context, state.isCreatingNewSheet),
        );
      },
    );
  }
}

class _CreateSheetButton extends StatelessWidget {
  const _CreateSheetButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return ElevatedIconButton(
      icon: Icons.add,
      label: context.locale.createNewSheet,
      onPressed: onPressed,
      backgroundColor: context.appColors.surfaceL1,
      iconColor: context.appColors.primaryDefault,
      labelColor: context.appColors.textPrimary,
      borderSide: BorderSide(color: context.appColors.borderInputDefault),
    );
  }
}

class _CreateSheetForm extends StatelessWidget {
  const _CreateSheetForm({
    required this.controller,
    required this.isCreatingSheet,
    required this.sheetCreationError,
    required this.onSheetNameChanged,
    required this.onCreateSheet,
    required this.onCancel,
  });

  final TextEditingController controller;
  final bool isCreatingSheet;
  final String? sheetCreationError;
  final ValueChanged<String> onSheetNameChanged;
  final VoidCallback onCreateSheet;
  final VoidCallback onCancel;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      elevation: 2,
      child: ListView(
        shrinkWrap: true,
        padding: const .all(16),
        children: <Widget>[
          _SheetNameTextField(
            controller: controller,
            isEnabled: !isCreatingSheet,
            onChanged: onSheetNameChanged,
          ),
          if (sheetCreationError != null)
            ErrorOrEmptyMessageContainer(
              message: sheetCreationError ?? '',
              backgroundColor: context.appColors.semanticsIconError.withValues(
                alpha: 0.1,
              ),
              textColor: context.appColors.semanticsIconError,
            ),
          const SizedBox(height: 12),
          _FormActionButtons(
            isCreatingSheet: isCreatingSheet,
            onCreateSheet: onCreateSheet,
            onCancel: onCancel,
          ),
        ],
      ),
    );
  }
}

class _SheetNameTextField extends StatelessWidget {
  const _SheetNameTextField({
    required this.controller,
    required this.isEnabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool isEnabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(final BuildContext context) {
    return TextField(
      controller: controller,
      enabled: isEnabled,
      autofocus: true,
      onChanged: onChanged,
      style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
        color: context.appColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: context.locale.enterSheetName,
        hintStyle: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
          color: context.appColors.textTertiary,
        ),
        filled: true,
        fillColor: context.appColors.surfaceL1,
        border: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: context.appColors.borderInputDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(color: context.appColors.borderInputDefault),
        ),
        contentPadding: const .symmetric(horizontal: 12),
        focusedBorder: OutlineInputBorder(
          borderRadius: .circular(12),
          borderSide: BorderSide(
            color: context.appColors.primaryDefault,
            width: 2,
          ),
        ),
      ),
    );
  }
}

class _FormActionButtons extends StatelessWidget {
  const _FormActionButtons({
    required this.isCreatingSheet,
    required this.onCreateSheet,
    required this.onCancel,
  });

  final bool isCreatingSheet;
  final VoidCallback onCreateSheet;
  final VoidCallback onCancel;

  @override
  Widget build(final BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: _CommonButton(
            isLoading: isCreatingSheet,
            isDisabled: isCreatingSheet,
            onPressed: onCreateSheet,
            label: context.locale.create,
            backgroundColor: context.appColors.primaryDefault,
            textColor: context.appColors.textInversePrimary,
            loadingColor: context.appColors.textInversePrimary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _CommonButton(
            isLoading: false,
            isDisabled: isCreatingSheet,
            onPressed: onCancel,
            label: context.locale.cancel,
            backgroundColor: context.appColors.surfaceL3,
            textColor: context.appColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _CommonButton extends StatelessWidget {
  const _CommonButton({
    required this.isLoading,
    required this.isDisabled,
    required this.onPressed,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.loadingColor,
    this.borderRadius = 8,
    this.verticalPadding = 12,
  });

  final bool isLoading;
  final bool isDisabled;
  final VoidCallback onPressed;
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final Color? loadingColor;
  final double borderRadius;
  final double verticalPadding;

  @override
  Widget build(final BuildContext context) {
    return TextButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        disabledBackgroundColor: backgroundColor.withValues(alpha: 0.5),
        padding: .symmetric(vertical: verticalPadding),
        shape: RoundedRectangleBorder(borderRadius: .circular(borderRadius)),
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  loadingColor ?? textColor,
                ),
              ),
            )
          : Text(
              label,
              style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                color: textColor,
              ),
            ),
    );
  }
}
