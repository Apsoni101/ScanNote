import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

abstract class HomeScreenRepository {
  /// Local operations or methods

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans();

  Future<Either<Failure, Unit>> removeSyncedScan(final int index);

  /// Remote operations or methods

  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  );
  Future<Either<Failure, String>> createSheet(final String sheetName);
}
