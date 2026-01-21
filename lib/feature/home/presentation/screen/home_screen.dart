import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/action_buttons_section.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/qr_icon_section.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/qr_title_section.dart';
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
        backgroundColor: context.appColors.ghostWhite,
        appBar: _buildAppBar(context),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<HomeScreenBloc>().add(const OnHomeRefreshSheets());
          },
          color: context.appColors.primaryBlue,
          backgroundColor: context.appColors.white,
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: const <Widget>[
              SyncStatusBanner(),
              SizedBox(height: 32),
              QrIconSection(),
              SizedBox(height: 32),
              QrTitleSection(),
              SizedBox(height: 48),
              ActionButtonsSection(),
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
        context.appColors.kellyGreen,
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
      actions: <Widget>[
        BlocSelector<
          HomeScreenBloc,
          HomeScreenState,
          ({int pendingCount, bool isSyncing})
        >(
          selector: (final HomeScreenState state) => (
            pendingCount: state.pendingSyncCount,
            isSyncing: state.isSyncing,
          ),
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
                              style: AppTextStyles.airbnbCerealW400S12Lh16
                                  .copyWith(color: context.appColors.red),
                            ),
                          ),
                  ),
                );
              },
        ),
      ],
    );
  }
}
