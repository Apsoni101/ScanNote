import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/data/data_source/view_scans_history_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/repo/view_scans_history_remote_repository.dart';

class ViewScansHistoryRemoteRepositoryImpl
    implements ViewScansHistoryRemoteRepository {
  ViewScansHistoryRemoteRepositoryImpl({required this.remoteDataSource});

  final ViewScansHistoryRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, PagedSheetsEntity>> getAllSheets({
    final String? pageToken,
    final int? pageSize,
  }) => remoteDataSource.getAllSheets(pageToken: pageToken, pageSize: pageSize);

  @override
  Future<Either<Failure, List<ScanResultEntity>>> getScansFromSheet(
    final String sheetId,
  ) => remoteDataSource.getScansFromSheet(sheetId);
}
