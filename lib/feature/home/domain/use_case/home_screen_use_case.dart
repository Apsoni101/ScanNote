import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_repository.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

class HomeScreenUseCase {
  const HomeScreenUseCase({required this.repository});

  final HomeScreenRepository repository;

  /// Local operations

  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans() =>
      repository.getPendingSyncScans();

  Future<Either<Failure, Unit>> removeSyncedScan(final int index) =>
      repository.removeSyncedScan(index);

  /// Remote operations

  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  ) => repository.saveScan(entity, sheetId);

  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      repository.createSheet(sheetName);
}
