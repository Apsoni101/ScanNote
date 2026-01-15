import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/pending_sync_entity.dart';

abstract class HistoryRemoteRepository {
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets();
}
