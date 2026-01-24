import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_key_constants.dart';
import 'package:qr_scanner_practice/core/local_storage/hive_service.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/pending_sync_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/sheet_model.dart';

abstract class SheetSelectionLocalDataSource {
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

class SheetSelectionLocalDataSourceImpl
    implements SheetSelectionLocalDataSource {
  SheetSelectionLocalDataSourceImpl({required this.hiveService});

  final HiveService hiveService;

  @override
  Future<Either<Failure, List<SheetModel>>> getLocalSheets() async {
    final List<SheetModel>? sheets = hiveService.getObjectList<SheetModel>(
      HiveKeyConstants.sheets,
    );
    return Right<Failure, List<SheetModel>>(sheets ?? <SheetModel>[]);
  }

  @override
  Future<Either<Failure, Unit>> saveSheetLocally(final SheetModel sheet) async {
    final List<SheetModel> sheets =
        hiveService.getObjectList<SheetModel>(HiveKeyConstants.sheets) ??
        <SheetModel>[];

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
  }

  @override
  Future<Either<Failure, Unit>> saveScanResultLocally(
    final ScanResultModel scan,
    final String sheetId,
    final String sheetTitle,
  ) async {
    final String scanKey = '${HiveKeyConstants.scansKeyPrefix}_$sheetId';

    final List<ScanResultModel> scans =
        hiveService.getObjectList<ScanResultModel>(scanKey) ??
              <ScanResultModel>[]
          ..add(scan);
    await hiveService.setObjectList(scanKey, scans);

    await _addPendingSync(sheetId, sheetTitle, scan);

    return const Right<Failure, Unit>(unit);
  }

  @override
  Future<Either<Failure, List<ScanResultModel>>> getLocalScanResults(
    final String sheetId,
  ) async {
    final String scanKey = '${HiveKeyConstants.scansKeyPrefix}_$sheetId';
    final List<ScanResultModel>? scans = hiveService
        .getObjectList<ScanResultModel>(scanKey);
    return Right<Failure, List<ScanResultModel>>(scans ?? <ScanResultModel>[]);
  }

  @override
  Future<Either<Failure, List<PendingSyncModel>>> getPendingSyncs() async {
    final List<PendingSyncModel>? pendingSyncs = hiveService
        .getObjectList<PendingSyncModel>(HiveKeyConstants.pendingSyncs);
    return Right<Failure, List<PendingSyncModel>>(
      pendingSyncs ?? <PendingSyncModel>[],
    );
  }

  @override
  Future<Either<Failure, Unit>> removePendingSync(final int index) async {
    final List<PendingSyncModel> pendingSyncs =
        hiveService.getObjectList<PendingSyncModel>(
          HiveKeyConstants.pendingSyncs,
        ) ??
        <PendingSyncModel>[];

    if (index >= 0 && index < pendingSyncs.length) {
      pendingSyncs.removeAt(index);
      await hiveService.setObjectList(
        HiveKeyConstants.pendingSyncs,
        pendingSyncs,
      );
    }

    return const Right<Failure, Unit>(unit);
  }

  @override
  Future<Either<Failure, Unit>> clearLocalData() async {
    await hiveService.remove(HiveKeyConstants.sheets);
    await hiveService.remove(HiveKeyConstants.pendingSyncs);

    final List<SheetModel> sheets =
        hiveService.getObjectList<SheetModel>(HiveKeyConstants.sheets) ??
        <SheetModel>[];

    for (final SheetModel sheet in sheets) {
      await hiveService.remove(
        '${HiveKeyConstants.scansKeyPrefix}_${sheet.id}',
      );
    }

    return const Right<Failure, Unit>(unit);
  }

  Future<void> _addPendingSync(
    final String sheetId,
    final String sheetTitle,
    final ScanResultModel scan,
  ) async {
    final List<PendingSyncModel> existingPendingSyncs =
        hiveService.getObjectList<PendingSyncModel>(
          HiveKeyConstants.pendingSyncs,
        ) ??
        <PendingSyncModel>[];

    final PendingSyncModel pendingSync = PendingSyncModel(
      scan: scan,
      sheetId: sheetId,
      sheetTitle: sheetTitle,
    );

    existingPendingSyncs.add(pendingSync);

    await hiveService.setObjectList(
      HiveKeyConstants.pendingSyncs,
      existingPendingSyncs,
    );
  }
}
