import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/core/navigation/app_router.gr.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<HomeScreenBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<HomeScreenBloc>()..add(const OnHomeLoadInitial()),
      child: const _HomeScreenView(),
    );
  }
}

class _HomeScreenView extends StatefulWidget {
  const _HomeScreenView();

  @override
  State<_HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<_HomeScreenView>
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
        backgroundColor: context.appColors.cF6F9FF,
        appBar: _buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeScreenBloc>().add(const OnHomeRefreshSheets());
          },
          color: context.appColors.primaryBlue,
          backgroundColor: context.appColors.white,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: <Widget>[
              _SyncStatusBanner(),
              const SizedBox(height: 32),
              _QrIconSection(context),
              const SizedBox(height: 32),
              _QrTitleSection(context),
              const SizedBox(height: 48),
              _ActionButtonsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStateChanges(
    final BuildContext context,
    final HomeScreenState state,
  ) {
    if (state.showSyncSuccess && state.pendingSyncCount == 0) {
      _showSnackBar(
        context,
        context.locale.allScansSuccessfullyMessage,
        context.appColors.c3BA935,
      );
      context.read<HomeScreenBloc>().add(const OnHomeResetSyncSuccess());
    }

    if (state.syncError != null && state.syncError!.isNotEmpty) {
      _showSnackBar(context, state.syncError!, context.appColors.red);
      context.read<HomeScreenBloc>().add(const OnHomeResetSyncError());
    }

    if (state.error != null && state.error!.isNotEmpty) {
      _showSnackBar(context, state.error!, context.appColors.red);
      context.read<HomeScreenBloc>().add(const OnHomeResetError());
    }
  }

  void _showSnackBar(
    final BuildContext context,
    final String message,
    final Color bgColor,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(final BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.white,
      elevation: 0,
      title: Text(
        context.locale.qrScanner,
        style: AppTextStyles.airbnbCerealW500S18Lh24Ls0.copyWith(
          color: context.appColors.black,
        ),
      ),
      centerTitle: true,
      actions: <Widget>[_SyncStatusIndicator()],
    );
  }
}

class _SyncStatusBanner extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      HomeScreenBloc,
      HomeScreenState,
      ({int pendingCount, bool isOnline, bool isSyncing})
    >(
      selector: (final HomeScreenState state) => (
        pendingCount: state.pendingSyncCount,
        isOnline: state.isOnline,
        isSyncing: state.isSyncing,
      ),
      builder:
          (
            final BuildContext context,
            final ({bool isOnline, bool isSyncing, int pendingCount}) data,
          ) {
            if (data.pendingCount == 0) {
              return const SizedBox.shrink();
            }

            if (data.isSyncing) {
              return _SyncingBanner(pendingCount: data.pendingCount);
            }

            if (!data.isOnline) {
              return _OfflineBanner(pendingCount: data.pendingCount);
            }

            return _ReadyToSyncBanner(pendingCount: data.pendingCount);
          },
    );
  }
}

class _SyncingBanner extends StatelessWidget {
  const _SyncingBanner({required this.pendingCount});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return _BannerContainer(
      backgroundColor: context.appColors.primaryBlue.withAlpha(26),
      borderColor: context.appColors.primaryBlue.withAlpha(77),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.appColors.primaryBlue,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getSyncingMessage(context, pendingCount),
              style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                color: context.appColors.primaryBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getSyncingMessage(final BuildContext context, final int count) {
    if (count == 1) {
      return context.locale.syncingMessage(count);
    }
    return context.locale.syncingMessagePlural(count);
  }
}

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner({required this.pendingCount});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return _BannerContainer(
      backgroundColor: context.appColors.red.withAlpha(26),
      borderColor: context.appColors.red.withAlpha(77),
      child: Row(
        children: <Widget>[
          Icon(Icons.cloud_off, color: context.appColors.red, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  context.locale.offlineMode,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.red,
                  ),
                ),
                Text(
                  _getWaitingToSyncMessage(context, pendingCount),
                  style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                    color: context.appColors.slate,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getWaitingToSyncMessage(final BuildContext context, final int count) {
    if (count == 1) {
      return context.locale.waitingToSyncMessage(count);
    }
    return context.locale.waitingToSyncMessagePlural(count);
  }
}

class _ReadyToSyncBanner extends StatelessWidget {
  const _ReadyToSyncBanner({required this.pendingCount});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return _BannerContainer(
      backgroundColor: context.appColors.c3BA935.withAlpha(26),
      borderColor: context.appColors.c3BA935.withAlpha(77),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _getScanToSyncMessage(context, pendingCount),
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.c3BA935,
                  ),
                ),
                Text(
                  context.locale.connectionAvailableSync,
                  style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                    color: context.appColors.slate,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          _SyncButton(),
        ],
      ),
    );
  }

  String _getScanToSyncMessage(final BuildContext context, final int count) {
    if (count == 1) {
      return context.locale.scanToSyncMessage(count);
    }
    return context.locale.scanToSyncMessagePlural(count);
  }
}

