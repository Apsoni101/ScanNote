import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/data_source/result_scan_local_data_source.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/result_scan_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/sheet_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/repo/result_scan_local_repository.dart';

class ResultScanLocalRepositoryImpl implements ResultScanLocalRepository {
  const ResultScanLocalRepositoryImpl({required this.localDataSource});

  final ResultScanLocalDataSource localDataSource;

  @override
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets() =>
      localDataSource.getLocalSheets();

  @override
  Future<Either<Failure, Unit>> cacheSheet(final SheetEntity sheet) =>
      localDataSource.saveSheetLocally(SheetModel.fromEntity(sheet));

  @override
  Future<Either<Failure, Unit>> cacheResultScan(
    final ResultScanEntity scan,
    final String sheetId,
    final String sheetTitle,
  ) => localDataSource.saveResultScanLocally(
    ResultScanModel.fromEntity(scan),
    sheetId,
    sheetTitle,
  );

  @override
  Future<Either<Failure, List<ResultScanEntity>>> getCachedScans(
    final String sheetId,
  ) => localDataSource.getLocalResultScans(sheetId);

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

  @override
  Future<Either<Failure, Unit>> clearAllCache() =>
      localDataSource.clearLocalData();
}
