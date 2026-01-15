import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/model/qr_scan_model.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/model/sheet_model.dart';

abstract class HomeScreenLocalDataSource {
  Future<Either<Failure, List<SheetModel>>> getLocalSheets();

  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet);

  Future<Either<Failure, Unit>> saveQrScanLocally(
    final QrScanModel scan,
    final String sheetId,
    final String sheetTitle,
  );

  Future<Either<Failure, List<QrScanModel>>> getLocalQrScans(
    final String sheetId,
  );

  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs();

  Future<Either<Failure, Unit>> removePendingSync(final int index);

  Future<Either<Failure, Unit>> clearLocalData();
}

class HomeScreenLocalDataSourceImpl implements HomeScreenLocalDataSource {
  HomeScreenLocalDataSourceImpl({required this.hiveService});

  final HiveService hiveService;

  static const String _sheetsBoxName = 'qr_sheets';
  static const String _scansBoxName = 'qr_scans';
  static const String _pendingSyncsKey = 'pending_syncs';

  @override
  Future<Either<Failure, List<SheetModel>>> getLocalSheets() async {
    try {
      final List<SheetModel>? sheets = hiveService.getObjectList<SheetModel>(
        _sheetsBoxName,
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
          .getObjectList<SheetModel>(_sheetsBoxName);
      final List<SheetModel> sheets = existingSheets ?? <SheetModel>[];

      final int existingIndex = sheets.indexWhere(
        (final SheetModel s) => s.id == sheet.id,
      );

      if (existingIndex != -1) {
        sheets[existingIndex] = sheet;
      } else {
        sheets.add(sheet);
      }

      await hiveService.setObjectList(_sheetsBoxName, sheets);
      return const Right<Failure, Unit>(unit);
    } catch (e) {
      return Left<Failure, Unit>(
        Failure(message: 'Failed to save sheet locally: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, Unit>> saveQrScanLocally(
    final QrScanModel scan,
    final String sheetId,
    final String sheetTitle,
  ) async {
    try {
      final String scanKey = '${_scansBoxName}_$sheetId';

      final List<QrScanModel>? existingScans = hiveService
          .getObjectList<QrScanModel>(scanKey);
      final List<QrScanModel> scans = existingScans ?? <QrScanModel>[]
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
  Future<Either<Failure, List<QrScanModel>>> getLocalQrScans(
    final String sheetId,
  ) async {
    try {
      final String scanKey = '${_scansBoxName}_$sheetId';
      final List<QrScanModel>? scans = hiveService.getObjectList<QrScanModel>(
        scanKey,
      );
      return Right<Failure, List<QrScanModel>>(scans ?? <QrScanModel>[]);
    } catch (e) {
      return Left<Failure, List<QrScanModel>>(
        Failure(message: 'Failed to fetch local scans: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs() async {
    try {
      final List<PendingSyncModel>? pendingSyncs = hiveService
          .getObjectList<PendingSyncModel>(_pendingSyncsKey);
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
          .getObjectList<PendingSyncModel>(_pendingSyncsKey);

      if (pendingSyncs != null && index < pendingSyncs.length) {
        pendingSyncs.removeAt(index);
        await hiveService.setObjectList(_pendingSyncsKey, pendingSyncs);
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
      await hiveService.remove(_sheetsBoxName);
      await hiveService.remove(_scansBoxName);
      await hiveService.remove(_pendingSyncsKey);
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
    final QrScanModel scan,
  ) async {
    try {
      // Get existing pending syncs
      final List<PendingSyncModel> existingPendingSyncs =
          hiveService.getObjectList<PendingSyncModel>(_pendingSyncsKey) ??
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
      await hiveService.setObjectList(_pendingSyncsKey, existingPendingSyncs);
    } catch (e) {
      rethrow;
    }
  }
}
