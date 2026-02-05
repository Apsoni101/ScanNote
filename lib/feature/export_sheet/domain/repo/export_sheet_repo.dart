import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/enums/export_format_enum.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';

abstract class ExportSheetRepo {
  Future<Either<Failure, PagedSheetsEntity>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  });

  Future<Either<Failure, String>> downloadSheetFile({
    required final String fileId,
    required final ExportFormat format,
    required final String sheetName,
  });

  void dispose();
}
