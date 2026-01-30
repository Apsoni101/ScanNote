import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/enums/language_enum.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

class LanguageSelectionDialog extends StatelessWidget {
  const LanguageSelectionDialog({
    required this.currentLanguage,
    required this.onLanguageSelected,
    super.key,
  });
  final LanguageEnum currentLanguage;
  final void Function(LanguageEnum) onLanguageSelected;

  @override
  Widget build(final BuildContext context) {
    final ValueNotifier<LanguageEnum> selectedLanguageNotifier =
        ValueNotifier<LanguageEnum>(currentLanguage);

    return Dialog(
      backgroundColor: context.appColors.cardBackground,
      shape: RoundedRectangleBorder(borderRadius: .circular(16)),
      insetPadding: const .all(20),
      child: Padding(
        padding: const .all(20),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          children: <Widget>[
            const _DialogTitle(),
            const SizedBox(height: 20),

            /// Language list
            _LanguageList(selectedLanguageNotifier: selectedLanguageNotifier),

            const SizedBox(height: 20),

            /// Action buttons
            _DialogActions(
              selectedLanguageNotifier: selectedLanguageNotifier,
              onConfirm: onLanguageSelected,
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogTitle extends StatelessWidget {
  const _DialogTitle();

  @override
  Widget build(final BuildContext context) {
    return Text(
      context.locale.language,
      style: AppTextStyles.airbnbCerealW600S20Lh28Ls0.copyWith(
        color: context.appColors.textPrimary,
      ),
    );
  }
}

class _LanguageList extends StatelessWidget {
  const _LanguageList({required this.selectedLanguageNotifier});
  final ValueNotifier<LanguageEnum> selectedLanguageNotifier;

  @override
  Widget build(final BuildContext context) {
    final double maxHeight = MediaQuery.heightOf(context) * 0.5;

    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: maxHeight),
      child: ValueListenableBuilder<LanguageEnum>(
        valueListenable: selectedLanguageNotifier,
        builder:
            (
              final BuildContext context,
              final LanguageEnum selectedLanguage,
              _,
            ) {
              return ListView(
                shrinkWrap: true,
                children: LanguageEnum.values.map((
                  final LanguageEnum language,
                ) {
                  return RadioListTile<LanguageEnum>(
                    value: language,
                    groupValue: selectedLanguage,
                    onChanged: (final LanguageEnum? value) {
                      if (value != null) {
                        selectedLanguageNotifier.value = value;
                      }
                    },
                    title: Text(
                      language.nativeName,
                      style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                        color: context.appColors.textPrimary,
                      ),
                    ),
                    activeColor: context.appColors.primaryDefault,
                    contentPadding: .zero,
                  );
                }).toList(),
              );
            },
      ),
    );
  }
}

class _DialogActions extends StatelessWidget {
  const _DialogActions({
    required this.selectedLanguageNotifier,
    required this.onConfirm,
  });
  final ValueNotifier<LanguageEnum> selectedLanguageNotifier;
  final void Function(LanguageEnum) onConfirm;

  @override
  Widget build(final BuildContext context) {
    return Row(
      mainAxisAlignment: .end,
      children: <Widget>[
        /// Cancel
        TextButton(
          onPressed: () => context.router.pop(),
          child: Text(
            context.locale.cancel,
            style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
              color: context.appColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: 12),

        /// Confirm
        ValueListenableBuilder<LanguageEnum>(
          valueListenable: selectedLanguageNotifier,
          builder:
              (
                final BuildContext context,
                final LanguageEnum selectedLanguage,
                _,
              ) {
                return ElevatedButton(
                  onPressed: () {
                    onConfirm(selectedLanguage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.appColors.primaryDefault,
                    shape: RoundedRectangleBorder(borderRadius: .circular(8)),
                  ),
                  child: Text(
                    context.locale.confirm,
                    style: AppTextStyles.airbnbCerealW500S16Lh24Ls0.copyWith(
                      color: context.appColors.textInversePrimary,
                    ),
                  ),
                );
              },
        ),
      ],
    );
  }
}
