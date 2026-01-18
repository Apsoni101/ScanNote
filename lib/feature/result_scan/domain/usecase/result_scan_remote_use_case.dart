import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/repo/result_scan_remote_repository.dart';

class ResultScanRemoteUseCase {
  const ResultScanRemoteUseCase({required this.repository});

  final ResultScanRemoteRepository repository;

  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets() =>
      repository.getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      repository.createSheet(sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final ResultScanEntity entity,
    final String sheetId,
  ) => repository.saveScan(entity, sheetId);

  Future<Either<Failure, List<ResultScanEntity>>> getAllScans(
    final String sheetId,
  ) => repository.getAllScans(sheetId);

  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final ResultScanEntity entity,
  ) => repository.updateScan(sheetId, range, entity);

  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  ) => repository.deleteScan(sheetId, range);
}
