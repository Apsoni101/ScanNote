import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

abstract class ViewScansHistoryRemoteRepository {
  Future<Either<Failure, PagedSheetsEntity>> getAllSheets({
    final String? pageToken,
    final int? pageSize,
  });

  Future<Either<Failure, List<ScanResultEntity>>> getScansFromSheet(
    final String sheetId,
  );
}
