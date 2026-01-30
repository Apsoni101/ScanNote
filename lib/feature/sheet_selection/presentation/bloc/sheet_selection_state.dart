part of 'sheet_selection_bloc.dart';

class SheetSelectionState extends Equatable {
  const SheetSelectionState({
    this.isLoadingSheets = false,
    this.isCreatingSheet = false,
    this.isSavingScan = false,
    this.isCreatingNewSheet = false,
    this.newSheetName = '',
    this.selectedSheetId,
    this.selectedSheetTitle,
    this.sheets = const <SheetEntity>[],
    this.sheetsLoadError,
    this.sheetCreationError,
    this.scanSaveError,
    this.isScanSaved = false,
    this.isCachedData = false,
    this.isLoadingMoreSheets = false,
    this.hasMoreSheets = true,
    this.nextPageToken,
  });

  final bool isLoadingSheets;
  final bool isCreatingSheet;
  final bool isSavingScan;
  final bool isCreatingNewSheet;
  final String newSheetName;
  final String? selectedSheetId;
  final String? selectedSheetTitle;
  final List<SheetEntity> sheets;
  final String? sheetsLoadError;
  final String? sheetCreationError;
  final String? scanSaveError;
  final bool isScanSaved;
  final bool isCachedData;
  final bool isLoadingMoreSheets;
  final bool hasMoreSheets;
  final String? nextPageToken;

  SheetSelectionState copyWith({
    final bool? isLoadingSheets,
    final bool? isCreatingSheet,
    final bool? isSavingScan,
    final bool? isCreatingNewSheet,
    final String? newSheetName,
    final String? selectedSheetId,
    final String? selectedSheetTitle,
    final List<SheetEntity>? sheets,
    final String? sheetsLoadError,
    final String? sheetCreationError,
    final String? scanSaveError,
    final bool? isScanSaved,
    final bool? isCachedData,
    final bool? isLoadingMoreSheets,
    final bool? hasMoreSheets,
    final String? nextPageToken,
  }) {
    return SheetSelectionState(
      isLoadingSheets: isLoadingSheets ?? this.isLoadingSheets,
      isCreatingSheet: isCreatingSheet ?? this.isCreatingSheet,
      isSavingScan: isSavingScan ?? this.isSavingScan,
      isCreatingNewSheet: isCreatingNewSheet ?? this.isCreatingNewSheet,
      newSheetName: newSheetName ?? this.newSheetName,
      selectedSheetId: selectedSheetId ?? this.selectedSheetId,
      selectedSheetTitle: selectedSheetTitle ?? this.selectedSheetTitle,
      sheets: sheets ?? this.sheets,
      sheetsLoadError: sheetsLoadError ?? this.sheetsLoadError,
      sheetCreationError: sheetCreationError ?? this.sheetCreationError,
      scanSaveError: scanSaveError ?? this.scanSaveError,
      isScanSaved: isScanSaved ?? this.isScanSaved,
      isCachedData: isCachedData ?? this.isCachedData,
      isLoadingMoreSheets: isLoadingMoreSheets ?? this.isLoadingMoreSheets,
      hasMoreSheets: hasMoreSheets ?? this.hasMoreSheets,
      nextPageToken: nextPageToken ?? this.nextPageToken,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    isLoadingSheets,
    isCreatingSheet,
    isSavingScan,
    isCreatingNewSheet,
    newSheetName,
    selectedSheetId,
    selectedSheetTitle,
    sheets,
    sheetsLoadError,
    sheetCreationError,
    scanSaveError,
    isScanSaved,
    isCachedData,
    isLoadingMoreSheets,
    hasMoreSheets,
    nextPageToken,
  ];
}

class ResultSavingInitial extends SheetSelectionState {
  const ResultSavingInitial();
}
