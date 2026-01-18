import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';

abstract class HomeScreenRemoteRepository {
  /// Returns all spreadsheets (owned / accessible by the user)
  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets();

  /// Save a QR scan into a specific sheet (tab)
  Future<Either<Failure, Unit>> saveScan(
      final ResultScanEntity entity,
      final String sheetId,
      );

  /// Read all scans from a sheet (tab)
  Future<Either<Failure, List<ResultScanEntity>>> getAllScans(
      final String sheetId,
      );

  Future<Either<Failure, String>> createSheet(final String sheetName);
  /// Update a specific scan row
  Future<Either<Failure, Unit>> updateScan(
      final String sheetId,
      final String range,
      final ResultScanEntity entity,
      );

  /// Delete a scan row
  Future<Either<Failure, Unit>> deleteScan(
      final String sheetId,
      final String range,
      );
}
