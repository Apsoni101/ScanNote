import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';

import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/bloc/view_scans_history_screen_bloc.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/widget/history_card_item.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/widget/history_empty_view.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/widget/history_error_view.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/presentation/widget/history_search_bar.dart';

@RoutePage()
class ViewScansHistoryScreen extends StatelessWidget {
  const ViewScansHistoryScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ViewScansHistoryScreenBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<ViewScansHistoryScreenBloc>()
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
      backgroundColor: context.appColors.scaffoldBackground,
      appBar: _buildAppBar(context),
      body: Column(
        children: <Widget>[
          HistorySearchBar(
            onSearchChanged: (final String query) {
              context.read<ViewScansHistoryScreenBloc>().add(
                OnHistorySearchScans(query),
              );
            },
          ),
          Expanded(
            child:
                BlocBuilder<
                  ViewScansHistoryScreenBloc,
                  ViewScansHistoryScreenState
                >(
                  builder:
                      (
                        final BuildContext context,
                        final ViewScansHistoryScreenState state,
                      ) {
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
                            context.read<ViewScansHistoryScreenBloc>().add(
                              const OnHistoryLoadScans(),
                            );
                          },
                          color: context.appColors.iconPrimary,
                          backgroundColor: context.appColors.textInversePrimary,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: state.filteredScans.length,
                            itemBuilder:
                                (final BuildContext context, final int index) {
                                  final PendingSyncEntity historyScan =
                                      state.filteredScans[index];
                                  return HistoryCardItem(
                                    data: historyScan.scan.data,
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
      backgroundColor: context.appColors.textInversePrimary,
      elevation: 0,
      title: Text(
        context.locale.scanHistory,
        style: AppTextStyles.airbnbCerealW500S18Lh24Ls0.copyWith(
          color: context.appColors.textPrimary,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.appColors.textPrimary),
        onPressed: () => context.router.maybePop(),
      ),
    );
  }
}
