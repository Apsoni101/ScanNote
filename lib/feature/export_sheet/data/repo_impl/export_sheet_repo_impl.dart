import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/export_sheet/data/data_source/export_sheet_data_source.dart';
import 'package:qr_scanner_practice/feature/export_sheet/domain/repo/export_sheet_repo.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';

class ExportSheetRepoImpl extends ExportSheetRepo {
  ExportSheetRepoImpl({required this.exportSheetDataSource});

  final ExportSheetDataSource exportSheetDataSource;

  @override
  Future<Either<Failure, PagedSheetsEntity>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  }) => exportSheetDataSource.getOwnedSheets(
    pageToken: pageToken,
    pageSize: pageSize,
  );

  @override
  Future<Either<Failure, String>> downloadSheetFile({
    required final String fileId,
    required final String sheetName,
    required final ExportFormat format,
  }) => exportSheetDataSource.downloadSheetFile(
    fileId: fileId,
    sheetName: sheetName,
    format: format,
  );

  @override
  void dispose() {
    exportSheetDataSource.dispose();
  }
}
