import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_key_constants.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/sheet_model.dart';

abstract class HomeScreenLocalDataSource {
  Future<Either<Failure, List<SheetModel>>> getLocalSheets();

  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet);

  Future<Either<Failure, Unit>> saveScanResultLocally(
    final ScanResultModel scan,
    final String sheetId,
    final String sheetTitle,
  );

  Future<Either<Failure, List<ScanResultModel>>> getLocalScanResults(
    final String sheetId,
  );

  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs();

  Future<Either<Failure, Unit>> removePendingSync(final int index);

  Future<Either<Failure, Unit>> clearLocalData();
}

class HomeScreenLocalDataSourceImpl implements HomeScreenLocalDataSource {
  HomeScreenLocalDataSourceImpl({required this.hiveService});

  final HiveService hiveService;

  @override
  Future<Either<Failure, List<SheetModel>>> getLocalSheets() async {
    try {
      final List<SheetModel>? sheets = hiveService.getObjectList<SheetModel>(
        HiveKeyConstants.sheets,
      );
      return Right<Failure, List<SheetModel>>(sheets ?? <SheetModel>[]);
    } catch (e) {
      return Left<Failure, List<SheetModel>>(
        Failure(message: 'Failed to fetch local sheets: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet) async {
    try {
      final List<SheetModel>? existingSheets = hiveService
          .getObjectList<SheetModel>(HiveKeyConstants.sheets);
      final List<SheetModel> sheets = existingSheets ?? <SheetModel>[];

      final int existingIndex = sheets.indexWhere(
        (final SheetModel s) => s.id == sheet.id,
      );

      if (existingIndex != -1) {
        sheets[existingIndex] = sheet;
      } else {
        sheets.add(sheet);
      }

      await hiveService.setObjectList(HiveKeyConstants.sheets, sheets);
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
        Failure(message: 'Failed to save sheet locally: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveScanResultLocally(
    final ScanResultModel scan,
    final String sheetId,
    final String sheetTitle,
  ) async {
    try {
      final String scanKey = '${HiveKeyConstants.scansKeyPrefix}_$sheetId';

      final List<ScanResultModel>? existingScans = hiveService
          .getObjectList<ScanResultModel>(scanKey);
      final List<ScanResultModel> scans = existingScans ?? <ScanResultModel>[]
        ..add(scan);
      await hiveService.setObjectList(scanKey, scans);

      // Add to pending syncs with sheetId and sheetTitle
      await _addPendingSync(sheetId, sheetTitle, scan);

      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
        Failure(message: 'Failed to save QR scan locally: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ScanResultModel>>> getLocalScanResults(
    final String sheetId,
  ) async {
    try {
      final String scanKey = '${HiveKeyConstants.scansKeyPrefix}_$sheetId';
      final List<ScanResultModel>? scans = hiveService
          .getObjectList<ScanResultModel>(scanKey);
      return Right<Failure, List<ScanResultModel>>(
        scans ?? <ScanResultModel>[],
      );
    } catch (e) {
      return Left<Failure, List<ScanResultModel>>(
        Failure(message: 'Failed to fetch local scans: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs() async {
    try {
      final List<PendingSyncModel>? pendingSyncs = hiveService
          .getObjectList<PendingSyncModel>(HiveKeyConstants.pendingSyncs);
      return Right<Failure, List<PendingSyncModel>>(
        pendingSyncs ?? <PendingSyncModel>[],
      );
    } catch (e) {
      return Left<Failure, List<PendingSyncModel>>(
        Failure(message: 'Failed to fetch pending syncs: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> removePendingSync(final int index) async {
    try {
      final List<PendingSyncModel>? pendingSyncs = hiveService
          .getObjectList<PendingSyncModel>(HiveKeyConstants.pendingSyncs);

      if (pendingSyncs != null && index < pendingSyncs.length) {
        pendingSyncs.removeAt(index);
        await hiveService.setObjectList(
          HiveKeyConstants.pendingSyncs,
          pendingSyncs,
        );
      }

      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
        Failure(message: 'Failed to remove pending sync: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> clearLocalData() async {
    try {
      await hiveService.remove(HiveKeyConstants.sheets);
      await hiveService.remove(HiveKeyConstants.scansKeyPrefix);
      await hiveService.remove(HiveKeyConstants.pendingSyncs);
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
        Failure(message: 'Failed to clear local data: $e'),
      );
    }
  }

  Future<void> _addPendingSync(
    final String sheetId,
    final String sheetTitle,
    final ScanResultModel scan,
  ) async {
    try {
      // Get existing pending syncs
      final List<PendingSyncModel> existingPendingSyncs =
          hiveService.getObjectList<PendingSyncModel>(
            HiveKeyConstants.pendingSyncs,
          ) ??
          <PendingSyncModel>[];

      // Create new pending sync model
      final PendingSyncModel pendingSync = PendingSyncModel(
        scan: scan,
        sheetId: sheetId,
        sheetTitle: sheetTitle,
      );

      // Add to list
      existingPendingSyncs.add(pendingSync);

      // Save to Hive
      await hiveService.setObjectList(
        HiveKeyConstants.pendingSyncs,
        existingPendingSyncs,
      );
    } catch (e) {
      rethrow;
    }
  }
}
