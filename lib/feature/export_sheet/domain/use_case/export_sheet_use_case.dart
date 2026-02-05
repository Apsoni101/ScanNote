import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/export_sheet/domain/repo/export_sheet_repo.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';

class ExportSheetUseCase {
  ExportSheetUseCase({required this.exportSheetRepo});

  final ExportSheetRepo exportSheetRepo;

  Future<Either<Failure, PagedSheetsEntity>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  }) =>
      exportSheetRepo.getOwnedSheets(pageSize: pageSize, pageToken: pageToken);

  Future<Either<Failure, String>> downloadSheetFile({
    required final String fileId,
    required final String sheetName,
    required final ExportFormat format,
  }) => exportSheetRepo.downloadSheetFile(
    fileId: fileId,
    sheetName: sheetName,
    format: format,
  );

  void dispose() => exportSheetRepo.dispose();
}
