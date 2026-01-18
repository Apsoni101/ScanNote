part of 'result_confirmation_bloc.dart';

class ResultConfirmationState extends Equatable {
  // Indicates if data is from local cache

  const ResultConfirmationState({
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

  ResultConfirmationState copyWith({
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
  }) {
    return ResultConfirmationState(
      isLoadingSheets: isLoadingSheets ?? this.isLoadingSheets,
      isCreatingSheet: isCreatingSheet ?? this.isCreatingSheet,
      isSavingScan: isSavingScan ?? this.isSavingScan,
      isCreatingNewSheet: isCreatingNewSheet ?? this.isCreatingNewSheet,
      newSheetName: newSheetName ?? this.newSheetName,
      selectedSheetId: selectedSheetId ?? this.selectedSheetId,
      selectedSheetTitle: selectedSheetTitle ?? this.selectedSheetTitle,
      sheets: sheets ?? this.sheets,
      sheetsLoadError: sheetsLoadError,
      sheetCreationError: sheetCreationError,
      scanSaveError: scanSaveError,
      isScanSaved: isScanSaved ?? this.isScanSaved,
      isCachedData: isCachedData ?? this.isCachedData,
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
  ];
}

class ResultConfirmationInitial extends ResultConfirmationState {
  const ResultConfirmationInitial();
}
