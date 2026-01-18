import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/history/domain/repo/history_remote_repository.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/pending_sync_entity.dart';

class GetHistoryScansUseCase {
  const GetHistoryScansUseCase({required this.repository});

  final HistoryRemoteRepository repository;

  Future<Either<Failure, List<PendingSyncEntity>>> call() =>
      repository.getAllScansFromAllSheets();
}
