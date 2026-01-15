import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/core/services/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/services/network/http_method.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/model/qr_scan_model.dart';
import 'package:qr_scanner_practice/feature/qr_scan/data/model/sheet_model.dart';
import 'package:qr_scanner_practice/feature/qr_scan/domain/entity/pending_sync_entity.dart';

abstract class HistoryRemoteDataSource {
  Future<Either<Failure, List<PendingSyncEntity>>> getAllScansFromAllSheets();
}

class HistoryRemoteDataSourceImpl implements HistoryRemoteDataSource {
  HistoryRemoteDataSourceImpl({
    required this.apiClient,
    required this.authService,
  });

  final HttpApiClient apiClient;
  final FirebaseAuthService authService;

  Future<Either<Failure, Options>> _getAuthorizedOptions() async {
    final Either<Failure, String> tokenResult =
    await authService.getGoogleAccessToken();
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
      Options options,
      ) async {
    const String query =
        'mimeType="${AppConstants.sheetMimeType}" and "me" in owners and trashed=false';
    final String encodedQuery = Uri.encodeComponent(query);

    return apiClient.request<List<SheetModel>>(
      url:
      '${AppConstants.driveBaseUrl}?q=$encodedQuery&fields=${AppConstants.sheetFields}&pageSize=${AppConstants.pageSize}&orderBy=${AppConstants.orderBy}',
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
          final String appMark =
              properties['appCreated']?.toString() ?? '';

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

  Future<Either<Failure, List<QrScanModel>>> _readScansFromSheet(
      String sheetId,
      Options options,
      ) async {
    return apiClient.request<List<QrScanModel>>(
      url:
      '${AppConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${AppConstants.readRange}',
      method: HttpMethod.get,
      options: options,
      responseParser: (final Map<String, dynamic> json) {
        final List values = json['values'] as List<dynamic>? ?? <dynamic>[];
        return values
            .map((final e) => QrScanModel.fromSheetRow(List<dynamic>.from(e)))
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
        // Step 1: Get all sheets
        final Either<Failure, List<SheetModel>> sheetsResult =
        await _getOwnedSheets(options);

        return await sheetsResult.fold(
              (final Failure failure) async {
            return Left<Failure, List<PendingSyncEntity>>(failure);
          },
              (final List<SheetModel> sheets) async {
            final List<PendingSyncEntity> allScans = <PendingSyncEntity>[];

            // Step 2: For each sheet, fetch all scans
            for (final SheetModel sheet in sheets) {
              final Either<Failure, List<QrScanModel>> scansResult =
              await _readScansFromSheet(sheet.id, options);

              scansResult.fold(
                    (final Failure _) {
                  // Continue even if one sheet fails
                },
                    (final List<QrScanModel> scans) {
                  // Convert to PendingSyncEntity with sheet info
                  final List<PendingSyncEntity> sheetScans = scans
                      .map(
                        (final QrScanModel scan) => PendingSyncEntity(
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

            // Step 3: Sort by timestamp descending (newest first)
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