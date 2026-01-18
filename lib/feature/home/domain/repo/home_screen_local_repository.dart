import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';

abstract class HomeScreenLocalRepository {
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets();

  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet);

  Future<Either<Failure, Unit>> cacheResultScan(
    final ResultScanEntity scan,
    final String sheetId,
    final String sheetTitle,
  );

  Future<Either<Failure, List<ResultScanEntity>>> getCachedScans(
    final String sheetId,
  );

  Future<Either<Failure, Unit>> removeSyncedScan(final int index);

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans();

  Future<Either<Failure, Unit>> clearAllCache();
}
