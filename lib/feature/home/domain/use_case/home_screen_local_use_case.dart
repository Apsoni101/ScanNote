import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_local_repository.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/repo/result_scan_local_repository.dart';

class HomeScreenLocalUseCase {
  const HomeScreenLocalUseCase({required this.repository});

  final HomeScreenLocalRepository repository;

  Future<Either<Failure, List<SheetEntity>>> getLocalSheets() =>
      repository.getLocalSheets();

  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet) =>
      repository.cacheSheet(sheet);

  Future<Either<Failure, Unit>> cacheResultScan(
    final ResultScanEntity scan,
    final String sheetId,
    final String sheetTitle,
  ) => repository.cacheResultScan(scan, sheetId, sheetTitle);

  Future<Either<Failure, List<ResultScanEntity>>> getCachedScans(
    final String sheetId,
  ) => repository.getCachedScans(sheetId);

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans() =>
      repository.getPendingSyncScans();

  Future<Either<Failure, Unit>> removeSyncedScan(final int index) =>
      repository.removeSyncedScan(index);

  Future<Either<Failure, Unit>> clearAllCache() => repository.clearAllCache();
}
