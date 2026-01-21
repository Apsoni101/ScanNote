import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';

abstract class ViewScansHistoryRemoteRepository {
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets();
}
