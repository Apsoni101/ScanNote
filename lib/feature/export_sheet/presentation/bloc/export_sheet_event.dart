part of 'export_sheet_bloc.dart';

@immutable
sealed class ExportSheetEvent extends Equatable {
  const ExportSheetEvent();

  @override
  List<Object?> get props => <Object?>[];
}

final class SelectExportFormatEvent extends ExportSheetEvent {
  const SelectExportFormatEvent({required this.format});

  final ExportFormat format;

  @override
  List<Object?> get props => <Object?>[format];
}

final class LoadSheetsEvent extends ExportSheetEvent {
  const LoadSheetsEvent({this.pageToken, this.pageSize});

  final String? pageToken;
  final int? pageSize;

  @override
  List<Object?> get props => <Object?>[pageToken, pageSize];
}

final class SelectSheetEvent extends ExportSheetEvent {
  const SelectSheetEvent({required this.sheetId, required this.sheetName});

  final String sheetId;
  final String sheetName;

  @override
  List<Object?> get props => <Object?>[sheetId, sheetName];
}

final class LoadMoreSheetsEvent extends ExportSheetEvent {
  const LoadMoreSheetsEvent();
}

final class DownloadSheetEvent extends ExportSheetEvent {
  const DownloadSheetEvent();
}

class ClearDownloadStateEvent extends ExportSheetEvent {
  const ClearDownloadStateEvent();
}