class _BannerContainer extends StatelessWidget {
  const _BannerContainer({
    required this.backgroundColor,
    required this.borderColor,
    required this.child,
  });

  final Color backgroundColor;
  final Color borderColor;
  final Widget child;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: child,
    );
  }
}

class _SyncStatusIndicator extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return BlocSelector<
      HomeScreenBloc,
      HomeScreenState,
      ({int pendingCount, bool isSyncing})
    >(
      selector: (final HomeScreenState state) =>
          (pendingCount: state.pendingSyncCount, isSyncing: state.isSyncing),
      builder:
          (
            final BuildContext context,
            final ({bool isSyncing, int pendingCount}) data,
          ) {
            if (data.pendingCount == 0) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: data.isSyncing
                    ? SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            context.appColors.primaryBlue,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: context.appColors.red.withAlpha(51),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${data.pendingCount}',
                          style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                            color: context.appColors.red,
                          ),
                        ),
                      ),
              ),
            );
          },
    );
  }
}

class _QrIconSection extends StatelessWidget {
  const _QrIconSection(this.context);

  final BuildContext context;

  @override
  Widget build(final BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.appColors.cEBECFF,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(
        Icons.qr_code_scanner,
        size: 64,
        color: context.appColors.primaryBlue,
      ),
    );
  }
}

class _QrTitleSection extends StatelessWidget {
  const _QrTitleSection(this.context);

  final BuildContext context;

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          context.locale.scanQrCode,
          style: AppTextStyles.airbnbCerealW700S24Lh32LsMinus1.copyWith(
            color: context.appColors.black,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 12),
        Text(
          context.locale.pointCameraToScanQr,
          style: AppTextStyles.airbnbCerealW400S14Lh20Ls0.copyWith(
            color: context.appColors.slate,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _ActionButtonsSection extends StatelessWidget {
  const _ActionButtonsSection(this.context);

  final BuildContext context;

  @override
  Widget build(final BuildContext context) {
    return Column(
      spacing: 16,
      children: <Widget>[
        _PrimaryButton(
          icon: Icons.qr_code_scanner,
          label: context.locale.scanQrCode,
          onPressed: () => context.router.push(const ResultScanningRoute()),
        ),
        _SecondaryButton(
          icon: Icons.text_fields,
          label: context.locale.extractText,
          onPressed: () => context.router.push(const OcrRoute()),
        ),
        _SecondaryButton(
          icon: Icons.history,
          label: context.locale.viewHistory,
          onPressed: () => context.router.push(const HistoryRoute()),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: context.appColors.white),
      label: Text(
        label,
        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
          color: context.appColors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.primaryBlue,
        foregroundColor: context.appColors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(final BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: context.appColors.primaryBlue),
      label: Text(
        label,
        style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
          color: context.appColors.primaryBlue,
        ),
      ),
      style: OutlinedButton.styleFrom(
        foregroundColor: context.appColors.primaryBlue,
        side: BorderSide(color: context.appColors.primaryBlue, width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
    );
  }
}

class _SyncButton extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    return ElevatedButton(
      onPressed: () =>
          context.read<HomeScreenBloc>().add(const OnHomeSyncPendingScans()),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.c3BA935,
        elevation: 0,
      ),
      child: Text(
        context.locale.syncButtonLabel,
        style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
          color: context.appColors.white,
        ),
      ),
    );
  }
}
