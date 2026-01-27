import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/repo/view_scans_history_remote_repository.dart';

class ViewScansHistoryRemoteUseCase {
  const ViewScansHistoryRemoteUseCase({required this.repository});

  final ViewScansHistoryRemoteRepository repository;

  Future<Either<Failure, PagedSheetsEntity>> getAllSheets({
    final String? pageToken,
    final int? pageSize,
  }) => repository.getAllSheets(pageSize: pageSize, pageToken: pageToken);

  Future<Either<Failure, List<ScanResultEntity>>> getScansFromSheet(
    final String sheetId,
  ) => repository.getScansFromSheet(sheetId);
}
