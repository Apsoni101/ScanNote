import 'package:dartz/dartz.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/feature/home/data/data_source/home_screen_remote_data_source.dart';
import 'package:qr_scanner_practice/feature/home/domain/repo/home_screen_remote_repository.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/result_scan_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/result_scan_entity.dart';
import 'package:qr_scanner_practice/feature/result_scan/domain/entity/sheet_entity.dart';

class HomeScreenRemoteRepositoryImpl implements HomeScreenRemoteRepository {
  const HomeScreenRemoteRepositoryImpl({required this.remoteDataSource});

  final HomeScreenRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<SheetEntity>>> getOwnedSheets() =>
      remoteDataSource.getOwnedSheets();

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) =>
      remoteDataSource.createSheet(sheetName);

  @override
  Future<Either<Failure, Unit>> saveScan(
    final ResultScanEntity entity,
    final String sheetId,
  ) => remoteDataSource.saveScan(ResultScanModel.fromEntity(entity), sheetId);

  @override
  Future<Either<Failure, List<ResultScanEntity>>> getAllScans(
    final String sheetId,
  ) => remoteDataSource.read(sheetId);

  @override
  Future<Either<Failure, Unit>> updateScan(
    final String sheetId,
    final String range,
    final ResultScanEntity entity,
  ) => remoteDataSource.update(sheetId, range, ResultScanModel.fromEntity(entity));

  @override
  Future<Either<Failure, Unit>> deleteScan(
    final String sheetId,
    final String range,
  ) => remoteDataSource.delete(sheetId, range);
}
