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

abstract class HomeScreenRemoteDataSource {
  Future<Either<Failure, List<SheetModel>>> getOwnedSheets();

  Future<Either<Failure, String>> createSheet(final String sheetName);

  Future<Either<Failure, Unit>> saveScan(
    final ScanResultModel model,
    final String sheetId,
  );

  Future<Either<Failure, List<ScanResultModel>>> read(final String sheetId);

  Future<Either<Failure, Unit>> update(
    final String sheetId,
    final String range,
    final ScanResultModel model,
  );

  Future<Either<Failure, Unit>> delete(
    final String sheetId,
    final String range,
  );
}

class HomeScreenRemoteDataSourceImpl implements HomeScreenRemoteDataSource {
  HomeScreenRemoteDataSourceImpl({
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

  Future<Either<Failure, String?>> _getUserId() async {
    final Either<Failure, String> userIdResult = await authService
        .getCurrentUserId();
    return userIdResult.fold(
      (final Failure _) => const Right<Failure, String?>(null),
      Right<Failure, String?>.new,
    );
  }

  @override
  Future<Either<Failure, List<SheetModel>>> getOwnedSheets() async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
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
            url: NetworkConstants.sheetsBaseUrl,
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
              url: '${NetworkConstants.driveBaseUrl}/$id?fields=properties',
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
    final ScanResultModel model,
    final String sheetId,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String?> userIdResult = await _getUserId();
      return userIdResult.fold(Left.new, (final String? userId) async {
        final ScanResultModel modelWithUserId = model.copyWith(userId: userId);
        return apiClient.request<Unit>(
          url:
              '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${NetworkConstants.appendRange}?valueInputOption=RAW',
          method: HttpMethod.post,
          options: options,
          data: <String, dynamic>{
            'values': <List<dynamic>>[modelWithUserId.toSheetRow()],
          },
          responseParser: (_) => unit,
        );
      });
    });
  }

  @override
  Future<Either<Failure, List<ScanResultModel>>> read(
    final String sheetId,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      return apiClient.request<List<ScanResultModel>>(
        url:
            '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!${AppConstants.readRange}',
        method: HttpMethod.get,
        options: options,
        responseParser: (final Map<String, dynamic> json) {
          final List values = json['values'] as List<dynamic>? ?? <dynamic>[];
          return values
              .map(
                (final e) =>
                    ScanResultModel.fromSheetRow(List<dynamic>.from(e)),
              )
              .toList();
        },
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> update(
    final String sheetId,
    final String range,
    final ScanResultModel model,
  ) async {
    final Either<Failure, Options> authOptions = await _getAuthorizedOptions();
    return authOptions.fold(Left.new, (final Options options) async {
      final Either<Failure, String?> userIdResult = await _getUserId();
      return userIdResult.fold(Left.new, (final String? userId) async {
        final ScanResultModel modelWithUserId = model.copyWith(userId: userId);
        return apiClient.request<Unit>(
          url:
              '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!$range?valueInputOption=RAW',
          method: HttpMethod.put,
          options: options,
          data: <String, dynamic>{
            'values': <List<dynamic>>[modelWithUserId.toSheetRow()],
          },
          responseParser: (_) => unit,
        );
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
            '${NetworkConstants.sheetsBaseUrl}/$sheetId/values/${AppConstants.sheetName}!$range${NetworkConstants.clearRangeSuffix}',
        method: HttpMethod.post,
        options: options,
        responseParser: (_) => unit,
      );
    });
  }
}
