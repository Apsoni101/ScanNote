import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/asset_constants.dart';

import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/on_screen_option_item_card.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/sync_status_banner.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<HomeScreenBloc>()..add(const OnHomeLoadInitial()),
      child: const HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => HomeScreenViewState();
}

class HomeScreenViewState extends State<HomeScreenView>
    with RouteAware, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.read<HomeScreenBloc>().add(const OnHomeUpdatePendingCount());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    return BlocListener<HomeScreenBloc, HomeScreenState>(
      listener: _handleStateChanges,
      child: Scaffold(
        backgroundColor: context.appColors.scaffoldBackground,
        body: ListView(
          padding: const EdgeInsets.all(24),
          children: <Widget>[
            const SyncStatusBanner(),
            const SizedBox(height: 12),
            OnScreenOptionItemCard(
              iconPath: AppAssets.qrIc,
              title: context.locale.scanQrCode,
              subtitle: context.locale.pointCameraAtQrCodeToScanInstantly,
              onPressed: () {
                context.router.push(const QrScanningRoute());
              },
            ),
            const SizedBox(height: 12),
            OnScreenOptionItemCard(
              animationDuration: const Duration(milliseconds: 2500),
              iconPath: AppAssets.sheetIc,
              title: context.locale.extractTextOcr,
              subtitle: context.locale.extractTextFromImagesOrCamera,
              onPressed: () {
                context.router.push(const OcrRoute());
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleStateChanges(
    final BuildContext context,
    final HomeScreenState state,
  ) {
    if (state.showSyncSuccess && state.pendingSyncCount == 0) {
      _showSnackBar(context, context.locale.allScansSuccessfullyMessage, true);
      context.read<HomeScreenBloc>().add(const OnHomeResetSyncSuccess());
    }

    if (state.syncError != null && state.syncError!.isNotEmpty) {
      _showSnackBar(context, state.syncError!, false);
      context.read<HomeScreenBloc>().add(const OnHomeResetSyncError());
    }

    if (state.error != null && state.error!.isNotEmpty) {
      _showSnackBar(context, state.error!, false);
      context.read<HomeScreenBloc>().add(const OnHomeResetError());
    }
  }

  void _showSnackBar(
    final BuildContext context,
    final String message,
    final bool isSuccess,
  ) {
    ToastUtils.showToast(context, message, isSuccess: isSuccess);
  }
}
