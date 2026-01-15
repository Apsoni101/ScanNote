import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/history/data/data_source/history_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/history/domain/repo/history_remote_repository.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/pending_sync_entity.dart';

class HistoryRemoteRepositoryImpl implements HistoryRemoteRepository {
  HistoryRemoteRepositoryImpl({required this.remoteDataSource});

  final HistoryRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets() =>
      remoteDataSource.getAllScansFromAllSheets();
}
