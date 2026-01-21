import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_local_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_repository.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/sheet_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/sheet_entity.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository {
  const HomeScreenRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final HomeScreenLocalDataSource localDataSource;
  final HomeScreenRemoteDataSource remoteDataSource;

  // Local operations
  @override
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets() =>
      localDataSource.getLocalSheets();

  @override
  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet) =>
      localDataSource.saveSheetLocally(SheetModel.fromEntity(sheet));

  @override
  Future<Either<Failure, Unit>> cacheScanResult(
    final ScanResultEntity scan,
    final String sheetId,
    final String sheetTitle,
  ) => localDataSource.saveScanResultLocally(
    ScanResultModel.fromEntity(scan),
    sheetId,
    sheetTitle,
  );

  @override
  Future<Either<Failure, List<ScanResultEntity>>> getCachedScans(
    final String sheetId,
  ) => localDataSource.getLocalScanResults(sheetId);

  @override
  Future<Either<Failure, List<PendingSyncEntity>>> getPendingSyncScans() async {
    final Either<Failure, List<PendingSyncModel>> result = await localDataSource
        .getPendingSyncs();

    return result.fold(
      Left.new,
      (final List<PendingSyncModel> models) =>
          Right<Failure, List<PendingSyncEntity>>(
            models
                .map((final PendingSyncModel model) => model.toEntity())
                .toList(),
          ),
    );
  }

  @override
  Future<Either<Failure, Unit>> removeSyncedScan(final int index) =>
      localDataSource.removePendingSync(index);

  // Remote operations
  @override
  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets() =>
      remoteDataSource.getOwnedSheets();

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      remoteDataSource.createSheet(sheetName);

  @override
  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  ) => remoteDataSource.saveScan(ScanResultModel.fromEntity(entity), sheetId);

  @override
  Future<Either<Failure, List<ScanResultEntity>>> getAllScans(
    final String sheetId,
  ) => remoteDataSource.read(sheetId);

  @override
  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final ScanResultEntity entity,
  ) => remoteDataSource.update(
    sheetId,
    range,
    ScanResultModel.fromEntity(entity),
  );

  @override
  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  ) => remoteDataSource.delete(sheetId, range);
}
