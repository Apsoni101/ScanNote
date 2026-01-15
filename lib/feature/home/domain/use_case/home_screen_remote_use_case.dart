import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_remote_repository.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/qr_scan_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/repo/qr_scan_remote_repository.dart';

class HomeScreenRemoteUseCase {
  const HomeScreenRemoteUseCase({required this.repository});

  final HomeScreenRemoteRepository repository;

  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets() =>
      repository.getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      repository.createSheet(sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final QrScanEntity entity,
    final String sheetId,
  ) => repository.saveScan(entity, sheetId);

  Future<Either<Failure, List<QrScanEntity>>> getAllScans(
    final String sheetId,
  ) => repository.getAllScans(sheetId);

  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final QrScanEntity entity,
  ) => repository.updateScan(sheetId, range, entity);

  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  ) => repository.deleteScan(sheetId, range);
}
