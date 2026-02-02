import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_local_data_source.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_repository.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';

class HomeScreenRepositoryImpl implements HomeScreenRepository {
  const HomeScreenRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final HomeScreenLocalDataSource localDataSource;
  final HomeScreenRemoteDataSource remoteDataSource;

  // Local operations

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
  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  ) => remoteDataSource.saveScan(.fromEntity(entity), sheetId);

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      remoteDataSource.createSheet(sheetName);
}
