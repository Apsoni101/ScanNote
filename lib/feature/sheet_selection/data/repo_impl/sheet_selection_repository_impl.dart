import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/data_source/sheet_selection_local_data_source.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/data_source/sheet_selection_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/data/model/paged_sheets_model.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/paged_sheets_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/entity/sheet_entity.dart';
import 'package:qr_scanner_practice/feature/sheet_selection/domain/repo/sheet_selection_repository.dart';

class SheetSelectionRepositoryImpl implements SheetSelectionRepository {
  const SheetSelectionRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  final SheetSelectionLocalDataSource localDataSource;
  final SheetSelectionRemoteDataSource remoteDataSource;

  /// Local operations
  @override
  Future<Either<Failure, List<SheetEntity>>> getLocalSheets() =>
      localDataSource.getLocalSheets();

  @override
  Future<Either<Failure, Unit>> saveSheetLocally(final SheetEntity sheet) =>
      localDataSource.saveSheetLocally(.fromEntity(sheet));

  @override
  Future<Either<Failure, Unit>> cacheScanResult(
    final ScanResultEntity scan,
    final String sheetId,
    final String sheetTitle,
  ) => localDataSource.saveScanResultLocally(
    .fromEntity(scan),
    sheetId,
    sheetTitle,
  );

  @override
  Future<Either<Failure, Unit>> clearLocalSheets() =>
      localDataSource.clearLocalSheets();

  /// Remote operations
  @override
  Future<Either<Failure, PagedSheetsEntity>> getOwnedSheets({
    final String? pageToken,
    final int? pageSize,
  }) async {
    final Either<Failure, PagedSheetsModel> result = await remoteDataSource
        .getOwnedSheets(pageToken: pageToken, pageSize: pageSize);
    return result.fold(Left.new, Right<Failure, PagedSheetsEntity>.new);
  }

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      remoteDataSource.createSheet(sheetName);

  @override
  Future<Either<Failure, Unit>> saveScan(
    final ScanResultEntity entity,
    final String sheetId,
  ) => remoteDataSource.saveScan(.fromEntity(entity), sheetId);
}
