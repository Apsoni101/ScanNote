import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/view_scan_history/domain/repo/view_scans_history_remote_repository.dart';

class ViewScansHistoryRemoteUseCase {
  const ViewScansHistoryRemoteUseCase({required this.repository});

  final ViewScansHistoryRemoteRepository repository;

  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets() =>
      repository.getAllScansFromAllSheets();
}
