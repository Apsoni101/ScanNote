import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/data_source/sheets_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/pending_sync_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/qr_scan_entity.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/sheet_entity.dart';

abstract class HistoryRemoteDataSource {
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  HistoryRemoteDataSourceImpl({required this.sheetsRemoteDataSource});

  final SheetsRemoteDataSource sheetsRemoteDataSource;

  @override
  Future<Either<Failure, List<PendingSyncEntity>>>
  getAllScansFromAllSheets() async {
    final Either<Failure, List<SheetEntity>> sheetsResult =
        await sheetsRemoteDataSource.getOwnedSheets();

    return await sheetsResult.fold(
      (final Failure failure) async {
        return Left<Failure, List<PendingSyncEntity>>(failure);
      },
      (final List<SheetEntity> sheets) async {
        final List<PendingSyncEntity> allScans = <PendingSyncEntity>[];

        // Step 2: For each sheet, fetch all scans
        for (final SheetEntity sheet in sheets) {
          final Either<Failure, List<QrScanEntity>> scansResult =
              await sheetsRemoteDataSource.read(sheet.id);

          await scansResult.fold(
            (final Failure _) {
              // Continue even if one sheet fails
            },
            (final List<QrScanEntity> scans) {
              // Convert to PendingSyncEntity with sheet info
              final List<PendingSyncEntity> sheetScans = scans
                  .map(
                    (final QrScanEntity scan) => PendingSyncEntity(
                      scan: scan,
                      sheetId: sheet.id,
                      sheetTitle: sheet.title,
                    ),
                  )
                  .toList();
              allScans.addAll(sheetScans);
            },
          );
        }

        // Step 3: Sort by timestamp descending (newest first)
        allScans.sort(
          (final PendingSyncEntity a, final PendingSyncEntity b) =>
              b.scan.timestamp.compareTo(a.scan.timestamp),
        );

        return Right<Failure, List<PendingSyncEntity>>(allScans);
      },
    );
  }
}
