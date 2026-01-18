import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/core/services/storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/result_scan_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/sheet_model.dart';

abstract class ResultScanLocalDataSource {
  Future<Either<Failure, List<SheetModel>>> getLocalSheets();

  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet);

  Future<Either<Failure, Unit>> saveResultScanLocally(
    final ResultScanModel scan,
    final String sheetId,
    final String sheetTitle,
  );

  Future<Either<Failure, List<ResultScanModel>>> getLocalResultScans(
    final String sheetId,
  );

  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs();

  Future<Either<Failure, Unit>> removePendingSync(final int index);

  Future<Either<Failure, Unit>> clearLocalData();
}

class ResultScanLocalDataSourceImpl implements ResultScanLocalDataSource {
  ResultScanLocalDataSourceImpl({required this.hiveService});

  final HiveService hiveService;

  static const String _sheetsKey = 'qr_sheets';
  static const String _scansKeyPrefix = 'qr_scans';
  static const String _pendingSyncsKey = 'pending_syncs';

  @override
  Future<Either<Failure, List<SheetModel>>> getLocalSheets() async {
    final List<SheetModel>? sheets = hiveService.getObjectList<SheetModel>(
      _sheetsKey,
    );
    return Right<Failure, List<SheetModel>>(sheets ?? <SheetModel>[]);
  }

  @override
  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet) async {
    final List<SheetModel> sheets =
        hiveService.getObjectList<SheetModel>(_sheetsKey) ?? <SheetModel>[];

    final int existingIndex = sheets.indexWhere(
      (final SheetModel s) => s.id == sheet.id,
    );

    if (existingIndex != -1) {
      sheets[existingIndex] = sheet;
    } else {
      sheets.add(sheet);
    }

    await hiveService.setObjectList(_sheetsKey, sheets);
    return const Right<Failure, Unit>(unit);
  }

  @override
  Future<Either<Failure, Unit>> saveResultScanLocally(
    final ResultScanModel scan,
    final String sheetId,
    final String sheetTitle,
  ) async {
    final String scanKey = '${_scansKeyPrefix}_$sheetId';

    final List<ResultScanModel> scans =
        hiveService.getObjectList<ResultScanModel>(scanKey) ?? <ResultScanModel>[]

    ..add(scan);
    await hiveService.setObjectList(scanKey, scans);

    await _addPendingSync(sheetId, sheetTitle, scan);

    return const Right<Failure, Unit>(unit);
  }

  @override
  Future<Either<Failure, List<ResultScanModel>>> getLocalResultScans(
    final String sheetId,
  ) async {
    final String scanKey = '${_scansKeyPrefix}_$sheetId';
    final List<ResultScanModel>? scans = hiveService.getObjectList<ResultScanModel>(
      scanKey,
    );
    return Right<Failure, List<ResultScanModel>>(scans ?? <ResultScanModel>[]);
  }

  @override
  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs() async {
    final List<PendingSyncModel>? pendingSyncs = hiveService
        .getObjectList<PendingSyncModel>(_pendingSyncsKey);
    return Right<Failure, List<PendingSyncModel>>(
      pendingSyncs ?? <PendingSyncModel>[],
    );
  }

  @override
  Future<Either<Failure, Unit>> removePendingSync(final int index) async {
    final List<PendingSyncModel> pendingSyncs =
        hiveService.getObjectList<PendingSyncModel>(_pendingSyncsKey) ??
        <PendingSyncModel>[];

    if (index >= 0 && index < pendingSyncs.length) {
      pendingSyncs.removeAt(index);
      await hiveService.setObjectList(_pendingSyncsKey, pendingSyncs);
    }

    return const Right<Failure, Unit>(unit);
  }

  @override
  Future<Either<Failure, Unit>> clearLocalData() async {
    await hiveService.remove(_sheetsKey);
    await hiveService.remove(_pendingSyncsKey);

    final List<SheetModel> sheets =
        hiveService.getObjectList<SheetModel>(_sheetsKey) ?? <SheetModel>[];

    for (final SheetModel sheet in sheets) {
      await hiveService.remove('${_scansKeyPrefix}_${sheet.id}');
    }

    return const Right<Failure, Unit>(unit);
  }

  Future<void> _addPendingSync(
    final String sheetId,
    final String sheetTitle,
    final ResultScanModel scan,
  ) async {
    final List<PendingSyncModel> existingPendingSyncs =
        hiveService.getObjectList<PendingSyncModel>(_pendingSyncsKey) ??
        <PendingSyncModel>[];

    final PendingSyncModel pendingSync = PendingSyncModel(
      scan: scan,
      sheetId: sheetId,
      sheetTitle: sheetTitle,
    );

    existingPendingSyncs.add(pendingSync);

    await hiveService.setObjectList(_pendingSyncsKey, existingPendingSyncs);
  }
}
