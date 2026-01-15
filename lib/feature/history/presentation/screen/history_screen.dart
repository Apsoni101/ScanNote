import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/color_extension.dart';
import 'package:qr_scanner_practice/core/extensions/localization_extension.dart';
import 'package:qr_scanner_practice/feature/history/presentation/bloc/history_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/history/presentation/widget/history_components.dart';

@RoutePage()
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<HistoryScreenBloc>(
      create: (final BuildContext context) =>
      AppInjector.getIt<HistoryScreenBloc>()
        ..add(const OnHistoryLoadScans()),
      child: const _HistoryScreenView(),
    );
  }
}

class _HistoryScreenView extends StatelessWidget {
  const _HistoryScreenView();

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: context.appColors.cF6F9FF,
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          HistorySearchBar(
            onSearchChanged: (final String query) {
              context.read<HistoryScreenBloc>().add(
                OnHistorySearchScans(query),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<HistoryScreenBloc, HistoryScreenState>(
              builder: (final BuildContext context, final HistoryScreenState state) {
                if (state.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state.error != null && state.error!.isNotEmpty) {
                  return HistoryErrorState(errorMessage: state.error!);
                }

                if (state.filteredScans.isEmpty) {
                  return HistoryEmptyState(
                    isSearchActive: state.searchQuery.isNotEmpty,
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<HistoryScreenBloc>().add(
                      const OnHistoryRefreshScans(),
                    );
                  },
                  color: context.appColors.primaryBlue,
                  backgroundColor: context.appColors.white,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.filteredScans.length,
                    itemBuilder: (final BuildContext context, final int index) {
                      final historyScan = state.filteredScans[index];
                      return HistoryScanCard(
                        qrData: historyScan.scan.qrData,
                        sheetTitle: historyScan.sheetTitle,
                        timestamp: historyScan.scan.timestamp,
                        comment: historyScan.scan.comment,
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(final BuildContext context) {
    return AppBar(
      backgroundColor: context.appColors.white,
      elevation: 0,
      title: Text(
        context.locale.scanHistory,
        style: AppTextStyles.airbnbCerealW500S18Lh24Ls0.copyWith(
          color: context.appColors.black,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.appColors.black),
        onPressed: () => context.router.maybePop(),
      ),
    );
  }
}