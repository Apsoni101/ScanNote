import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner_practice/core/constants/app_textstyles.dart';
import 'package:qr_scanner_practice/core/di/app_injector.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/extensions/context_extensions.dart';
import 'package:qr_scanner_practice/core/utils/toast_utils.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_app_bar.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/common_loading_view.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/elevated_icon_button.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/error_or_empty_message_container.dart';
import 'package:qr_scanner_practice/feature/common/presentation/widgets/sheet_list_view.dart';
import 'package:qr_scanner_practice/feature/export_sheet/presentation/bloc/export_sheet_bloc.dart';
import 'package:qr_scanner_practice/feature/export_sheet/presentation/widget/export_format_tile_card.dart';
import 'package:qr_scanner_practice/feature/export_sheet/presentation/widget/export_sheet_bottom_nav_bar.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';

@RoutePage()
class ExportSheetScreen extends StatelessWidget {
  const ExportSheetScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    return BlocProvider<ExportSheetBloc>(
      create: (final BuildContext context) =>
          AppInjector.getIt<ExportSheetBloc>()..add(const LoadSheetsEvent()),
      child: BlocListener<ExportSheetBloc, ExportSheetState>(
        listener: (final BuildContext context, final ExportSheetState state) {
          if (state is ExportSheetLoaded) {
            if (state.downloadedFilePath != null) {
              ToastUtils.showToast(
                context,
                context.locale.fileDownloadedSuccessfully,
                isSuccess: true,
              );
              context.read<ExportSheetBloc>().add(
                const ClearDownloadStateEvent(),
              );
            }

            if (state.downloadError != null) {
              ToastUtils.showToast(
                context,
                '${context.locale.downloadFailed}: ${state.downloadError}',
                isSuccess: false,
              );
              context.read<ExportSheetBloc>().add(
                const ClearDownloadStateEvent(),
              );
            }
          }
        },
        child: Scaffold(
          appBar: CommonAppBar(
            title: context.locale.exportData,
            showBottomDivider: true,
          ),
          backgroundColor: context.appColors.scaffoldBackground,
          bottomNavigationBar:
              ///this are the buttons in bottom nav share and download
              BlocSelector<
                ExportSheetBloc,
                ExportSheetState,
                ({bool isEnabled, bool isDownloading})
              >(
                selector: (final ExportSheetState state) {
                  if (state is ExportSheetLoaded) {
                    return (
                      isEnabled: state.selectedSheetId != null,
                      isDownloading: state.isDownloading,
                    );
                  }

                  if (state is ExportSheetLoading) {
                    return (isEnabled: false, isDownloading: false);
                  }

                  return (isEnabled: false, isDownloading: false);
                },
                builder:
                    (
                      final BuildContext context,
                      final ({bool isEnabled, bool isDownloading}) stateData,
                    ) {
                      return ExportSheetBottomNavBar(
                        isEnabled: stateData.isEnabled,
                        isDownloading: stateData.isDownloading,
                      );
                    },
              ),
          body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            children: <Widget>[
              /// select google sheet list
              Text(
                context.locale.selectGoogleSheet,
                style: AppTextStyles.airbnbCerealW500S14Lh20Ls0,
              ),
              const SizedBox(height: 12),

              BlocSelector<
                ExportSheetBloc,
                ExportSheetState,
                ({
                  bool isLoading,
                  bool isLoadingMore,
                  String? error,
                  List<SheetEntity> sheets,
                  String? selectedSheetId,
                  bool hasMore,
                })
              >(
                selector: (final ExportSheetState state) {
                  if (state is ExportSheetLoading) {
                    return (
                      isLoading: true,
                      isLoadingMore: false,
                      error: null,
                      sheets: <SheetEntity>[],
                      selectedSheetId: null,
                      hasMore: false,
                    );
                  } else if (state is ExportSheetLoaded) {
                    return (
                      isLoading: false,
                      isLoadingMore: state.isLoadingMore,
                      error: null,
                      sheets: state.pagedSheets.sheets,
                      selectedSheetId: state.selectedSheetId,
                      hasMore: state.pagedSheets.hasMore,
                    );
                  } else if (state is ExportSheetError) {
                    return (
                      isLoading: false,
                      isLoadingMore: false,
                      error: state.message,
                      sheets: <SheetEntity>[],
                      selectedSheetId: null,
                      hasMore: false,
                    );
                  }
                  return (
                    isLoading: false,
                    isLoadingMore: false,
                    error: null,
                    sheets: <SheetEntity>[],
                    selectedSheetId: null,
                    hasMore: false,
                  );
                },
                builder:
                    (
                      final BuildContext context,
                      final ({
                        bool isLoading,
                        bool isLoadingMore,
                        String? error,
                        List<SheetEntity> sheets,
                        String? selectedSheetId,
                        bool hasMore,
                      })
                      sheetData,
                    ) {
                      if (sheetData.isLoading) {
                        return const CommonLoadingView();
                      } else if (sheetData.error != null) {
                        return ErrorOrEmptyMessageContainer(
                          message: sheetData.error ?? '',
                          backgroundColor: context.appColors.semanticsIconError
                              .withValues(alpha: 0.1),
                          textColor: context.appColors.semanticsIconError,
                        );
                      } else if (sheetData.sheets.isEmpty) {
                        return ErrorOrEmptyMessageContainer(
                          message: context.locale.noSheetsAvailable,
                          backgroundColor: context.appColors.borderInputDefault,
                          textColor: context.appColors.textSecondary,
                        );
                      }

                      return Column(
                        children: <Widget>[
                          SheetListView(
                            availableSheets: sheetData.sheets,
                            selectedSheetId: sheetData.selectedSheetId,
                            onSheetSelected: (final String sheetId) {
                              final SheetEntity? selectedSheet = sheetData
                                  .sheets
                                  .where(
                                    (final SheetEntity sheet) =>
                                        sheet.id == sheetId,
                                  )
                                  .firstOrNull;

                              context.read<ExportSheetBloc>().add(
                                SelectSheetEvent(
                                  sheetId: sheetId,
                                  sheetName: selectedSheet?.title ?? '',
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 16),

                          if (sheetData.hasMore)
                            sheetData.isLoadingMore
                                ? const CommonLoadingView()
                                : ElevatedIconButton(
                                    icon: Icons.expand_circle_down_outlined,
                                    label: context.locale.loadMore,
                                    backgroundColor:
                                        context.appColors.primaryDefault,
                                    iconColor: context.appColors.surfaceL1,
                                    labelColor:
                                        context.appColors.textInversePrimary,
                                    onPressed: () {
                                      context.read<ExportSheetBloc>().add(
                                        const LoadMoreSheetsEvent(),
                                      );
                                    },
                                  ),
                        ],
                      );
                    },
              ),
              const SizedBox(height: 24),

              /// choose export format list
              Text(
                context.locale.chooseExportFormat,
                style: AppTextStyles.airbnbCerealW500S14Lh20Ls0,
              ),
              const SizedBox(height: 12),
              BlocSelector<ExportSheetBloc, ExportSheetState, ExportFormat>(
                selector: (final ExportSheetState state) {
                  if (state is ExportSheetInitial) {
                    return state.selectedFormat;
                  }
                  if (state is ExportSheetLoaded) {
                    return state.selectedFormat;
                  }
                  if (state is ExportSheetLoading) {
                    return state.selectedFormat;
                  }
                  if (state is ExportSheetError) {
                    return state.selectedFormat;
                  }
                  return ExportFormat.pdf;
                },
                builder:
                    (
                      final BuildContext context,
                      final ExportFormat selectedFormat,
                    ) {
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ExportFormat.values.length,
                        separatorBuilder: (final _, final __) =>
                            const SizedBox(height: 12),
                        itemBuilder:
                            (final BuildContext context, final int index) {
                              final ExportFormat exportFormat =
                                  ExportFormat.values[index];
                              return ExportFormatTileCard(
                                icon: exportFormat.icon,
                                iconBackgroundColor: exportFormat
                                    .backgroundColor(context),
                                selectedTextColor: exportFormat.textColor(
                                  context,
                                ),
                                isSelected: selectedFormat == exportFormat,
                                onTap: () {
                                  context.read<ExportSheetBloc>().add(
                                    SelectExportFormatEvent(
                                      format: exportFormat,
                                    ),
                                  );
                                },
                                subtitle: exportFormat.subtitle(context),
                                title: exportFormat.title(context),
                              );
                            },
                      );
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
