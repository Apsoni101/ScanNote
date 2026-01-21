import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/network/constants/network_constants.dart';
import 'package:qr_scanner_practice/core/network/failure.dart';
import 'package:qr_scanner_practice/core/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/network/http_method.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/scan_result_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/data/model/sheet_model.dart';
import 'package:qr_scanner_practice/feature/scan_result/domain/entity/pending_sync_entity.dart';

abstract class ViewScansHistoryRemoteDataSource {
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets();
}

class ViewScansHistoryRemoteDataSourceImpl
    implements ViewScansHistoryRemoteDataSource {
  ViewScansHistoryRemoteDataSourceImpl({
    required this.apiClient,
    required this.authService,
  });

  final HttpApiClient apiClient;
  final FirebaseAuthService authService;

  Future<Either<Failure, Options>> _getAuthorizedOptions() async {
    final Either<Failure, String> tokenResult = await authService
        .getGoogleAccessToken();
    return tokenResult.fold(
      Left.new,
      (final String token) => Right(
        Options(
          headers: <String, dynamic>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      ),
    );
  }

  Future<Either<Failure, List<SheetModel>>> _getOwnedSheets(
    final Options options,
  ) async {
    const String query =
        'mimeType="${NetworkConstants.sheetMimeType}" and "me" in owners and trashed=false';
    final String encodedQuery = Uri.encodeComponent(query);

    return apiClient.request<List<SheetModel>>(
      url:
          '${NetworkConstants.driveBaseUrl}?q=$encodedQuery&fields=${NetworkConstants.sheetFields}&pageSize=${NetworkConstants.pageSize}&orderBy=${NetworkConstants.orderBy}',
      method: HttpMethod.get,
      options: options,
      responseParser: (final Map<String, dynamic> json) {
        final List files = json['files'] as List<dynamic>? ?? <dynamic>[];
        return files
            .where((final f) {
              final String description = f['description']?.toString() ?? '';
              final Map<String, dynamic> properties =
                  f['properties'] as Map<String, dynamic>? ??
                  <String, dynamic>{};
              final String appMark = properties['appCreated']?.toString() ?? '';

              return description.contains(AppConstants.appCreatedLabel) ||
                  appMark == AppConstants.appCreatedLabel;
            })
            .map(
              (final f) => SheetModel(
                id: f['id']?.toString() ?? '',
                title: f['name']?.toString() ?? 'Untitled',
                createdTime: f['createdTime']?.toString(),
                modifiedTime: f['modifiedTime']?.toString(),
              ),
            )
            .toList();
      },
    );
  }

  Future<Either<Failure, List<ScanResultModel>>> _readScansFromSheet(
    String sheetId,
    Options options,
  ) async {
    return apiClient.request<List<ScanResultModel>>(
      url:
          '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${AppConstants.readRange}',
      method: HttpMethod.get,
      options: options,
      responseParser: (final Map<String, dynamic> json) {
        final List values = json['values'] as List<dynamic>? ?? <dynamic>[];
        return values
            .map(
              (final e) => ScanResultModel.fromSheetRow(List<dynamic>.from(e)),
            )
            .toList();
      },
    );
  }

  @override
  Future<Either<Failure, List<PendingSyncEntity>>>
  getAllScansFromAllSheets() async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();

    return await authOptions.fold(
      (final Failure failure) async {
        return Left<Failure, List<PendingSyncEntity>>(failure);
      },
      (final Options options) async {
        /// Get all sheets
        final Either<Failure, List<SheetModel>> sheetsResult =
            await _getOwnedSheets(options);

        return await sheetsResult.fold(
          (final Failure failure) async {
            return Left<Failure, List<PendingSyncEntity>>(failure);
          },
          (final List<SheetModel> sheets) async {
            final List<PendingSyncEntity> allScans = <PendingSyncEntity>[];

            /// For each sheet, fetch all scans
            for (final SheetModel sheet in sheets) {
              final Either<Failure, List<ScanResultModel>> scansResult =
                  await _readScansFromSheet(sheet.id, options);

              scansResult.fold(
                (final Failure _) {
                  /// Continuing even if one sheet fails
                },
                (final List<ScanResultModel> scans) {
                  final List<PendingSyncEntity> sheetScans = scans
                      .map(
                        (final ScanResultModel scan) => PendingSyncEntity(
                          scan: scan.toEntity(),
                          sheetId: sheet.id,
                          sheetTitle: sheet.title,
                        ),
                      )
                      .toList();
                  allScans.addAll(sheetScans);
                },
              );
            }

            allScans.sort(
              (final PendingSyncEntity a, final PendingSyncEntity b) =>
                  b.scan.timestamp.compareTo(a.scan.timestamp),
            );

            return Right<Failure, List<PendingSyncEntity>>(allScans);
          },
        );
      },
    );
  }
}
