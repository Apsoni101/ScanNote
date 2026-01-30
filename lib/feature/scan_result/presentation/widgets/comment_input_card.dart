import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/feature/common/presentation/widgets/rounded_corner_elevated_card.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/bloc/result_bloc/result_bloc.dart';
import 'package:qr_scanner_practice/feature/scan_result/presentation/widgets/section_title.dart';

class CommentInputCard extends StatelessWidget {
  const CommentInputCard({required this.commentController, super.key});

  final TextEditingController commentController;

  @override
  Widget build(final BuildContext context) {
    return RoundedCornerElevatedCard(
      elevation: 2,
      child: Padding(
        padding: const .all(16),
        child: Column(
          spacing: 8,
          crossAxisAlignment: .start,
          children: <Widget>[
            SectionTitle(label: context.locale.addCommentTitle),
            CommentInputField(controller: commentController),
          ],
        ),
      ),
    );
  }
}

class CommentInputField extends StatelessWidget {
  const CommentInputField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  Widget build(final BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (final String value) {
        context.read<ResultBloc>().add(OnResultCommentChanged(value));
      },
      maxLines: 4,
      style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
        color: context.appColors.textPrimary,
      ),
      decoration: _buildInputDecoration(context),
    );
  }

  InputDecoration _buildInputDecoration(final BuildContext context) {
    final BorderRadius borderRadius = .circular(12);
    final BorderSide normalBorder = BorderSide(
      color: context.appColors.textInverseSecondary,
    );
    final BorderSide focusedBorder = BorderSide(
      color: context.appColors.primaryDefault,
      width: 2,
    );

    return InputDecoration(
      hintText: context.locale.addANoteOrDescription,
      hintStyle: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
        color: context.appColors.textSecondary,
      ),
      filled: true,
      fillColor: context.appColors.textInversePrimary,
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: normalBorder,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: normalBorder,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: focusedBorder,
      ),
    );
  }
}
