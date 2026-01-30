import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/feature/home/presentation/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/banner_container.dart';
import 'package:qr_scanner_practice/feature/home/presentation/widgets/sync_button.dart';

class SyncStatusBanner extends StatelessWidget {
  const SyncStatusBanner({super.key});

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
              return SyncingBanner(pendingCount: data.pendingCount);
            }

            if (!data.isOnline) {
              return OfflineBanner(pendingCount: data.pendingCount);
            }

            return ReadyToSyncBanner(pendingCount: data.pendingCount);
          },
    );
  }
}

class SyncingBanner extends StatelessWidget {
  const SyncingBanner({required this.pendingCount, super.key});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return BannerContainer(
      backgroundColor: context.appColors.iconPrimary.withAlpha(26),
      borderColor: context.appColors.iconPrimary.withAlpha(77),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                context.appColors.iconPrimary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              _getSyncingMessage(context, pendingCount),
              style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                color: context.appColors.iconPrimary,
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

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({required this.pendingCount, super.key});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return BannerContainer(
      backgroundColor: context.appColors.semanticsIconError.withAlpha(26),
      borderColor: context.appColors.semanticsIconError.withAlpha(77),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.cloud_off,
            color: context.appColors.semanticsIconError,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                Text(
                  context.locale.offlineMode,
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.semanticsIconError,
                  ),
                ),
                Text(
                  _getWaitingToSyncMessage(context, pendingCount),
                  style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                    color: context.appColors.textSecondary,
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

class ReadyToSyncBanner extends StatelessWidget {
  const ReadyToSyncBanner({required this.pendingCount, super.key});

  final int pendingCount;

  @override
  Widget build(final BuildContext context) {
    return BannerContainer(
      backgroundColor: context.appColors.semanticsIconSuccess.withAlpha(26),
      borderColor: context.appColors.semanticsIconSuccess.withAlpha(77),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: <Widget>[
                Text(
                  _getScanToSyncMessage(context, pendingCount),
                  style: AppTextStyles.airbnbCerealW500S14Lh20Ls0.copyWith(
                    color: context.appColors.semanticsIconSuccess,
                  ),
                ),
                Text(
                  context.locale.connectionAvailableSync,
                  style: AppTextStyles.airbnbCerealW400S12Lh16.copyWith(
                    color: context.appColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          const SyncButton(),
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
