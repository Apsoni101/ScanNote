import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<HomeScreenBloc>().add(const OnHomeSyncPendingScans()),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.semanticsIconSuccess,
        elevation: 0,
      ),
      child: Text(
        context.locale.syncButtonLabel,
        style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
          color: context.appColors.textInversePrimary,
        ),
      ),
    );
  }
}
