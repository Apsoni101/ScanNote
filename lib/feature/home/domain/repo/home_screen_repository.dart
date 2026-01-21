import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/sheet_entity.dart';

abstract class HomeScreenRepository {
  /// Local operations or methods
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets();

  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet);

  Future<Either<Failure, Unit>> cacheScanResult(
    final ScanResultEntity scan,
    final String sheetId,
    final String sheetTitle,
  );

  Future<Either<Failure, List<ScanResultEntity>>> getCachedScans(
    final String sheetId,
  );

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans();

  Future<Either<Failure, Unit>> removeSyncedScan(final int index);

  /// Remote operations or methods
  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  );

  Future<Either<Failure, List<ScanResultEntity>>> getAllScans(
    final String sheetId,
  );

  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final ScanResultEntity entity,
  );

  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  );
}
