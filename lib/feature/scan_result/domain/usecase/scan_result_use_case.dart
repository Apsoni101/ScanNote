import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/repo/scan_result_repository.dart';

class ScanResultUseCase {
  const ScanResultUseCase({required this.repository});

  final ScanResultRepository repository;

  // Local operations
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets() =>
      repository.getLocalSheets();

  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet) =>
      repository.cacheSheet(sheet);

  Future<Either<Failure, Unit>> cacheScanResult(
    final ScanResultEntity scan,
    final String sheetId,
    final String sheetTitle,
  ) => repository.cacheScanResult(scan, sheetId, sheetTitle);

  Future<Either<Failure, List<ScanResultEntity>>> getCachedScans(
    final String sheetId,
  ) => repository.getCachedScans(sheetId);

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans() =>
      repository.getPendingSyncScans();

  Future<Either<Failure, Unit>> removeSyncedScan(final int index) =>
      repository.removeSyncedScan(index);

  Future<Either<Failure, Unit>> clearAllCache() => repository.clearAllCache();

  // Remote operations
  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets() =>
      repository.getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      repository.createSheet(sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  ) => repository.saveScan(entity, sheetId);

  Future<Either<Failure, List<ScanResultEntity>>> getAllScans(
    final String sheetId,
  ) => repository.getAllScans(sheetId);

  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final ScanResultEntity entity,
  ) => repository.updateScan(sheetId, range, entity);

  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  ) => repository.deleteScan(sheetId, range);
}
