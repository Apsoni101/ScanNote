// export_sheet_state.dart
part of 'export_sheet_bloc.dart';

@immutable
sealed class ExportSheetState extends Equatable {
  const ExportSheetState();

  @override
  List<Object?> get props => <Object?>[];
}

final class ExportSheetInitial extends ExportSheetState {
  const ExportSheetInitial({this.selectedFormat = ExportFormat.pdf});

  final ExportFormat selectedFormat;

  @override
  List<Object?> get props => <Object?>[selectedFormat];
}

final class ExportSheetLoading extends ExportSheetState {
  const ExportSheetLoading({this.selectedFormat = ExportFormat.pdf});

  final ExportFormat selectedFormat;

  @override
  List<Object?> get props => <Object?>[selectedFormat];
}

final class ExportSheetLoaded extends ExportSheetState {
  const ExportSheetLoaded({
    required this.pagedSheets,
    this.selectedFormat = ExportFormat.pdf,
    this.selectedSheetId,
    this.selectedSheetName,
    this.isLoadingMore = false,
    this.isDownloading = false,
    this.isSharing = false,
    this.downloadedFilePath,
    this.downloadError,
    this.sharedFilePath,
    this.shareError,
  });

  final PagedSheetsEntity pagedSheets;
  final ExportFormat selectedFormat;
  final String? selectedSheetId;
  final String? selectedSheetName;
  final bool isLoadingMore;
  final bool isDownloading;
  final bool isSharing;
  final String? downloadedFilePath;
  final String? downloadError;
  final String? sharedFilePath;
  final String? shareError;

  ExportSheetLoaded copyWith({
    final PagedSheetsEntity? pagedSheets,
    final ExportFormat? selectedFormat,
    final String? selectedSheetId,
    final String? selectedSheetName,
    final bool? isLoadingMore,
    final bool? isDownloading,
    final bool? isSharing,
    final String? downloadedFilePath,
    final String? downloadError,
    final String? sharedFilePath,
    final String? shareError,
  }) {
    return ExportSheetLoaded(
      pagedSheets: pagedSheets ?? this.pagedSheets,
      selectedFormat: selectedFormat ?? this.selectedFormat,
      selectedSheetId: selectedSheetId ?? this.selectedSheetId,
      selectedSheetName: selectedSheetName ?? this.selectedSheetName,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isDownloading: isDownloading ?? this.isDownloading,
      isSharing: isSharing ?? this.isSharing,
      downloadedFilePath: downloadedFilePath,
      downloadError: downloadError,
      sharedFilePath: sharedFilePath,
      shareError: shareError,
    );
  }

  @override
  List<Object?> get props => <Object?>[
    pagedSheets,
    selectedFormat,
    selectedSheetId,
    selectedSheetName,
    isLoadingMore,
    isDownloading,
    isSharing,
    downloadedFilePath,
    downloadError,
    sharedFilePath,
    shareError,
  ];
}

final class ExportSheetError extends ExportSheetState {
  const ExportSheetError({
    required this.message,
    this.selectedFormat = ExportFormat.pdf,
  });

  final String message;
  final ExportFormat selectedFormat;

  @override
  List<Object?> get props => <Object?>[message, selectedFormat];
}
