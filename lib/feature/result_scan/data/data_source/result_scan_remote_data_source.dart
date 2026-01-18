import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:qr_scanner_practice/core/constants/app_constants.dart';
import 'package:qr_scanner_practice/core/services/device_info_service.dart';
import 'package:qr_scanner_practice/core/services/firebase/firebase_auth_service.dart';
import 'package:qr_scanner_practice/core/services/network/failure.dart';
import 'package:qr_scanner_practice/core/services/network/http_api_client.dart';
import 'package:qr_scanner_practice/core/services/network/http_method.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/result_scan_model.dart';
import 'package:qr_scanner_practice/feature/result_scan/data/model/sheet_model.dart';

abstract class ResultScanRemoteDataSource {
  Future<Either<Failure, List<SheetModel>>> getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final ResultScanModel model,
    final String sheetId,
  );

  Future<Either<Failure, List<ResultScanModel>>> read(final String sheetId);

  Future<Either<Failure, Unit>> update(
    final String sheetId,
    final String range,
    final ResultScanModel model,
  );

  Future<Either<Failure, Unit>> delete(
    final String sheetId,
    final String range,
  );
}

class ResultScanRemoteDataSourceImpl implements ResultScanRemoteDataSource {
  ResultScanRemoteDataSourceImpl({
    required this.apiClient,
    required this.authService,
    required this.deviceInfoService,
  });

  final HttpApiClient apiClient;
  final FirebaseAuthService authService;
  final DeviceInfoService deviceInfoService;

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

  Future<Either<Failure, String?>> _getUserId() async {
    final Either<Failure, String> userIdResult = await authService
        .getCurrentUserId();
    return userIdResult.fold(
      (final Failure _) => const Right<Failure, String?>(null),
      Right<Failure, String?>.new,
    );
  }

  Future<Either<Failure, String?>> _getDeviceId() async {
    final Either<Failure, String> deviceIdResult = await deviceInfoService
        .getDeviceId();
    return deviceIdResult.fold(
      (final Failure _) => const Right<Failure, String?>(null),
      Right<Failure, String?>.new,
    );
  }

  @override
  Future<Either<Failure, List<SheetModel>>> getOwnedSheets() async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
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
    });
  }

  @override
  Future<Either<Failure, String>> createSheet(final String sheetName) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String> spreadsheetId = await apiClient
          .request<String>(
            url: AppConstants.sheetsBaseUrl,
            method: HttpMethod.post,
            options: options,
            data: <String, dynamic>{
              'properties': <String, dynamic>{'title': sheetName},
              'sheets': <dynamic>[
                <String, dynamic>{
                  'properties': <String, dynamic>{
                    'sheetId': 0,
                    'title': AppConstants.sheetName,
                  },
                  'data': <dynamic>[
                    <String, dynamic>{
                      'rowData': <dynamic>[
                        <String, dynamic>{
                          'values': <dynamic>[
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerTimestamp,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerQrData,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerComment,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerDeviceId,
                              },
                            },
                            <String, dynamic>{
                              'userEnteredValue': <String, dynamic>{
                                'stringValue': AppConstants.headerUserId,
                              },
                            },
                          ],
                        },
                      ],
                    },
                  ],
                },
              ],
            },
            responseParser: (final Map<String, dynamic> json) =>
                json['spreadsheetId']?.toString() ?? '',
          );

      return spreadsheetId.fold(Left.new, (final String id) async {
        final Either<Failure, Unit> updateResult = await apiClient
            .request<Unit>(
              url: '${AppConstants.driveBaseUrl}/$id?fields=properties',
              method: HttpMethod.patch,
              options: options,
              data: <String, dynamic>{
                'properties': <String, dynamic>{
                  'appCreated': AppConstants.appCreatedLabel,
                },
                'description': 'Created by ${AppConstants.appCreatedLabel}',
              },
              responseParser: (_) => unit,
            );
        return updateResult.fold(Left.new, (_) => Right(id));
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> saveScan(
    final ResultScanModel model,
    final String sheetId,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String?> userIdResult = await _getUserId();
      return userIdResult.fold(Left.new, (final String? userId) async {
        final Either<Failure, String?> deviceIdResult = await _getDeviceId();
        return deviceIdResult.fold(Left.new, (final String? deviceId) async {
          final ResultScanModel modelWithIds = model.copyWith(
            userId: userId,
            deviceId: deviceId,
          );
          return apiClient.request<Unit>(
            url:
                '${AppConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${AppConstants.appendRange}?valueInputOption=RAW',
            method: HttpMethod.post,
            options: options,
            data: <String, dynamic>{
              'values': <List<dynamic>>[modelWithIds.toSheetRow()],
            },
            responseParser: (_) => unit,
          );
        });
      });
    });
  }

  @override
  Future<Either<Failure, List<ResultScanModel>>> read(final String sheetId) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      return apiClient.request<List<ResultScanModel>>(
        url:
            '${AppConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${AppConstants.readRange}',
        method: HttpMethod.get,
        options: options,
        responseParser: (final Map<String, dynamic> json) {
          final List values = json['values'] as List<dynamic>? ?? <dynamic>[];
          return values
              .map((final e) => ResultScanModel.fromSheetRow(List<dynamic>.from(e)))
              .toList();
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> update(
    final String sheetId,
    final String range,
    final ResultScanModel model,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String?> userIdResult = await _getUserId();
      return userIdResult.fold(Left.new, (final String? userId) async {
        final Either<Failure, String?> deviceIdResult = await _getDeviceId();
        return deviceIdResult.fold(Left.new, (final String? deviceId) async {
          final ResultScanModel modelWithIds = model.copyWith(
            userId: userId,
            deviceId: deviceId,
          );
          return apiClient.request<Unit>(
            url:
                '${AppConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!$range?valueInputOption=RAW',
            method: HttpMethod.put,
            options: options,
            data: <String, dynamic>{
              'values': <List<dynamic>>[modelWithIds.toSheetRow()],
            },
            responseParser: (_) => unit,
          );
        });
      });
    });
  }

  @override
  Future<Either<Failure, Unit>> delete(
    final String sheetId,
    final String range,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      return apiClient.request<Unit>(
        url:
            '${AppConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!$range${AppConstants.clearRangeSuffix}',
        method: HttpMethod.post,
        options: options,
        responseParser: (_) => unit,
      );
    });
  }
}
